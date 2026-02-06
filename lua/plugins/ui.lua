return {    
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      default = true,
      strict = true,
      color_icons = false,
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
        symbols = { separator = "/", modified = "*", ellipsis = "..." },
    },
  },
  -- Statusline with Git Branch and LSP status
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = "auto",
        --icons_enabled = false,
        component_separators = "|",
        section_separators = "",     
      },
      sections = {
        lualine_b = {'branch', 'diff', 'diagnostics'},
      }
    }
  },
  
}
