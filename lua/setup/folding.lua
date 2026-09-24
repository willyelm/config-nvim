local M = {}

function M.setup()
  -- Native treesitter folding, upgraded to LSP folding ranges per-buffer
  -- when the attached server supports them (mirrors :h lsp.foldexpr()).
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("willyelm_lsp_fold", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client:supports_method("textDocument/foldingRange") then
        vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
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

  M.persist_views()
end

-- Save/restore fold (and cursor) state per file across sessions.
function M.persist_views()
  vim.opt.viewoptions = { "folds", "cursor" }

  local group = vim.api.nvim_create_augroup("willyelm_fold_view", { clear = true })

  local function eligible(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    return vim.bo[buf].buftype == ""
      and vim.bo[buf].filetype ~= ""
      and name ~= ""
      and vim.fn.filereadable(name) == 1
  end

  vim.api.nvim_create_autocmd("BufWinLeave", {
    group = group,
    callback = function(args)
      if eligible(args.buf) then
        pcall(vim.cmd.mkview, { mods = { emsg_silent = true } })
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function(args)
      if eligible(args.buf) then
        pcall(vim.cmd.loadview, { mods = { emsg_silent = true } })
      end
    end,
  })
end

return M
