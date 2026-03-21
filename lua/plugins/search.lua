return {
	-- Discovery
	{
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	dependencies = {
		opts = {
			defaults = {
				winblend = 0,
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					width = 0.85,
					height = 0.80,
					preview_cutoff = 100,
				},
				sorting_strategy = "ascending",
				border = true,
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("undo")
			vim.opt.undofile = true
			vim.opt.undolevels = 10000
			vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
		end,
		keys = {
			-- Undo
			{ "<leader>u", "<cmd>Telescope undo<cr>", desc = "Undo History" },
			-- Git
			{ "<leader>gh", "<cmd>Telescope git_bcommits<cr>", desc = "File History" },
			{ "<leader>gH", "<cmd>Telescope git_commits<cr>", desc = "Project History" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
			{ "<leader>gs", "<cmd>Telescope git_stash<cr>", desc = "Stash" },
			{
				"<leader>gB",
				function()
					require("telescope.builtin").git_branches({
						attach_mappings = function(_, map)
							map("i", "<CR>", function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.cmd("DiffviewOpen main.." .. selection.value)
							end)
							return true
						end,
					})
				end,
				desc = "Diff Branch",
			},
			-- Command Palette
			{ "<leader>k", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		},
	},
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
			height = 0.9,
			width = 0.6,
			navigators = {
				files = {
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
			{ "<leader>l", "<cmd>Pulse live_grep<cr>", desc = "Live Grep (Pulse)" },
			{ "<leader>f", "<cmd>Pulse fuzzy_search<cr>", desc = "Fuzzy Search(Pulse)" },
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
