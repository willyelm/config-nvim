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

vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5
vim.opt.textwidth = 80

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.selection = "exclusive"
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "100"
vim.opt.termguicolors = true
vim.o.autoread = true

vim.opt.cursorline = true
-- vim.opt.guicursor = "n-c-sm:block,i-ci-ve:ver25,v:ver25,r-cr:hor20,o:hor50"
vim.opt.mouse = "a"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300

vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.fillchars = {
	vert = "│",
	horiz = "─",
	-- msgsep = " ",
	eob = " ",
	lastline = " ",
}

vim.cmd("colorscheme willyelm")

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})
