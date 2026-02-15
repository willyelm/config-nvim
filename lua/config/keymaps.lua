-- Refactor
vim.keymap.set("n", "<leader>rs", vim.lsp.buf.rename, { desc = "Rename Symbol" })

-- Hovers
-- vim.keymap.set("n", "K", function()
--   vim.lsp.buf.hover({
--     border = "rounded",
--     wrap = true,
--     max_width = 60,
--   })
-- end, {
--   noremap = true,
--   desc = "Hover Documentation",
--   silent = true,
-- })
-- vim.keymap.set("n", "gl", vim.diagnostic.open_float, {
--   desc = "Show line diagnostics",
--   silent = true,
-- })

vim.keymap.set('n', 'K', function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })

  if diagnostics[1] then
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
      border = 'rounded',
      source = 'always',
      wrap = true,
      max_width = 80,
    })
  else
    vim.lsp.buf.hover({
      border = "rounded",
      wrap = true,
      max_width = 80,
    })
  end
end, { desc = "Show diagnostics or hover info" })

-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:write<CR>", { desc = "Save Changes" })
--vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
--vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save All Files" })

-- Toggle Comment
-- vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comment line" })
-- vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comment selection" })

-- NvimTree
vim.keymap.set("n", "<leader><Tab>", "<C-w>w", { desc = "Next window" })
vim.keymap.set("n", "<leader>\\", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Explorer" })

-- Terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
