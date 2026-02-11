vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
--vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Documentation" })
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { noremap = true, silent = true })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, {
	desc = "Show line diagnostics",
	silent = true,
})
-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:write<CR>", { desc = "Save Changes" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save All Files" })

-- Toggle Comment
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comment selection" })

-- NvimTree
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit Window" })
-- vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "Focus Explorer" })
vim.keymap.set("n", "<leader>\\", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Explorer" })
vim.keymap.set("n", "<leader>a", "<C-w>p", { desc = "Alternate Window Focus" })
