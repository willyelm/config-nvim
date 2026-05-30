local M = {}

local plugins = {
  { src = "https://github.com/github/copilot.vim" },
  { src = "https://github.com/Saghen/blink.lib" },
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/fang2hou/blink-copilot" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
  { src = "https://github.com/willyelm/pulse.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/utilyre/barbecue.nvim",                      name = "barbecue" },
  { src = "https://github.com/SmiteshP/nvim-navic" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
}

function M.setup()
  local colorizer_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/nvim-colorizer.lua"
  local stale_colorizer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/nvim-colorizer.lua"

  vim.pack.add(plugins, { load = true, confirm = false })
  vim.opt.runtimepath:remove(stale_colorizer_path)
  vim.opt.runtimepath:prepend(colorizer_path)

  -- Local dev: load pulse.nvim directly from source
  -- vim.opt.rtp:prepend("/Users/willyelm/Git/pulse.nvim")

  require("setup.cmp").setup()
  require("setup.diagnostics").setup()
  require("setup.treesitter").setup()
  require("setup.lsp").setup()
  require("setup.format").setup()
  require("setup.git").setup()
  require("setup.search").setup()
  require("setup.ui").setup()
end

return M
