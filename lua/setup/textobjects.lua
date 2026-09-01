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

-- Jump to the next/prev start of these objects with ]x / [x.
-- (class movement is left unbound so ]c / [c keep their diff-mode meaning)
local move_objects = {
  ["f"] = "@function.outer",
  ["a"] = "@parameter.inner",
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
    move = {
      set_jumps = true,
    },
  })

  local select = require("nvim-treesitter-textobjects.select")
  for lhs, query in pairs(select_objects) do
    vim.keymap.set({ "x", "o" }, lhs, function()
      select.select_textobject(query, "textobjects")
    end, { desc = "textobject " .. query })
  end

  local move = require("nvim-treesitter-textobjects.move")
  for key, query in pairs(move_objects) do
    vim.keymap.set({ "n", "x", "o" }, "]" .. key, function()
      move.goto_next_start(query, "textobjects")
    end, { desc = "Next " .. query })
    vim.keymap.set({ "n", "x", "o" }, "[" .. key, function()
      move.goto_previous_start(query, "textobjects")
    end, { desc = "Prev " .. query })
  end

  local swap = require("nvim-treesitter-textobjects.swap")
  vim.keymap.set("n", "<leader>rp", function()
    swap.swap_next("@parameter.inner")
  end, { desc = "Swap parameter with next" })
  vim.keymap.set("n", "<leader>rP", function()
    swap.swap_previous("@parameter.inner")
  end, { desc = "Swap parameter with previous" })
end

return M
