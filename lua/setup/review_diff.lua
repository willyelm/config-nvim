-- GitHub-style unified diff of the current file against HEAD, rendered by
-- pulse.nvim's diff UI so it looks the same as the pulse git panel: old/new
-- line numbers, a +/- sign column and full-width add/delete backgrounds.
local M = {}

local ns = vim.api.nvim_create_namespace("willyelm_review_diff")

local function git(args, cwd)
  local res = vim.system(vim.list_extend({ "git" }, args), { cwd = cwd, text = true }):wait()
  return res.code == 0 and res.stdout or nil
end

local function base_lines(path)
  local dir = vim.fs.dirname(path)
  local text = git({ "show", "HEAD:./" .. vim.fs.basename(path) }, dir)
  if not text then
    return {} -- untracked or new file: everything shows as added
  end
  local lines = vim.split(text, "\n", { plain = true })
  if lines[#lines] == "" then
    table.remove(lines)
  end
  return lines
end

-- Each rendered row maps back to a new-file line number for <CR>.
local function line_for_row(row_text)
  local _, new = row_text:match("^%s*(%d*)%s+(%d+)%s")
  return tonumber(new)
end

local function render(view_buf, src_buf)
  local path = vim.api.nvim_buf_get_name(src_buf)
  local old = base_lines(path)
  local new = vim.api.nvim_buf_get_lines(src_buf, 0, -1, false)
  local lines, highlights, focus = require("pulse.ui.diff").from_lines(old, new, { context = 3 })

  vim.bo[view_buf].modifiable = true
  vim.api.nvim_buf_set_lines(view_buf, 0, -1, false, lines)
  vim.bo[view_buf].modifiable = false
  vim.api.nvim_buf_clear_namespace(view_buf, ns, 0, -1)
  for _, h in ipairs(highlights) do
    pcall(vim.api.nvim_buf_set_extmark, view_buf, ns, h.row, h.start_col, {
      end_col = math.min(h.end_col, #lines[h.row + 1]),
      hl_group = h.group,
      priority = h.priority,
      hl_mode = h.hl_mode,
    })
  end
  return focus
end

function M.open()
  local src_buf = vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(src_buf)
  if path == "" or vim.bo[src_buf].buftype ~= "" then
    return vim.notify("Not a file buffer", vim.log.levels.WARN)
  end

  local view_buf = vim.api.nvim_create_buf(false, true)
  vim.bo[view_buf].bufhidden = "wipe"
  vim.api.nvim_buf_set_name(view_buf, "diff://" .. vim.fn.fnamemodify(path, ":~:."))

  vim.cmd("tabnew")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, view_buf)
  for opt, val in pairs({
    number = false,
    relativenumber = false,
    signcolumn = "no",
    foldcolumn = "0",
    colorcolumn = "",
    cursorline = true,
    wrap = false,
    list = false,
  }) do
    vim.wo[win][opt] = val
  end
  -- Same as pulse: syntax colors from the file's filetype under the diff marks.
  vim.bo[view_buf].filetype = vim.bo[src_buf].filetype

  local focus = render(view_buf, src_buf)
  pcall(vim.api.nvim_win_set_cursor, win, { focus, 0 })

  local function map(lhs, fn, desc)
    vim.keymap.set("n", lhs, fn, { buffer = view_buf, nowait = true, silent = true, desc = desc })
  end
  map("q", "<cmd>tabclose<cr>", "Close diff")
  map("r", function()
    render(view_buf, src_buf)
  end, "Refresh diff")
  map("<CR>", function()
    local lnum = line_for_row(vim.api.nvim_get_current_line())
    vim.cmd("tabclose")
    if vim.api.nvim_buf_is_valid(src_buf) then
      vim.api.nvim_set_current_buf(src_buf)
      if lnum then
        pcall(vim.api.nvim_win_set_cursor, 0, { lnum, 0 })
      end
    end
  end, "Jump to line")

  -- Follow the source as it changes (saves here or reloads from outside).
  local au = vim.api.nvim_create_autocmd({ "BufWritePost", "FileChangedShellPost", "TextChanged" }, {
    buffer = src_buf,
    callback = function()
      if vim.api.nvim_buf_is_valid(view_buf) then
        render(view_buf, src_buf)
      end
    end,
  })
  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = view_buf,
    once = true,
    callback = function()
      pcall(vim.api.nvim_del_autocmd, au)
    end,
  })
end

return M
