return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
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
		},
		keys = {
			{ "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff File" },
			{ "<leader>gr", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset File" },
		},
	},
}
