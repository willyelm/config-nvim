local M = {}

-- Tailwind only where a project uses it: a tailwind config (v3) or a
-- package.json that depends on tailwindcss (v4 has no config file).
-- A bare package.json marker started the server in every JS repo.
local function tailwind_root(bufnr, on_dir)
  local root = vim.fs.root(bufnr, {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
  })
  if root then
    return on_dir(root)
  end
  local path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
  for _, pkg in ipairs(vim.fs.find("package.json", { path = path, upward = true, limit = math.huge })) do
    local ok, lines = pcall(vim.fn.readfile, pkg)
    if ok and table.concat(lines, "\n"):find('"tailwindcss"', 1, true) then
      return on_dir(vim.fs.dirname(pkg))
    end
  end
end

local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition,
    vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to reference" }))
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  -- Same formatter chain as format-on-save (conform), not raw LSP formatting.
  vim.keymap.set({ "n", "x" }, "<F3>", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, vim.tbl_extend("force", opts, { desc = "Format file" }))
  vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Execute code action" }))

  -- Buffer-local so they only exist where a server is attached (these used to
  -- be unguarded globals in config/keymaps.lua).
  vim.keymap.set("n", "<leader>rs", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  vim.keymap.set("n", "<leader>ra", function()
    vim.lsp.buf.code_action({ context = { diagnostics = vim.diagnostic.get(0) } })
  end, vim.tbl_extend("force", opts, { desc = "Code actions" }))

  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

function M.setup()
  -- Shared by every server. Neovim merges these over its own defaults, which
  -- already advertise foldingRange, willSave/didSave and watched files.
  vim.lsp.config("*", {
    capabilities = require("setup.cmp").get_lsp_capabilities(),
  })

  -- Treesitter owns highlighting (the colorscheme has no @lsp.* groups).
  -- Semantic tokens arrived after attach and on every edit, repainting the
  -- treesitter colors, so the buffer looked like it loaded twice.
  vim.lsp.semantic_tokens.enable(false)

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("willyelm_lsp_attach", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        on_attach(client, args.buf)
      end
    end,
  })

  vim.lsp.config("vtsls", {
    cmd = { "vtsls", "--stdio" },
    -- Force full-document sync instead of incremental: nvim-ts-autotag and
    -- autopairs fire several small edits per keystroke on JSX tags, which is
    -- a known trigger for incremental-sync desync between the buffer and
    -- tsserver's copy — that desync shows up as bogus "parsing" diagnostics
    -- that only clear on a full restart. Full sync resends the whole buffer
    -- each time, so there's nothing to desync.
    flags = { allow_incremental_sync = false },
    init_options = {
      hostInfo = "neovim",
    },
    -- One tsserver per repo (lockfile), not per package.json in a monorepo;
    -- tsserver still resolves the nearest tsconfig per file.
    root_markers = {
      { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lock", "bun.lockb" },
      ".git",
    },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    settings = {
      vtsls = {
        -- Use the repo's own TypeScript (node_modules) when present, so the
        -- server matches what `tsc` in the project would report.
        autoUseWorkspaceTsdk = true,
      },
      typescript = {
        -- One tsserver serves the whole monorepo; the 3 GB default is what
        -- makes it die mid-session and need :LspRestart.
        tsserver = { maxTsServerMemory = 8192 },
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          parameterNames = { enabled = "all" },
          parameterTypes = { enabled = false },
          variableTypes = { enabled = false },
          propertyDeclarationTypes = { enabled = false },
          functionLikeReturnTypes = { enabled = false },
          enumMemberValues = { enabled = true },
        },
        preferences = {
          importModuleSpecifierPreference = "non-relative",
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
          includeCompletionsWithSnippetText = true,
          includeCompletionsWithInsertText = true,
          providePrefixAndSuffixTextForRename = true,
          allowRenameOfImportPath = true,
        },
      },
    },
  })

  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml" }, ".git" },
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        -- Just the Neovim runtime + luv types. Indexing every plugin on the
        -- runtimepath kept lua_ls busy for seconds on each start.
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
        },
        telemetry = { enable = false },
      },
    },
  })

  vim.lsp.config("biome", {
    cmd = { "biome", "lsp-proxy" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "biome.json", "biome.jsonc" },
    -- Only in projects that configure biome; otherwise it lints every JS/TS
    -- file with its defaults. Formatting goes through conform.
    workspace_required = true,
    flags = { allow_incremental_sync = false },
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })

  vim.lsp.config("cssls", {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    settings = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  })

  vim.lsp.config("tailwindcss", {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_dir = tailwind_root,
    settings = {
      tailwindCSS = {
        validate = true,
        classFunctions = { "cva", "cx", "clsx", "cn", "tw" },
      },
    },
  })

  vim.lsp.config("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json" },
    settings = {
      json = {
        validate = { enable = true },
        schemaDownload = { enable = true },
      },
    },
  })

  vim.lsp.config("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    settings = {
      yaml = {
        validate = true,
        hover = true,
        completion = true,
        format = { enable = true },
        schemaStore = {
          enable = true,
        },
      },
    },
  })

  vim.lsp.config("marksman", {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "mdx" },
    root_markers = { ".marksman.toml", ".git" },
  })

  vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { { "go.work" }, { "go.mod" }, ".git" },
    flags = { allow_incremental_sync = false },
    settings = {
      gopls = {
        usePlaceholders = true,
        staticcheck = true,
      },
    },
  })

  vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  })

  vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
  })

  vim.lsp.enable({
    "vtsls",
    "lua_ls",
    "biome",
    "cssls",
    "tailwindcss",
    "jsonls",
    "yamlls",
    "gopls",
    "marksman",
    "clangd",
    "pyright",
  })
end

return M
