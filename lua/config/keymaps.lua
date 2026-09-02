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

local word_highlight_group = vim.api.nvim_create_augroup("willyelm_word_highlight", { clear = true })

local function clear_word_highlight()
  if vim.w.word_highlight_match then
    pcall(vim.fn.matchdelete, vim.w.word_highlight_match)
    vim.w.word_highlight_match = nil
  end
  vim.w.word_highlight_word = nil
end

local function update_word_highlight()
  if vim.bo.buftype ~= "" then
    clear_word_highlight()
    return
  end

  local word = vim.fn.expand("<cword>")
  if word == "" or word:match("^%d+$") then
    clear_word_highlight()
    return
  end

  if vim.w.word_highlight_match and vim.w.word_highlight_word == word then
    return
  end

  clear_word_highlight()
  vim.w.word_highlight_word = word
  vim.w.word_highlight_match = vim.fn.matchadd("WordHighlight", [[\V\<]] .. vim.fn.escape(word, [[\]]) .. [[\>]])
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter", "WinEnter" }, {
  group = word_highlight_group,
  callback = update_word_highlight,
})

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

vim.keymap.set("n", "<leader>i", function()
  vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Docs", silent = true })

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Diagnostics", silent = true })

-- Save
-- vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:write<CR>", { desc = "Save Changes" })

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

-- Toggle Comments (native gc/gcc; commentstring is resolved per-node by
-- nvim-ts-context-commentstring, so JSX comments as {/* */})
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("x", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })
