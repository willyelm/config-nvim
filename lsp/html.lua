-- Formatting stays with conform (prettier); html only provides completion,
-- hover and linked tag editing.
return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { "package.json", ".git" },
  init_options = { provideFormatter = false },
}
