return {
	-- Search/Replace
	{
		"MagicDuck/grug-far.nvim",
		main = "grug-far",
		opts = { headerMaxWidth = 80 },
		keys = {
			{
				"<leader>sr",
				function()
					require("grug-far").open()
				end,
				desc = "Search & Replace",
			},
		},
	},
	-- Quick Navigation
	{
		-- dir = "~/Code/pulse.nvim",
		"willyelm/pulse.nvim",
		main = "pulse",
		start = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			cmdline = true,
			position = "top",
			height = 0.90,
			width = 0.75,
			navigators = {
				files = {
					compact_dirs = true,
					open_on_directory = true,
					icons = true,
					filters = { "^%.git$", "%.DS_Store$" },
					git = {
						enable = true,
						ignore = true,
					},
				},
			},
		},
		keys = {
			{ "<leader>p", "<cmd>Pulse<cr>", desc = "Pulse" },
			{ "<leader>l", "<cmd>Pulse live_grep<cr>", desc = "Live Grep" },
			{ "<leader>f", "<cmd>Pulse fuzzy_search<cr>", desc = "Fuzzy Search" },
			{ "<leader>o", "<cmd>Pulse files_open<cr>", desc = "Open Buffers" },
			{ "<leader>gs", "<cmd>Pulse git_status<cr>", desc = "Status" },
			{ "<leader>gc", "<cmd>Pulse git_project_history<cr>", desc = "Project History" },
			{ "<leader>gh", "<cmd>Pulse git_file_history<cr>", desc = "File History" },
		},
	},
	{
		"folke/which-key.nvim",
		defer = true,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			win = {
				border = "rounded",
			},
			icons = {
				mappings = false,
				rules = false,
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.add({
				{ "<leader>s", group = "Search & Replace" },
				{ "<leader>g", group = "Git" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>r", group = "Refactor" },
			})
		end,
	},
}
