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
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
    icons = {
      mappings = false, -- Disables icons for a clean ASCII look
    },
  },
}
