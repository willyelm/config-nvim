return {
	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		opts = {
			default = true,
			strict = true,
			color_icons = false,
			icons = true,
		},
	},
	-- Breadcrumbs (Winbar)
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
		opts = {
			theme = "auto",
			show_modified = true,
			show_dirname = true,
			show_basename = true,
			symbols = { separator = "/", modified = "*", ellipsis = "..." },
		},
	},
	-- Statusline with Git Branch and LSP status
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local custom_auto = require("lualine.themes.auto")

			custom_auto.normal.c.bg = "NONE"
			custom_auto.insert.c.bg = "NONE"
			custom_auto.visual.c.bg = "NONE"
			custom_auto.command.c.bg = "NONE"
			custom_auto.inactive.c.bg = "NONE"

			return {
				options = {
					globalstatus = true,
					theme = custom_auto,
					-- section_separators = { left = "", right = "" },
					component_separators = { left = "/", right = "/" },
				},
				sections = {
					lualine_b = { "branch", "diff", "diagnostics" },
				},
			}
		end,
	},
	-- File Explorer
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 30,
					side = "right",
				},
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					-- update_root = true,
				},
				renderer = {
					highlight_git = true,
					highlight_opened_files = "all",
					add_trailing = true,
					indent_markers = {
						enable = true,
					},
					icons = {
						show = {
							file = false,
							folder_arrow = false,
							git = true,
						},
						webdev_colors = false,
						git_placement = "right_align",
						glyphs = {
							git = {
								unstaged = "~",
								staged = "+",
								unmerged = "!",
								renamed = "r",
								untracked = "?",
								deleted = "-",
								ignored = "i",
							},
						},
					},
				},
				filters = {
					dotfiles = false,
					custom = { "^.git$", ".DS_Store" },
					-- custom = { "^.git$" },
					-- exclude = { ".env", ".gitignore" },
				},
				git = {
					enable = true,
					ignore = false,
				},
			})
		end,
	},
	-- Buffer
	{
		"famiu/bufdelete.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>x", "<cmd>Bdelete<cr>", desc = "Close Buffer" },
			{ "<leader>X", "<cmd>Bdelete!<cr>", desc = "Close Buffer (Force)" },
		},
	},
}
