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
    opts = function()
      local custom_auto = require("lualine.themes.auto")

      custom_auto.normal.c.bg = "NONE"
      custom_auto.insert.c.bg = "NONE"
      custom_auto.visual.c.bg = "NONE"
      custom_auto.command.c.bg = "NONE"
      custom_auto.inactive.c.bg = "NONE"

      return {
        options = {
          globalstatus = true,
          theme = custom_auto,
        },
        sections = {
          lualine_b = { 'branch', 'diff', 'diagnostics' },
        }
      }
    end
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
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
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
  },
}
