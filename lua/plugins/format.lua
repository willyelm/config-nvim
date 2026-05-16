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
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			scss = { "prettierd", "prettier", stop_after_first = true },
			svg = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			graphql = { "prettierd", "prettier", stop_after_first = true },
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
	})
end

return M
