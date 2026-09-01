local M = {}

local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition,
    vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to reference" }))
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  vim.keymap.set({ "n", "x" }, "<F3>", function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend("force", opts, { desc = "Format file" }))
  vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Execute code action" }))

  -- Buffer-local so they only exist where a server is attached (these used to
  -- be unguarded globals in config/keymaps.lua).
  vim.keymap.set("n", "<leader>rs", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  vim.keymap.set("n", "<leader>ra", function()
    vim.lsp.buf.code_action({ context = { diagnostics = vim.diagnostic.get(0) } })
  end, vim.tbl_extend("force", opts, { desc = "Code actions" }))

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

function M.setup()
  local capabilities = require("setup.cmp").get_lsp_capabilities()
  capabilities.textDocument = capabilities.textDocument or {}
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  capabilities.textDocument.synchronization = {
    didSave = true,
    willSave = true,
    willSaveWaitUntil = true,
  }
  capabilities.workspace = capabilities.workspace or {}
  capabilities.workspace.didChangeWatchedFiles = {
    dynamicRegistration = true,
    relativePatternSupport = true,
  }

  vim.lsp.config("vtsls", {
    cmd = { "vtsls", "--stdio" },
    init_options = {
      hostInfo = "neovim",
    },
    root_markers = { "package.json", "tsconfig.json", ".git" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    settings = {
      typescript = {
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
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config("biome", {
    cmd = { "biome", "lsp-proxy" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "biome.json", "biome.jsonc" },
    single_file_support = true,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    capabilities = capabilities,
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
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config("tailwindcss", {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = {
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      "package.json",
    },
    settings = {
      tailwindCSS = {
        validate = true,
        classFunctions = { "cva", "cx", "clsx", "cn", "tw" },
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
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
    on_attach = on_attach,
    capabilities = capabilities,
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
          url = "",
        },
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    sync_kind = "full",
    settings = {
      gopls = {
        usePlaceholders = true,
        staticcheck = true,
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.enable("vtsls")
  vim.lsp.enable("lua_ls")
  vim.lsp.enable("biome")
  vim.lsp.enable("cssls")
  vim.lsp.enable("tailwindcss")
  vim.lsp.enable("jsonls")
  vim.lsp.enable("yamlls")
  vim.lsp.enable("gopls")
end

return M
