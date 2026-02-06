-- Toggle Comments
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comment selection" })
-- Command Palette
vim.keymap.set("n", "<leader>p", function()
  require('telescope.builtin').commands(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Command Palette" })
