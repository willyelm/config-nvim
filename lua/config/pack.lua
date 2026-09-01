local M = {}

local plugins = {
  { src = "https://github.com/zbirenbaum/copilot.lua" },
  { src = "https://github.com/Saghen/blink.lib" },
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/fang2hou/blink-copilot" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/kevinhwang91/promise-async" },
  { src = "https://github.com/kevinhwang91/nvim-ufo" },
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
  { src = "https://github.com/willyelm/pulse.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/Bekaboo/dropbar.nvim",                       name = "dropbar" },
  { src = "https://github.com/SmiteshP/nvim-navic" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
}

function M.setup()
  vim.pack.add(plugins, { load = true, confirm = false })

  -- Local dev: load pulse.nvim directly from source
  -- vim.opt.rtp:prepend("/Users/willyelm/Git/pulse.nvim")

  require("setup.cmp").setup()
  require("setup.diagnostics").setup()
  require("setup.treesitter").setup()
  require("setup.textobjects").setup()
  require("setup.folding").setup()
  require("setup.editing").setup()
  require("setup.lsp").setup()
  require("setup.format").setup()
  require("setup.git").setup()
  require("setup.search").setup()
  require("setup.ui").setup()
end

return M
