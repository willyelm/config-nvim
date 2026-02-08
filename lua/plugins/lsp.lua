return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    devent = { "BufReadPre", "BufNewFile" },
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
      require('lspconfig.ui.windows').default_options.border = 'rounded'
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'ts_ls', 'jsonls', 'yamlls', 'html', 'mdx_analyzer', 'cssls', 'lua_ls',
          'tailwindcss', 'biome', 'gopls', 'dockerls', 'pyright', 'marksman'
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
        "typescript", "tsx", "javascript", "css", "html", "go", "lua",
        "markdown", "markdown_inline"
      },
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    },
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
