return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end)

			require("mason").setup({})
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSPs
					"ts_ls",
					"lua_ls",
					"gopls",
					"pyright",
					"jsonls",
					"yamlls",
					"html",
					"mdx_analyzer",
					"cssls",
					"tailwindcss",
					"biome",
					"dockerls",
					-- Formatters
					"prettierd",
					"stylua",
					"shfmt",
				},
			})
			require("mason-lspconfig").setup({
				handlers = {
					lsp_zero.default_setup,
				},
			})

			-- Override ts_ls config using new API
			vim.lsp.config("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
				root_markers = { "package.json", "tsconfig.json", ".git" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				single_file_support = true,
				init_options = {
					preferences = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						-- includeInlayFunctionParameterTypeHints = false,
						-- includeInlayVariableTypeHints = true,
						-- includeInlayPropertyDeclarationTypeHints = false,
						-- includeInlayFunctionLikeReturnTypeHints = false,
						includeInlayEnumMemberValueHints = false,
					},
				},
				on_attach = lsp_zero.on_attach,
				capabilities = lsp_zero.get_capabilities(),
			})

			vim.lsp.config("biome", {
				cmd = { "biome", "lsp-proxy" },
				root_markers = { "biome.json", "biome.jsonc" },
				single_file_support = true,
				on_attach = function(client, bufnr)
					lsp_zero.on_attach(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				capabilities = lsp_zero.get_capabilities(),
			})

			-- Enable the configs
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("biome")
		end,
	},
	-- TreeSitter
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		main = "nvim-treesitter",
		opts = {
			ensure_installed = {
				"tsx",
				"typescript",
				"javascript",
				"css",
				"postcss",
				"html",
				"go",
				"lua",
				"markdown",
				"markdown_inline",
			},
			auto_install = true,
			indent = { enable = true },
			highlight = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
			-- vim.treesitter.language.register('markdown', 'mdx')
			vim.treesitter.query.set(
				"markdown",
				"injections",
				[[
        ((inline) @injection.content
         (#lua-match? @injection.content "^%s*import")
         (#set! injection.language "tsx"))

        ((inline) @injection.content
         (#lua-match? @injection.content "^%s*export")
         (#set! injection.language "tsx"))

        ((paragraph (inline) @injection.content)
         (#lua-match? @injection.content "^%s*<")
         (#set! injection.language "tsx"))
      ]]
			)
			vim.treesitter.language.register("markdown", "mdx")
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "mdx", "typescriptreact" },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	-- AutoTag
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			opts = {
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
			},
			filetypes = {
				"html",
				"svg",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"tsx",
				"jsx",
				"mdx",
			},
		},
	},
	-- Colorizer
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "css", "scss", "javascript", "typescriptreact", "html", "json", "lua", "markdown" },
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = false,
				RRGGBBAA = true,
				tailwind = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "background",
			},
		},
	},
}
