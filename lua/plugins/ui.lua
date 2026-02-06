return {    
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
