local M = {}

function M.setup()
  require("ufo").setup({
    open_fold_hl_timeout = 150,
    -- Peek window styling.
    preview = {
      win_config = {
        border = "rounded",
        winblend = 0,
      },
    },
  })
end

return M
