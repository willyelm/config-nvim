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
  "c",
  "cpp",
  "python",
  "markdown",
  "markdown_inline",
  "json",
  "bash",
}

function M.setup()
  local ts = require("nvim-treesitter")
  ts.setup()

  vim.treesitter.language.register("markdown", "mdx")

  -- `main` removed the `highlight`/`indent` modules, so wire them per-buffer:
  -- start treesitter highlighting when a parser is available and hand indenting
  -- to treesitter only where the language ships indent queries, keeping
  -- `smartindent` as the fallback for everything else.
  local function start(buf, ft)
    local lang = vim.treesitter.language.get_lang(ft) or ft
    if not vim.treesitter.language.add(lang) then
      return
    end
    pcall(vim.treesitter.start, buf, lang)
    if #vim.treesitter.query.get_files(lang, "indents") > 0 then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("willyelm_treesitter", { clear = true }),
    callback = function(args)
      start(args.buf, args.match)
    end,
  })

  -- install() skips parsers that are already present, so this only compiles on
  -- a fresh checkout; it runs async and does not block startup. Buffers opened
  -- before their parser finished would otherwise stay unhighlighted until :e.
  local ok, task = pcall(ts.install, ensure_installed)
  if ok and task then
    task:await(vim.schedule_wrap(function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local ft = vim.bo[buf].filetype
        if vim.api.nvim_buf_is_loaded(buf) and ft ~= "" and not vim.treesitter.highlighter.active[buf] then
          start(buf, ft)
        end
      end
    end))
  end

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
