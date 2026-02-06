return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'ts_ls', 'tailwindcss', 'biome', 'gopls' },
        handlers = {
          lsp.default_setup,
          biome = function()
            require('lspconfig').biome.setup({
              single_file_support = true,
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
        "typescript", "tsx", "javascript", 
        "css", "html", "go", "lua", "markdown", "markdown_inline" 
      },
      highlight = { 
        enable = true,
      },
      indent = { enable = true },
    },
  },  -- AutoTag
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {}, 
  },  -- Colorizer
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "css", "scss", "javascript", "typescriptreact", "html" },
      user_default_options = {
        RGB = true,          -- #RGB hex codes
        RRGGBB = true,       -- #RRGGBB hex codes
        names = false,       -- Disable "Blue" or "Red" text detection (cleaner)
        RRGGBBAA = true,     -- Hex codes with alpha
        tailwind = true,     -- PRO TIP: Enables color box previews for Tailwind classes
        mode = "background", -- Set to "foreground" for a more subtle look
      },
    },
  }
}
