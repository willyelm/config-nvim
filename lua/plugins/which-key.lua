return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- Use ASCII borders to match your theme
    win = {
      -- border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
      border = "rounded",
      title = false
    },
    icons = {
      mappings = false,
      rules = false
    },
  },
}
