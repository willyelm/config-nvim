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
      -- show_navic = true,
      theme = "auto",
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
        globalstatus = true,
        theme = "auto",
      },
      sections = {
        lualine_b = { 'branch', 'diff', 'diagnostics' },
      }
    }
  },
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>\\", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Explorer" },
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "right",
        },
        renderer = {
          highlight_git = true,
          highlight_opened_files = "all",
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
            show = {
              file = false,
              folder_arrow = false,
            },
            webdev_colors = false,
            git_placement = "after",
            glyphs = {
              git = {
                unstaged = "ᵐ",
                staged = "ˢ",
                unmerged = "!",
                renamed = "ʳ",
                untracked = "ᵁ",
                deleted = "ˣ",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { "^.git$" },
          exclude = { ".env", ".gitignore" },
        },
        git = {
          ignore = true,
        },
      })
    end,
  },
  -- Buffer
  {
    "famiu/bufdelete.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>x", "<cmd>Bdelete<cr>",  desc = "Close Buffer" },
      { "<leader>X", "<cmd>Bdelete!<cr>", desc = "Close Buffer (Force)" },
    },
  }
}
