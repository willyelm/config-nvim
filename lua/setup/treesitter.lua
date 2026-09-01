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
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      pcall(vim.treesitter.start)
    end,
  })

  require("treesitter-context").setup({
    max_lines = 3,
    min_window_height = 20,
    line_numbers = true,
    multiline_threshold = 1,
  })

  require("nvim-ts-autotag").setup({
    opts = {
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,
    },
    filetypes = {
      "html",
      "svg",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "tsx",
      "jsx",
      "mdx",
    },
  })
end

return M
