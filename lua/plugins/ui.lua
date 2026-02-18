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
			-- lead_custom_section = function()
			-- 	local mode_map = {
			-- 		["n"] = " NORMAL ",
			-- 		["i"] = " INSERT ",
			-- 		["v"] = " VISUAL ",
			-- 		["V"] = " V-LINE ",
			-- 		["c"] = " COMMAND ",
			-- 		["R"] = " REPLACE ",
			-- 		["t"] = " TERMINAL ",
			-- 	}
			-- 	local mode = vim.api.nvim_get_mode().mode
			-- 	return mode_map[mode] or mode
			-- end,
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
				-- winbar = {
				-- 	lualine_a = { "mode" },
				-- 	lualine_b = { "filename" },
				-- },
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
					width = 30,
					side = "right",
				},
				-- sync_root_with_cwd = true,
				-- respect_buf_cwd = true,
				-- diagnostics = {
				--   enable = true,
				-- },
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
	-- Colorizer
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "css", "scss", "javascript", "typescriptreact", "html", "json", "lua", "markdown" },
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = false,
				RRGGBBAA = true,
				tailwind = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "background",
			},
		},
	},
}
