require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▁" },
    topdelete = { text = "▔" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  auto_attach = true,
  signcolumn = true,
  current_line_blame = true,
  word_diff = false,
  watch_gitdir = {
    follow_files = true,
  },
})
-- keymaps
vim.keymap.set("n", "<leader>gd", function()
  require("review_diff").open()
end, { desc = "Diff File" })
vim.keymap.set("n", "<leader>gD", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff File (split)" })
vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset File" })
