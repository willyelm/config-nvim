-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:write<CR>", { desc = "Save Changes" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save All Files" })
-- Toggle Comment
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comment selection" })
