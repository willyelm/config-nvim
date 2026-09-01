local M = {}

-- nvim-treesitter-textobjects `main` no longer reads a `keymaps` table from the
-- treesitter setup call; mappings are created explicitly against the capture
-- groups in `textobjects.scm`.
local select_objects = {
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ac"] = "@class.outer",
  ["ic"] = "@class.inner",
  ["aa"] = "@parameter.outer",
  ["ia"] = "@parameter.inner",
  ["ai"] = "@conditional.outer",
  ["ii"] = "@conditional.inner",
  ["al"] = "@loop.outer",
  ["il"] = "@loop.inner",
}

function M.setup()
  require("nvim-treesitter-textobjects").setup({
    select = {
      lookahead = true,
      selection_modes = {
        ["@function.outer"] = "V",
        ["@class.outer"] = "V",
      },
    },
  })

  local select = require("nvim-treesitter-textobjects.select")
  for lhs, query in pairs(select_objects) do
    vim.keymap.set({ "x", "o" }, lhs, function()
      select.select_textobject(query, "textobjects")
    end, { desc = "textobject " .. query })
  end
end

return M
