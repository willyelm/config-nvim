return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json" },
  settings = {
    json = {
      validate = { enable = true },
      schemaDownload = { enable = true },
    },
  },
}
