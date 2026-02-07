return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    win = {
      border = "rounded",
    },
    icons = {
      mappings = false,
      rules = false
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>f", group = "Find & Replace" },
      { "<leader>g", group = "Git" },
    })
  end,
}
