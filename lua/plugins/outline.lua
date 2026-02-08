return {
  'stevearc/aerial.nvim',
  opts = {
    backends = { "treesitter", "lsp" },
    custom_kinds = {
      jsx_element = "Class",
      jsx_self_closing_element = "Class",
      jsx_opening_element = "Interface",
    },
    -- Keymaps for navigation within the outline
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
    sep = "",
    nerd_font = "auto",
    show_diagnostics = true,
    highlight_on_hover = true,
    -- Layout settings
    layout = {
      default_direction = "right",
      placement = "window",
      width = 30,
    },
    attach_mode = "global",
  },
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Toggle Outline" },
  },
}
