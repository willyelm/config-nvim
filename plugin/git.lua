require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▁" },
    topdelete = { text = "▔" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  auto_attach = true,
  signcolumn = true,
  current_line_blame = true,
  word_diff = false,
  watch_gitdir = {
    follow_files = true,
  },
})
