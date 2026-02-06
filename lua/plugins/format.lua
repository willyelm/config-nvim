return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
        go = { "gofmt" },
      },
      formatters = {
        biome = {
          cwd = function(self, ctx)
            local util = require("conform.util")
            return util.root_file({ "biome.json", "biome.jsonc", ".git" })(self, ctx)
          end,
          args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
        },      
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
