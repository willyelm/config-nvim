local M = {}

function M.setup()
  require("nvim-treesitter").setup({
    ensure_installed = {
      "tsx",
      "typescript",
      "javascript",
      "css",
      "postcss",
      "html",
      "yaml",
      "go",
      "lua",
      "markdown",
      "markdown_inline",
    },
    auto_install = true,
    indent = { enable = true },
    highlight = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  })

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
