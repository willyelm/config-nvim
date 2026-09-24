-- Diagnostics navigation
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })
vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev error" })

-- Move Text
vim.keymap.set("v", "<leader>.", ">gv", { desc = "Increase indent" })
vim.keymap.set("v", "<leader>,", "<gv", { desc = "Decrease indent" })
vim.keymap.set("n", "<M-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<M-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("v", "<M-Down>", ":m '>+1<cr>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "<M-Up>", ":m '<-2<cr>gv=gv", { desc = "Move block up" })

-- Hovers
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover({
    border = "rounded",
    wrap = true,
    max_width = 60,
  })
end, {
  noremap = true,
  desc = "Hover Documentation",
  silent = true,
})
vim.keymap.set("n", "gl", vim.diagnostic.open_float, {
  desc = "Show line diagnostics",
  silent = true,
})

-- Cycle Windows
vim.keymap.set("n", "<leader><Tab>", "<C-w>w", { desc = "Next window" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Clipboard
vim.keymap.set("x", "p", '"_dP', { desc = "Paste over selection without overwriting register" })

-- Copy Location (path:line:col)
vim.keymap.set("n", "<leader>c", function()
  local path = vim.fn.expand("%")
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local coordinates = path .. ":" .. line .. ":" .. col
  vim.fn.setreg("+", coordinates)
  print("Copied: " .. coordinates)
end, { desc = "Copy location" })

