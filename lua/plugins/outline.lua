return {
  "stevearc/aerial.nvim",
  opts = {
    backends = { "treesitter", "lsp" },
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
    sep = "",
    nerd_font = "auto",
    show_diagnostics = true,
    highlight_on_hover = true,
    filter_kind = false,
    -- Layout settings
    layout = {
      default_direction = "left",
      placement = "window",
      width = 30,
    },
    attach_mode = "global",
  },
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Toggle Outline" },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = {
      "lewis6991/gitsigns.nvim",
    },
    opts = {
      show = true,
      handle = {
        color = "#3b4261",
      },
      marks = {
        Search = { color = "#ff9e64" },
        Error = { color = "#db4b4b" },
        Warn = { color = "#e0af68" },
        Info = { color = "#0db9d7" },
        Hint = { color = "#1abc9c" },
        Misc = { color = "#9d7cd8" },
      },
      handlers = {
        gitsigns = true,   -- Show git changes
        diagnostic = true, -- Show diagnostics
        search = true,     -- Show search results
      },
    },
  }
}
