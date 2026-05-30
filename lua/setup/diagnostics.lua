local M = {}

function M.setup()
  require("tiny-inline-diagnostic").setup({
    preset = "simple",
    options = {
      add_messages = {
        display_count = true,
      },
      multilines = {
        enabled = true,
      },
    },
  })

  vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "if_many",
    },
  })
end

return M
