local M = {}

-- Only real files get a saved view (folds + cursor).
local function has_view(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  return vim.bo[buf].buftype == "" and vim.bo[buf].filetype ~= "" and vim.fn.filereadable(name) == 1
end

function M.setup()
  -- Treesitter folds only: they exist as soon as the buffer is parsed. LSP
  -- folding ranges arrive later and swapping foldexpr on attach recomputed
  -- (and reset) folds mid-edit.
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.viewoptions = { "folds", "cursor" }

  local group = vim.api.nvim_create_augroup("willyelm_folding", { clear = true })

  -- Save/restore fold and cursor state per file across sessions.
  vim.api.nvim_create_autocmd("BufWinLeave", {
    group = group,
    callback = function(args)
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
      -- Views also store the fold options; heal stale ones (manual, or the
      -- old LSP foldexpr) without touching up-to-date windows.
      if vim.wo.foldmethod ~= "expr" then
        vim.wo.foldmethod = "expr"
      end
      if vim.wo.foldexpr ~= vim.go.foldexpr then
        vim.wo.foldexpr = vim.go.foldexpr
      end
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
