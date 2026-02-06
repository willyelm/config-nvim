return {
  'stevearc/aerial.nvim',
  opts = {
    -- Keymaps for navigation within the outline
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
    -- Layout settings
    layout = {
      default_direction = "right",
      placement = "window",
      width = 30,
    },
    attach_mode = "global",
    -- Use ASCII icons for symbols
    icons = {
      File          = "[f]",
      Module        = "[M]",
      Namespace     = "[N]",
      Package       = "[P]",
      Class         = "[C]",
      Method        = "[m]",
      Property      = "[p]",
      Field         = "[f]",
      Constructor   = "[+]",
      Enum          = "[E]",
      Interface     = "[I]",
      Function      = "[F]",
      Variable      = "[V]",
      Constant      = "[c]",
      String        = "[s]",
      Number        = "[#]",
      Boolean       = "[b]",
      Array         = "[a]",
      Object        = "[o]",
      Key           = "[k]",
      Null          = "[-]",
      EnumMember    = "[e]",
      Struct        = "[S]",
      Event         = "[!]",
      Operator      = "[op]",
      TypeParameter = "[T]",
    },
  },
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Toggle Outline" },
  },
}
