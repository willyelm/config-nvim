local M = {}

-- Try LSP folding ranges first, fall back to treesitter, then indentation.
-- (ufo raises `UfoFallbackException` when a provider has nothing to offer.)
local function fold_selector(bufnr)
  local ufo = require("ufo")
  local function fallback(err, next_provider)
    if type(err) == "string" and err:match("UfoFallbackException") then
      return ufo.getFolds(bufnr, next_provider)
    end
    return require("promise").reject(err)
  end

  return ufo
    .getFolds(bufnr, "lsp")
    :catch(function(err)
      return fallback(err, "treesitter")
    end)
    :catch(function(err)
      return fallback(err, "indent")
    end)
end

function M.setup()
  require("ufo").setup({
    open_fold_hl_timeout = 150,
    provider_selector = function()
      return fold_selector
    end,
    preview = {
      win_config = {
        border = "rounded",
        winblend = 0,
      },
    },
  })
end

return M
