local M = {}

function M.setup()
  require("grug-far").setup({ headerMaxWidth = 80 })

  require("pulse").setup({
    cmdline = true,
    position = "top",
    height = 0.90,
    width = 0.75,
    -- workspace_label = true,
    navigators = {
      files = {
        compact_dirs = true,
        open_on_directory = true,
        icons = true,
        filters = { "^%.git$", "%.DS_Store$" },
        git = {
          enable = true,
          ignore = true,
        },
      },
    },
  })

  vim.o.timeout = true
  vim.o.timeoutlen = 300

  local wk = require("which-key")
  wk.setup({
    win = {
      border = "rounded",
    },
    icons = {
      mappings = false,
      rules = false,
    },
  })
  wk.add({
    { "<leader>s", group = "Search & Replace" },
    { "<leader>g", group = "Git" },
    { "<leader>d", group = "Debug" },
    { "<leader>r", group = "Refactor" },
  })

  vim.keymap.set("n", "<leader>sr", function()
    require("grug-far").open()
  end, { desc = "Search & Replace" })
  vim.keymap.set("n", "<leader>p", "<cmd>Pulse<cr>", { desc = "Pulse" })
  vim.keymap.set("n", "<leader>l", "<cmd>Pulse! live_grep<cr>", { desc = "Live Grep" })
  vim.keymap.set("n", "<leader>f", "<cmd>Pulse fuzzy_search<cr>", { desc = "Fuzzy Search" })
  vim.keymap.set("n", "<leader>o", "<cmd>Pulse! files_open<cr>", { desc = "Open Buffers" })
  vim.keymap.set("n", "<leader>gs", "<cmd>Pulse! git_status<cr>", { desc = "Status" })
  vim.keymap.set("n", "<leader>gc", "<cmd>Pulse! git_project_history<cr>", { desc = "Project History" })
  vim.keymap.set("n", "<leader>gh", "<cmd>Pulse git_file_history<cr>", { desc = "File History" })
end

return M
