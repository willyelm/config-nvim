local M = {}

-- Native LSP keys cover the rest (0.12): K hover, grn rename, gra code
-- action, grr references, gri implementation, grt type definition, gO symbols.
local function on_attach(client, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  -- Same formatter chain as format-on-save (conform), not raw LSP formatting.
  map({ "n", "x" }, "<F3>", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, "Format file")

  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

-- Servers that die (tsserver OOM, biome crash) come back on their own instead
-- of leaving buffers silently without LSP until :lsp restart. Re-firing the
-- FileType autocmd of vim.lsp.enable() reattaches exactly the configured
-- servers. Capped so a server that crashes on startup doesn't loop.
local restarts = {} ---@type table<string, number[]>

local function on_crash(code, signal, client_id)
  if code == 0 and signal == 0 then
    return -- clean shutdown (:lsp stop, quit)
  end
  local client = vim.lsp.get_client_by_id(client_id)
  local name = client and client.name or "?"
  local now = vim.uv.now()
  local recent = vim.tbl_filter(function(t)
    return now - t < 60000
  end, restarts[name] or {})
  if #recent >= 3 then
    vim.schedule(function()
      vim.notify(("%s crashed 3 times in a minute; not restarting"):format(name), vim.log.levels.ERROR)
    end)
    return
  end
  table.insert(recent, now)
  restarts[name] = recent
  vim.defer_fn(function()
    vim.notify(("%s exited (code %d); restarting"):format(name, code), vim.log.levels.WARN)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
        pcall(vim.api.nvim_exec_autocmds, "FileType", { group = "nvim.lsp.enable", buffer = buf })
      end
    end
  end, 500)
end

function M.setup()
  -- Shared by every server. Neovim merges these over its own defaults, which
  -- already advertise foldingRange, willSave/didSave and watched files.
  vim.lsp.config("*", {
    capabilities = require("setup.cmp").get_lsp_capabilities(),
    on_exit = on_crash,
  })

  -- Treesitter owns highlighting (the colorscheme has no @lsp.* groups).
  -- Semantic tokens arrived after attach and on every edit, repainting the
  -- treesitter colors, so the buffer looked like it loaded twice.
  vim.lsp.semantic_tokens.enable(false)

  -- Typing in an open or close tag renames its pair (vtsls for JSX/TSX, html
  -- for HTML); applies to every server that advertises linkedEditingRange.
  vim.lsp.linked_editing_range.enable(true)

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("willyelm_lsp_attach", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        on_attach(client, args.buf)
      end
    end,
  })

  -- Server configs live in lsp/<name>.lua (picked up from the runtimepath).
  vim.lsp.enable({
    "vtsls",
    "lua_ls",
    "biome",
    "html",
    "cssls",
    "css_variables",
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
