local M = {}

function M.setup()
  -- `%` matches JSX open/close tags, if/end, etc.; show the match target in a
  -- popup when its opening line is off screen.
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
  vim.g.matchup_matchparen_deferred = 1

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

  -- Surround on a `gs` prefix so bare `s` keeps its native "substitute"
  -- meaning (mini.surround maps `s` to <Nop> if its mappings start with `s`).
  -- gsa add (takes a motion / visual), gsd delete, gsr replace, gsf/gsF find.
  -- Works on JSX tags via the `t` target, e.g. `gsat`.
  require("mini.surround").setup({
    n_lines = 50,
    search_method = "cover_or_next",
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
      suffix_last = "l",
      suffix_next = "n",
    },
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
