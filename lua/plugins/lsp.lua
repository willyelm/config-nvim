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
      highlight = {
        enable = true,
        custom_captures = {
          ["jsx_opening_element"] = "method",
          ["jsx_closing_element"] = "method",
          ["jsx_self_closing_element"] = "method",
        },
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
