vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.nu = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5
vim.opt.textwidth = 80
vim.opt.colorcolumn = "80"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false

vim.opt.selection = "exclusive"
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250
-- Set explicitly: auto-detection runs after init, too late for colorizer.
vim.opt.termguicolors = true

vim.opt.cursorline = true
vim.opt.guicursor = "n-v-ve:block,i-ci:ver10-Cursor"
vim.opt.mouse = "a"
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Folding (native treesitter foldexpr; see lua/setup/folding.lua)
-- Fixed widths: "auto" columns appeared/grew as signs and folds loaded,
-- shifting the text sideways right after a file opened.
vim.opt.foldcolumn = "1"
vim.opt.signcolumn = "yes"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 20

vim.opt.laststatus = 3
-- Default border for every float that does not set its own (hover,
-- diagnostics, completion menus).
vim.o.winborder = "rounded"
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

-- Pick up external changes when returning to a buffer or idling in normal mode
-- (not in insert, where a reload would fight the edit).
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "FocusGained" }, {
  group = vim.api.nvim_create_augroup("willyelm_checktime", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
  pattern = { "*" },
})

vim.filetype.add({
  extension = {
    mdx = "mdx",
    gotmpl = "gotmpl",
  },
})

vim.cmd("colorscheme willyelm")
