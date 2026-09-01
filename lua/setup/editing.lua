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
end

return M
