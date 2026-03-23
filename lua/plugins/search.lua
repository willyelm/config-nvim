return {
	-- Search/Replace
	{
		"MagicDuck/grug-far.nvim",
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
		lazy = false,
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
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
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
