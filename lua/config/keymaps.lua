-- Save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save All Files" })
-- Toggle Comment
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comment selection" })
-- Command Palette
vim.keymap.set("n", "<leader>P", "<cmd>Telescope keymaps<cr>", { desc = "Search Keymaps" })
vim.keymap.set("n", "<leader>p", function()
  require('telescope.builtin').commands(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Command Palette" })
