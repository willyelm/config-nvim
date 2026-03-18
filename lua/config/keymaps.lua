-- LSP
vim.keymap.set("n", "<leader>ra", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("n", "<leader>rs", vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.buf.document_highlight()
	vim.api.nvim_create_autocmd("CursorMoved", {
		once = true,
		callback = vim.lsp.buf.clear_references,
	})
end, { desc = "Highlight words" })

-- Move Text
vim.keymap.set("v", "<leader>.", ">gv", { desc = "Increase indent" })
vim.keymap.set("v", "<leader>,", "<gv", { desc = "Decrease indent" })
vim.keymap.set("n", "<M-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<M-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("v", "<M-Down>", ":m '>+1<cr>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "<M-Up>", ":m '<-2<cr>gv=gv", { desc = "Move block up" })

-- Hovers
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({
		border = "rounded",
		wrap = true,
		max_width = 60,
	})
end, {
	noremap = true,
	desc = "Hover Documentation",
	silent = true,
})
vim.keymap.set("n", "gl", vim.diagnostic.open_float, {
	desc = "Show line diagnostics",
	silent = true,
})

-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:write<CR>", { desc = "Save Changes" })

-- NvimTree
vim.keymap.set("n", "<leader><Tab>", "<C-w>w", { desc = "Next window" })
vim.keymap.set("n", "<leader>\\", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Explorer" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Copy Location
vim.keymap.set("n", "<leader>c", function()
	local path = vim.fn.expand("%")
	local line = vim.fn.line(".")
	local coordinates = path .. ":" .. line
	vim.fn.setreg("+", coordinates)
	print("Copied: " .. coordinates)
end, { desc = "Copy location" })

-- Toggle Comments
vim.keymap.set({ "n", "v" }, "<leader>/", function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == "v" or mode == "V" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>gvgc", true, false, true), "m", false)
	else
		vim.api.nvim_feedkeys("gcc", "m", false)
	end
end, { desc = "Toggle comment" })
