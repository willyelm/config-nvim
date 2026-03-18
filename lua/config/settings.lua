vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

vim.opt.backspace = "indent,eol,start"
vim.opt.selection = "exclusive"
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50
vim.opt.termguicolors = true
vim.opt.autoread = true
vim.opt.autochdir = false

vim.opt.cursorline = true
vim.opt.guicursor = "n:block,v-i-ci-ve:ver10-Cursor"
vim.opt.mouse = "a"
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.signcolumn = "auto:1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.fillchars = {
	vert = "│",
	horiz = "─",
	msgsep = " ",
	eob = " ",
	lastline = " ",
	foldopen = "-",
	foldclose = "+",
	foldsep = " ",
	fold = " ",
}

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained", "FileChangedShellPost" }, {
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
			vim.cmd("LspRestart")
		end
	end,
	pattern = { "*" },
})

vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})

vim.cmd("colorscheme willyelm")
