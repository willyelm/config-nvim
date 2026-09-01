local M = {}

-- Parsers to keep installed. The `main` branch dropped `ensure_installed` /
-- `auto_install`, so we install missing ones explicitly below.
local ensure_installed = {
  "tsx",
  "typescript",
  "javascript",
  "css",
  "html",
  "yaml",
  "go",
  "lua",
  "markdown",
  "markdown_inline",
  "json",
  "bash",
}

function M.setup()
  local ts = require("nvim-treesitter")
  ts.setup()

  -- vim.pack has no post-install build hook. install() skips parsers that are
  -- already present, so this only compiles anything on a fresh checkout; it runs
  -- async and does not block startup.
  pcall(ts.install, ensure_installed)

  vim.treesitter.language.register("markdown", "mdx")

  -- `main` removed the `highlight`/`indent` modules, so wire them per-buffer:
  -- start treesitter highlighting when a parser is available and hand indenting
  -- to treesitter, keeping `smartindent` as the fallback for everything else.
  local group = vim.api.nvim_create_augroup("willyelm_treesitter", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match) or args.match
      if not vim.treesitter.language.add(lang) then
        return
      end
      pcall(vim.treesitter.start, args.buf, lang)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  require("treesitter-context").setup({
    max_lines = 3,
    min_window_height = 20,
    line_numbers = true,
    multiline_threshold = 1,
  })

  -- `main` nvim-ts-autotag keys off the treesitter parser, so the old
  -- top-level `filetypes` list is ignored; the default set already covers
  -- html / xml / (t|j)sx.
  require("nvim-ts-autotag").setup({
    opts = {
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,
    },
  })
end

return M
