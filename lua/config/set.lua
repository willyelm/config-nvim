vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.wrap = true
vim.opt.wrapmargin = 2
vim.opt.textwidth = 80

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "100"
vim.opt.termguicolors = true

vim.opt.scrolloff = 8 
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true 
vim.opt.mouse = "a"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.fillchars = {
  vert = "│",      -- Solid thin line
  horiz = "─",     -- Solid thin horizontal
  msgsep = " ",    -- Clear message separator
  eob = " ",       -- Hide the '~' at End Of Buffer
  lastline = " ",
}

vim.cmd("colorscheme willyelm")
