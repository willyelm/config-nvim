return {
  -- Discovery
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          width = 0.85,
          height = 0.80,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        border = true,
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
    keys = {
      -- Search
      { "<leader>sf", "<cmd>Telescope find_files<cr>",   desc = "Find Files" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>",    desc = "Search Global" },
      { "<leader>sb", "<cmd>Telescope buffers<cr>",      desc = "Find Buffers" },
      -- Git
      { "<leader>gh", "<cmd>Telescope git_bcommits<cr>", desc = "File History" },
      { "<leader>gH", "<cmd>Telescope git_commits<cr>",  desc = "Project History" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
      { "<leader>gs", "<cmd>Telescope git_stash<cr>",    desc = "Stash" },
      -- Command Palette
      { "<leader>P",  "<cmd>Telescope keymaps<cr>",      desc = "Keymaps" },
      {
        "<leader>p",
        function()
          require('telescope.builtin').commands(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "Command Palette"
      },
    }
  },
  -- Search/Replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { is_live_replace = true },
    keys = {
      { "<leader>sr", function() require("spectre").toggle() end, desc = "Search & Replace" },
    }
  },
  -- Quick Navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, "<cmd>lua require('flash').jump()<cr>",       desc = "Jump" },
      { "S", mode = { "n", "x", "o" }, "<cmd>lua require('flash').treesitter()<cr>", desc = "Jump (Treesitter)" },
    },
  },
}
