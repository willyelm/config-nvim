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
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "ruff_format", "ruff_organize_imports" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      -- prettier has no dedicated SVG parser; see prettier_xml below. Real
      -- SVG files only use actual SVG tag names, which prettier's HTML
      -- printer already treats as block-level, so this reads well.
      svg = { "prettier_xml" },
      -- Generic XML has arbitrary tag names, which prettier's HTML printer
      -- treats as inline by default and leaves squashed onto one line, so it
      -- gets a real XML formatter instead.
      xml = { "xmllint" },
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
      -- prettierd infers its parser purely from the filename it's given, and
      -- there is no "svg"/"xml" parser -- it just no-ops. Appending a fake
      -- ".html" extension gets it to use the HTML parser (SVG/XML are close
      -- enough); the real buffer content still comes in over stdin.
      prettier_xml = {
        command = "prettierd",
        args = { "$FILENAME.html" },
        cwd = require("conform.util").root_file({
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.yml",
          ".prettierrc.yaml",
          ".prettierrc.js",
          "prettier.config.js",
          "package.json",
          ".git",
        }),
      },
      xmllint = {
        command = "xmllint",
        args = { "--format", "--nonet", "-" },
      },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  })
end

return M
