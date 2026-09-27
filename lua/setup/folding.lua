local M = {}

-- Expr folding for every window showing `buf`: LSP folding ranges when an
-- attached server supports them (mirrors :h lsp.foldexpr()), treesitter
-- otherwise. `skip_client` is a client that is detaching but still listed.
-- Options are only written when they change: setting them recomputes folds.
local function set_foldexpr(buf, skip_client)
  local lsp = false
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf, method = "textDocument/foldingRange" })) do
    lsp = lsp or client.id ~= skip_client
  end
  local expr = lsp and "v:lua.vim.lsp.foldexpr()" or "v:lua.vim.treesitter.foldexpr()"
  -- LspAttach can fire while another window (a picker, another split) is
  -- current, so never assume the current window shows `buf`.
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    local wo = vim.wo[win][0]
    if wo.foldmethod ~= "expr" then
      wo.foldmethod = "expr"
    end
    if wo.foldexpr ~= expr then
      wo.foldexpr = expr
    end
  end
end

-- Only real files get a saved view (folds + cursor).
local function has_view(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  return vim.bo[buf].buftype == "" and vim.bo[buf].filetype ~= "" and vim.fn.filereadable(name) == 1
end

function M.setup()
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.viewoptions = { "folds", "cursor" }

  local group = vim.api.nvim_create_augroup("willyelm_folding", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(args)
      set_foldexpr(args.buf)
    end,
  })

  -- A stopped or crashed server leaves lsp.foldexpr() with no ranges, which
  -- looks like folding broke; drop back to treesitter until one reattaches.
  vim.api.nvim_create_autocmd("LspDetach", {
    group = group,
    callback = function(args)
      set_foldexpr(args.buf, args.data.client_id)
    end,
  })

  -- Save/restore fold and cursor state per file across sessions.
  vim.api.nvim_create_autocmd("BufWinLeave", {
    group = group,
    callback = function(args)
      -- Never persist a manual foldmethod; restoring it disables expr folding.
      if has_view(args.buf) and vim.wo.foldmethod == "expr" then
        pcall(vim.cmd.mkview, { mods = { emsg_silent = true } })
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function(args)
      if not has_view(args.buf) then
        return
      end
      pcall(vim.cmd.loadview, { mods = { emsg_silent = true } })
      -- Heal views saved with foldmethod=manual (or a stale foldexpr).
      set_foldexpr(args.buf)
    end,
  })

  -- za/zR/zM/zr/zm are native fold commands already; only this needs mapping.
  vim.keymap.set("n", "<leader>K", function()
    if vim.fn.foldclosed(".") ~= -1 then
      vim.cmd("normal! zv")
    else
      vim.lsp.buf.hover({ border = "rounded" })
    end
  end, { desc = "Open fold / hover" })
end

return M
