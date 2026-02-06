return {
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function() require("nvim-tree").setup({
      view = {
        width = 35,
        side = "right",
      },
      renderer = {
        add_trailing = true, -- Adds a '/' to folder names for clarity
        indent_markers = {
          enable = true,
          inline_arrows = false,
          icons = {
            corner = "└ ",
            edge = "│ ",
            item = "├ ",
            bottom = "─ ",
            none = "  ",
          },
        },
        icons = {
          show = { file = false, folder = false, folder_arrow = false, git = false },
          glyphs = {
            folder = {
              arrow_closed = "[+]", -- Modern state indicators
              arrow_open = "[-]",
            },
            git = {
              unstaged = "*",
              staged = "+",
              unmerged = "=",
              renamed = ">",
              untracked = "?",
              deleted = "x",
              ignored = ".",
            },
          },
        },
      },
      filters = {
        dotfiles = false      
      }, 	
    }) end,
  },	
  -- Breadcrumbs (Winbar)
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic" },
    opts = {
        show_modified = true, -- Crucial for tracking unsaved state
	show_navic_icon = false,
        symbols = { separator = "/", modified = "*", ellipsis = "..." },
    },
  },
  -- Statusline with Git Branch and LSP status
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        --icons_enabled = false,
        component_separators = "|",
        section_separators = "",     
      },
      sections = {
        lualine_b = {'branch', 'diff', 'diagnostics'},
      }
    }
  }
}
