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
