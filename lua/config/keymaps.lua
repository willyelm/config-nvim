-- LSP
vim.keymap.set("n", "<leader>rs", vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.buf.document_highlight()
	vim.api.nvim_create_autocmd("CursorMoved", {
		once = true,
		callback = vim.lsp.buf.clear_references,
	})
end, { desc = "Highlight similar words (Manual)" })

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
--
-- vim.keymap.set("n", "K", function()
-- 	local float_settings = {
-- 		border = "rounded",
-- 		wrap = true,
-- 		max_width = 60,
-- 	}
-- 	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
-- 	if diagnostics[1] then
-- 		local diagnostic_settings = vim.tbl_extend("force", {
-- 			focusable = false,
-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
-- 			source = "always",
-- 		}, float_settings)
--
-- 		vim.diagnostic.open_float(nil, diagnostic_settings)
-- 	else
-- 		vim.lsp.buf.hover(float_settings)
-- 	end
-- end, { desc = "Show diagnostics or hover info" })

-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:write<CR>", { desc = "Save Changes" })

-- NvimTree
vim.keymap.set("n", "<leader><Tab>", "<C-w>w", { desc = "Next window" })
vim.keymap.set("n", "<leader>\\", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Explorer" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Copy Location
vim.keymap.set("n", "<leader>l", function()
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
