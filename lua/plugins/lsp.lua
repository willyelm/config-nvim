return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)
      -- require('lspconfig.ui.windows').default_options.border = 'rounded'
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'ts_ls', 'lua_ls', 'gopls', 'pyright',
          'jsonls', 'yamlls',
          'html', 'mdx_analyzer', 'marksman',
          'cssls', 'tailwindcss',
          'biome',
          'dockerls',
        },
        handlers = {
          lsp.default_setup,
          biome = function()
            require('lspconfig').biome.setup({
              single_file_support = true,
            })
          end,
          ts_ls = function()
            require('lspconfig').ts_ls.setup({
              root_dir = require('lspconfig').util.root_pattern("package.json", "tsconfig.json", ".git"),
              single_file_support = false,
            })
          end,
        },
      })
    end
  },
  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    main = "nvim-treesitter",
    opts = {
      ensure_installed = {
        "tsx", "typescript", "javascript", "css", "postcss",
        "html", "go", "lua", "markdown", "markdown_inline"
      },
      auto_install = true,
      indent = { enable = true },
      highlight = {
        enable = true,
      },
    },
    -- init = function()
    --   vim.treesitter.language.register('markdown', 'mdx')
    --   vim.treesitter.query.set("markdown", "injections", [[
    --     ((inline) @injection.content
    --      (#lua-match? @injection.content "^%s*import")
    --      (#set! injection.language "tsx"))
    --
    --     ((inline) @injection.content
    --      (#lua-match? @injection.content "^%s*export")
    --      (#set! injection.language "tsx"))
    --
    --     ((paragraph (inline) @injection.content)
    --      (#lua-match? @injection.content "^%s*<")
    --      (#set! injection.language "tsx"))
    --   ]])
    -- end,
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      -- vim.treesitter.language.register('markdown', 'mdx')
      vim.treesitter.query.set("markdown", "injections", [[
        ((inline) @injection.content
         (#lua-match? @injection.content "^%s*import")
         (#set! injection.language "tsx"))

        ((inline) @injection.content
         (#lua-match? @injection.content "^%s*export")
         (#set! injection.language "tsx"))

        ((paragraph (inline) @injection.content)
         (#lua-match? @injection.content "^%s*<")
         (#set! injection.language "tsx"))
      ]])
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "mdx",
        callback = function()
          vim.treesitter.language.register('markdown', 'mdx')
          vim.treesitter.start()
        end,
      })
    end,
  },
  -- AutoTag
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
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
  }
}
