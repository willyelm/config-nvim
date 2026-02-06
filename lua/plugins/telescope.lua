return {
  -- Telescope
  'nvim-telescope/telescope.nvim',
  dependencies = { 
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } -- C-compiled search
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      -- your previous ASCII borders config
    })
    telescope.load_extension('fzf')
  end
}
