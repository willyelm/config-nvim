local M = {}

function M.setup()
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
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
