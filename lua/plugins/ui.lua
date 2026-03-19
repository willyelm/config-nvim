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
	-- {
	-- 	"famiu/bufdelete.nvim",
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		{ "<leader>x", "<cmd>Bdelete<cr>", desc = "Close Buffer" },
	-- 		{ "<leader>X", "<cmd>bufdo bd<cr>", desc = "Close All" },
	-- 	},
	-- },
	-- Scrollbar with git and diagnostic indicators
	-- {
	-- 	"petertriho/nvim-scrollbar",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"lewis6991/gitsigns.nvim",
	-- 	},
	-- 	opts = {
	-- 		show = true,
	-- 		handlers = {
	-- 			gitsigns = true,
	-- 			diagnostic = true,
	-- 		},
	-- 	},
	-- },
	-- Colorizer
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup({
				filetypes = {
					"css",
					"scss",
					"javascript",
					"typescriptreact",
					"go",
					"html",
					"json",
					"yml",
					"lua",
					"markdown",
				},
				options = {
					parsers = {
						css_fn = true,
						css = true,
						names = { enable = false },
						tailwind = { enable = true, lsp = true, update_names = true },
						custom = {
							{
								name = "oklch",
								prefixes = { "Oklch" },
								parse = function(ctx)
									local start, end_pos, l, c, h = ctx.line:find(
										"Oklch%s*%(%s*([%d.]+)%s*,%s*([%d.]+)%s*,%s*([%d.]+)%s*%)",
										ctx.col
									)
									if not start then
										return
									end
									l, c, h = tonumber(l), tonumber(c), tonumber(h)
									if not l or not c or not h then
										return
									end
									if l > 1 then
										l = l / 100
									end
									h = h * (math.pi / 180)
									local a, b = c * math.cos(h), c * math.sin(h)
									local l_, m_, s_ =
										l + 0.3963377774 * a + 0.2158037573 * b,
										l - 0.1055613458 * a - 0.0638541728 * b,
										l - 0.0894841775 * a - 1.2914855480 * b
									local l3, m3, s3 = l_ * l_ * l_, m_ * m_ * m_, s_ * s_ * s_
									local r, g, b_out =
										4.0767416621 * l3 - 3.3077363322 * m3 + 0.2309101289 * s3,
										-1.2684380046 * l3 + 2.6097574011 * m3 - 0.3413193761 * s3,
										-0.0041960863 * l3 - 0.7034186147 * m3 + 1.7076147010 * s3
									local gamma = function(v)
										return v <= 0.0031308 and 12.92 * v or 1.055 * v ^ (1 / 2.4) - 0.055
									end
									r, g, b_out =
										math.max(0, math.min(1, gamma(r))),
										math.max(0, math.min(1, gamma(g))),
										math.max(0, math.min(1, gamma(b_out)))
									return end_pos - start + 1,
										string.format(
											"%02x%02x%02x",
											math.floor(r * 255),
											math.floor(g * 255),
											math.floor(b_out * 255)
										)
								end,
							},
						},
					},
					display = {
						mode = "background",
					},
				},
			})
		end,
	},
}
