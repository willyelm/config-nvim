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
          width = 0.6,    -- 60% of screen width
          height = 0.4,   -- 40% of screen height
          -- preview_width = 0.5,
        },
        sorting_strategy = "ascending",
        prompt_position = "top",
        border = true,
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    }
  },
  -- Find/Search
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { is_live_replace = true },
    keys = {
      { "<leader>sr", function() require("spectre").toggle() end, desc = "Search & Replace (Project)" },
    }
  },
  -- Quick Navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
    },
  },
}
