return {
	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		opts = {
			default = true,
			strict = true,
			color_icons = true,
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
			local theme = require("lualine.themes.auto")

			theme.normal.c.bg = "NONE"
			theme.insert.c.bg = "NONE"
			theme.visual.c.bg = "NONE"
			theme.command.c.bg = "NONE"
			theme.inactive.c.bg = "NONE"

			return {
				options = {
					globalstatus = true,
					theme = theme,
					-- section_separators = { left = "", right = "" },
					component_separators = { left = "/", right = "/" },
				},
				sections = {
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_x = {
						{
							"filesize",
							cond = function()
								return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
							end,
						},
						"encoding",
						"fileformat",
					},
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
					width = 28,
					side = "right",
				},
				renderer = {
					group_empty = true,
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
				filesystem_watchers = {
					enable = true,
				},
				filters = {
					dotfiles = false,
					custom = { "^.git$", ".DS_Store" },
				},
				git = {
					enable = true,
					ignore = false,
				},
				update_focused_file = {
					enable = true,
				},
				modified = {
					enable = true,
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
			{ "<leader>X", "<cmd>bufdo bd<cr>", desc = "Close All" },
		},
	},
	-- Scrollbar with git and diagnostic indicators
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		opts = {
			show = true,
			handlers = {
				gitsigns = true,
				diagnostic = true,
			},
		},
	},
	-- Colorizer
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "css", "scss", "javascript", "typescriptreact", "html", "json", "lua", "markdown" },
			options = {
				parsers = {
					css_fn = true,
					css = true,
					names = { enable = false },
					tailwind = { enable = true, lsp = true, update_names = true },
				},
				display = {
					mode = "background",
				},
			},
		},
	},
}
