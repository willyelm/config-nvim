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
          -- Custom handler for Biome to ensure it doesn't conflict with ts_ls
          biome = function()
            require('lspconfig').biome.setup({
              single_file_support = true,
            })
          end,
        },
      })
    end
  }
}
