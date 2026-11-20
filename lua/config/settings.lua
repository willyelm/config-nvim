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

vim.opt.autoread = true
-- External changes reload instantly: see config/autoreload.lua.

-- Files over 1 MB (minified bundles, generated JSON) get filetype "bigfile":
-- no treesitter, no LSP and no fold expression, which is where they freeze.
local BIGFILE = 1024 * 1024
vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return buf and vim.bo[buf].buftype == "" and vim.fn.getfsize(path) > BIGFILE and "bigfile" or nil
      end,
      { priority = math.huge },
    },
  },
  extension = {
    mdx = "mdx",
    gotmpl = "gotmpl",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("willyelm_bigfile", { clear = true }),
  pattern = "bigfile",
  callback = function()
    vim.wo.foldmethod = "manual"
    vim.wo.foldenable = false
  end,
})

vim.cmd("colorscheme willyelm")
