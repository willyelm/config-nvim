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
			local capabilities = lsp_zero.get_capabilities()
			capabilities.textDocument = capabilities.textDocument or {}
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			capabilities.workspace = capabilities.workspace or {}
			capabilities.workspace.didChangeWatchedFiles = {
				dynamicRegistration = true,
				relativePatternSupport = true,
			}

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				-- Enable inlays
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
				-- Enable document highlights
				-- if client.server_capabilities.documentHighlightProvider then
				-- 	local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
				-- 	vim.api.nvim_create_autocmd("CursorHold", {
				-- 		group = group,
				-- 		buffer = bufnr,
				-- 		callback = vim.lsp.buf.document_highlight,
				-- 	})
				-- 	vim.api.nvim_create_autocmd("CursorMoved", {
				-- 		group = group,
				-- 		buffer = bufnr,
				-- 		callback = vim.lsp.buf.clear_references,
				-- 	})
				-- end
			end)

			require("mason").setup({})
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSPs
					"vtsls",
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
				automatic_enable = {
					exclude = { "ts_ls" },
				},
				handlers = {
					lsp_zero.default_setup,
					-- Prevent Mason from auto-configuring ts_ls when vtsls is preferred.
					ts_ls = function() end,
					cssls = function() end,
					tailwindcss = function() end,
				},
			})

			vim.lsp.config("vtsls", {
				root_markers = { "package.json", "tsconfig.json", ".git" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				settings = {
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							parameterNames = { enabled = "all" },
							parameterTypes = { enabled = false },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = false },
							functionLikeReturnTypes = { enabled = false },
							enumMemberValues = { enabled = true },
						},
						preferences = {
							importModuleSpecifierPreference = "non-relative",
							includeCompletionsForModuleExports = true,
							includeCompletionsForImportStatements = true,
							includeCompletionsWithSnippetText = true,
							includeCompletionsWithInsertText = true,
							providePrefixAndSuffixTextForRename = true,
							allowRenameOfImportPath = true,
						},
					},
				},
				on_attach = lsp_zero.on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = { enable = false },
					},
				},
				on_attach = lsp_zero.on_attach,
				capabilities = capabilities,
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
				capabilities = capabilities,
			})

			vim.lsp.config("cssls", {
				settings = {
					css = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
				on_attach = lsp_zero.on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("tailwindcss", {
				on_attach = lsp_zero.on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						validate = { enable = true },
						schemaDownload = { enable = true },
					},
				},
				on_attach = lsp_zero.on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						usePlaceholders = true,
						staticcheck = true,
						hints = {
							-- assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
				on_attach = lsp_zero.on_attach,
				capabilities = capabilities,
			})

			-- Enable the configs
			vim.lsp.enable("vtsls")
			vim.lsp.enable("biome")
			vim.lsp.enable("cssls")
			vim.lsp.enable("tailwindcss")
			vim.lsp.enable("jsonls")
			vim.lsp.enable("gopls")
		end,
	},
	-- TreeSitter
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
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
			highlight = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
			vim.treesitter.language.register("markdown", "mdx")
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
	-- TreeSitter Context
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 3, -- Keep it unobtrusive
			min_window_height = 20,
			line_numbers = true,
			multiline_threshold = 1, -- Only show the first line of a block
		},
	},
	-- Autocomplete
	{
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
			config = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")

				cmp.setup({
					completion = {
						completeopt = "menu,menuone,noinsert",
					},
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					formatting = {
						fields = { "abbr", "kind", "menu" },
						format = function(entry, vim_item)
							vim_item.menu = ({
								nvim_lsp = "(lsp)",
								luasnip = "(snippet)",
								buffer = "(buffer)",
								path = "(path)",
							})[entry.source.name]
							return vim_item
						end,
					},
					window = {
						completion = cmp.config.window.bordered({
							border = "rounded",
							winblend = 10,
							winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
						}),
						documentation = cmp.config.window.bordered({
							border = "rounded",
							winblend = 10,
							max_width = 50,
							max_height = 20,
							winhighlight = "Normal:PmenuDoc,FloatBorder:PmenuDocBorder,CursorLine:PmenuSel,Search:None",
						}),
					},
					mapping = cmp.mapping.preset.insert({
						["<C-Space>"] = cmp.mapping.complete(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" }, -- Primary source (Biome, vtsls, etc.)
						{ name = "luasnip" }, -- For code snippets
					}, {
						{ name = "buffer" }, -- Text from current file
						{ name = "path" }, -- File system paths
					}),
				})
			end,
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		-- priority = 1000,
		opts = {
			options = {
				add_messages = {
					display_count = true,
				},
				multilines = {
					enabled = true,
				},
			},
		},
	},
	-- AutoPairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	-- AutoTag
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPre", "BufNewFile" },
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
}
