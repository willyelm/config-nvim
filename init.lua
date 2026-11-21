-- Byte-compile and cache Lua modules; roughly a quarter off startup.
vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local plugins = {
  { src = "https://github.com/willyelm/pulse.nvim" },
  { src = "https://github.com/willyelm/clasp" },
  { src = "https://github.com/Saghen/blink.lib" },
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/Bekaboo/dropbar.nvim", name = "dropbar" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/milanglacier/minuet-ai.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
}

vim.pack.add(plugins, { load = true, confirm = false })

-- Local dev: load plugins directly from source
-- vim.opt.rtp:prepend("/Users/willyelm/Git/pulse.nvim")
-- vim.opt.rtp:prepend("/Users/willyelm/Git/clasp.nvim")

-- Everything else lives in plugin/*.lua, sourced automatically after this
-- file (alphabetically); lsp/*.lua holds the language server configs.
