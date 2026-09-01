local M = {}

function M.setup()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },
      go = { "goimports" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      svg = { "prettierd" },
      yaml = { "prettierd" },
      graphql = { "prettierd" },
      markdown = { "prettierd" },
      mdx = { "prettierd" },
    },
    formatters = {
      biome = {
        cwd = function(self, ctx)
          local util = require("conform.util")
          return util.root_file({ "biome.json", "biome.jsonc", ".git" })(self, ctx)
        end,
        args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
      },
      prettierd = {
        append_args = function(_, ctx)
          local ft = vim.bo[ctx.buf].filetype
          if ft == "markdown" or ft == "mdx" then
            return { "--prose-wrap=always", "--print-width=80" }
          end
          return {}
        end,
      },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  })
end

return M
