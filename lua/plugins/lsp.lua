local M = {}

local function on_attach(client, bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
	vim.keymap.set("n", "go", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
	vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to reference" }))
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
	vim.keymap.set({ "n", "x" }, "<F3>", function()
		vim.lsp.buf.format({ async = true })
	end, vim.tbl_extend("force", opts, { desc = "Format file" }))
	vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Execute code action" }))

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

local function setup_lsp()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.textDocument = capabilities.textDocument or {}
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	capabilities.textDocument.synchronization = {
		didSave = true,
		willSave = true,
		willSaveWaitUntil = true,
	}
	capabilities.workspace = capabilities.workspace or {}
	capabilities.workspace.didChangeWatchedFiles = {
		dynamicRegistration = true,
		relativePatternSupport = true,
	}

	require("mason").setup({})
	require("mason-tool-installer").setup({
		ensure_installed = {
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
			function(server_name)
				vim.lsp.enable(server_name)
			end,
			ts_ls = function() end,
			cssls = function() end,
			tailwindcss = function() end,
		},
	})

	vim.lsp.config("vtsls", {
		root_markers = { "package.json", "tsconfig.json", ".git" },
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		sync_kind = "full",
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
		on_attach = on_attach,
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
		on_attach = on_attach,
		capabilities = capabilities,
	})

	vim.lsp.config("biome", {
		cmd = { "biome", "lsp-proxy" },
		root_markers = { "biome.json", "biome.jsonc" },
		single_file_support = true,
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
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
		on_attach = on_attach,
		capabilities = capabilities,
	})

	vim.lsp.config("tailwindcss", {
		on_attach = on_attach,
		capabilities = capabilities,
	})

	vim.lsp.config("jsonls", {
		settings = {
			json = {
				validate = { enable = true },
				schemaDownload = { enable = true },
			},
		},
		on_attach = on_attach,
		capabilities = capabilities,
	})

	vim.lsp.config("yamlls", {
		settings = {
			yaml = {
				validate = true,
				hover = true,
				completion = true,
				format = { enable = true },
				schemaStore = {
					enable = true,
					url = "",
				},
			},
		},
		on_attach = on_attach,
		capabilities = capabilities,
	})

	vim.lsp.config("gopls", {
		sync_kind = "full",
		settings = {
			gopls = {
				usePlaceholders = true,
				staticcheck = true,
			},
		},
		on_attach = on_attach,
		capabilities = capabilities,
	})

	vim.lsp.enable("vtsls")
	vim.lsp.enable("biome")
	vim.lsp.enable("cssls")
	vim.lsp.enable("tailwindcss")
	vim.lsp.enable("jsonls")
	vim.lsp.enable("yamlls")
	vim.lsp.enable("gopls")
end

local function setup_treesitter()
	require("nvim-treesitter").setup({
		ensure_installed = {
			"tsx",
			"typescript",
			"javascript",
			"css",
			"postcss",
			"html",
			"yaml",
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
	})

	vim.treesitter.language.register("markdown", "mdx")
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			pcall(vim.treesitter.start)
		end,
	})

	require("treesitter-context").setup({
		max_lines = 3,
		min_window_height = 20,
		line_numbers = true,
		multiline_threshold = 1,
	})

	require("nvim-ts-autotag").setup({
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
	})
end

local function setup_cmp()
	local cmp = require("cmp")

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		formatting = {
			fields = { "abbr", "kind", "menu" },
			format = function(entry, vim_item)
				vim_item.menu = ({
					nvim_lsp = "(lsp)",
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
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
	})

	require("nvim-autopairs").setup({})
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

	require("tiny-inline-diagnostic").setup({
		options = {
			add_messages = {
				display_count = true,
			},
			multilines = {
				enabled = true,
			},
		},
	})
end

function M.setup()
	setup_lsp()
	setup_treesitter()
	setup_cmp()
end

return M
