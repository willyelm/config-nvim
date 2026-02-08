return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept      = "<C-y>", -- "Yes" (Vim native confirm)
            next        = "<C-n>", -- "Down" (Vim native move down)
            prev        = "<C-p>", -- "Up" (Vim native move up)
            dismiss     = "<C-e>", -- "Exit/End" (Vim native cancel)
            accept_word = "<C-l>", -- "Right" (Move right one word)
            accept_line = "<C-f>", -- "Forward" (Move forward one line)
          },
        },
      })
    end,
  },
}
