vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.settings")
require("config.keymaps")
require("config.word_highlight")
require("config.pack").setup()
