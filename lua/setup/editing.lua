local M = {}

function M.setup()
  -- JSX/TSX-aware `commentstring`. Neovim 0.10+ does the actual commenting
  -- (`gc` / `gcc`); this just resolves the right delimiters for the node under
  -- the cursor (e.g. `{/* */}` inside JSX).
  vim.g.skip_ts_context_commentstring_module = true
  require("ts_context_commentstring").setup({ enable_autocmd = false })

  local get_option = vim.filetype.get_option
  vim.filetype.get_option = function(filetype, option)
    if option ~= "commentstring" then
      return get_option(filetype, option)
    end
    local ok, cs = pcall(require("ts_context_commentstring.internal").calculate_commentstring)
    return (ok and cs) or get_option(filetype, option)
  end

  -- Surround: sa (add, takes a motion), sd (delete), sr (replace), sf/sF
  -- (find), sn (update n_lines). Works on JSX tags via the `t` target.
  require("mini.surround").setup({
    n_lines = 50,
    search_method = "cover_or_next",
  })

  -- Split / join the treesitter node under the cursor: JSX attributes, object
  -- literals, arrays, call args, ...
  require("treesj").setup({
    use_default_keymaps = false,
    max_join_length = 120,
  })
  vim.keymap.set("n", "<leader>j", function()
    require("treesj").toggle()
  end, { desc = "Split/join node" })
  vim.keymap.set("n", "<leader>J", function()
    require("treesj").join()
  end, { desc = "Join node" })
end

return M
