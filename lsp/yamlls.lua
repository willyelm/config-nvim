return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml" },
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      format = { enable = true },
      schemaStore = {
        enable = true,
      },
    },
  },
}
