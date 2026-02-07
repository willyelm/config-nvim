return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      auto_attach = true,
      signcolumn = true,
      current_line_blame = true,
      word_diff  = false,
      watch_gitdir = {
        follow_files = true
      },
    },
    keys = {
      { "<leader>gd", "<cmd>Gitsigns diffthis<cr>",     desc = "Diff This" },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset File" },
    }
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim"
    },
    opts = {
      integrations = {
        diffview = true,
      },
    },
    config = function()
      require("neogit").setup({
        integrations = {
          diffview = true,
          telescope = true,
        },
        kind = "floating",
        popup = {
          kind = "floating",
        },
        graph_style = "unicode",
      })
    end,
  }
}
