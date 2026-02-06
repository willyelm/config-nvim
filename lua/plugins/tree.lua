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

}
