return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
    },
    keys = {
      { "<leader>gd", "<cmd>Gitsigns diffthis<cr>",     desc = "Diff (Current)" },
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
