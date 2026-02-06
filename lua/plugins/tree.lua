return {
-- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function() require("nvim-tree").setup({
      view = {
        width = 30,
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
          webdev_colors = false, -- Disables icon colors
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
