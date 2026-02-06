return {    
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      default = true,
      strict = true,
      color_icons = false,
      icons = true,
    }
  },
  -- Breadcrumbs (Winbar)
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    opts = {
      show_modified = true, 
      show_dirname = true,
      show_basename = true,
      symbols = { separator = "/", modified = "*", ellipsis = "..." },
    },
  },
  -- Statusline with Git Branch and LSP status
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = "auto",
        component_separators = "|",
        section_separators = "",     
      },
      sections = {
        lualine_b = {'branch', 'diff', 'diagnostics'},
      }
    }
  },
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function() require("nvim-tree").setup({
      view = {
        width = 30,
        side = "right",
      },
      renderer = {
        add_trailing = true,       
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
          webdev_colors = false,        
          show = {
            git = false,
            folder_arrow = false,
          },            
        },
      },
      filters = {
        dotfiles = false      
      }, 	
    }) end,
  },	 
}
