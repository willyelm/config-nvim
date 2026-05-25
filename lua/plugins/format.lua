local M = {}

function M.setup()
	require("conform").setup({
		formatters_by_ft = {
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
		},
		formatters = {
			biome = {
				cwd = function(self, ctx)
					local util = require("conform.util")
					return util.root_file({ "biome.json", "biome.jsonc", ".git" })(self, ctx)
				end,
				args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
			},
			prettierd_md = {
				command = "prettierd",
				args = { "--prose-wrap=always", "--print-width=80", "--stdin-filepath", "$FILENAME" },
			},
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true,
		},
	})
end

return M
