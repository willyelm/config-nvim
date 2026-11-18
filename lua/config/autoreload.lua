-- Reload buffers the moment their file changes on disk (edits from another
-- tool, git checkout, an agent), instead of waiting for focus or CursorHold.
-- The reload goes through :checktime, so 'autoread' applies, unmodified
-- buffers reload silently, and attached LSP servers get a didChange with the
-- new contents.

local uv = vim.uv
local group = vim.api.nvim_create_augroup("willyelm_autoreload", { clear = true })
local watchers = {} ---@type table<integer, uv.uv_fs_event_t>
local pending = {} ---@type table<integer, boolean>

local function busy()
  local mode = vim.api.nvim_get_mode().mode
  return mode:find("^[icR]") ~= nil
end

local function check(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  if busy() then
    -- Never reload mid-insert or mid-cmdline; retry when it settles.
    pending[bufnr] = true
    return
  end
  pending[bufnr] = nil
  vim.cmd("silent! checktime " .. bufnr)
end

local function unwatch(bufnr)
  local w = watchers[bufnr]
  if w then
    watchers[bufnr] = nil
    if not w:is_closing() then
      w:stop()
      w:close()
    end
  end
end

local function watch(bufnr)
  unwatch(bufnr)
  if vim.bo[bufnr].buftype ~= "" then
    return
  end
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" or not uv.fs_stat(path) then
    return
  end
  local w = uv.new_fs_event()
  if not w then
    return
  end
  watchers[bufnr] = w
  local timer
  w:start(path, {}, function(err)
    if err then
      return
    end
    -- Debounce bursts (formatters and atomic saves emit several events).
    if timer then
      timer:stop()
    else
      timer = uv.new_timer()
    end
    timer:start(80, 0, vim.schedule_wrap(function()
      check(bufnr)
      -- Atomic saves (write temp + rename) replace the inode and silence the
      -- old watcher, so re-arm on the current file after every change.
      if watchers[bufnr] == w and vim.api.nvim_buf_is_valid(bufnr) then
        watch(bufnr)
      end
    end))
  end)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "BufFilePost" }, {
  group = group,
  callback = function(args)
    watch(args.buf)
  end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  group = group,
  callback = function(args)
    unwatch(args.buf)
    pending[args.buf] = nil
  end,
})

-- Flush reloads that arrived while typing.
vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave", "ModeChanged" }, {
  group = group,
  callback = function()
    vim.schedule(function()
      for bufnr in pairs(pending) do
        check(bufnr)
      end
    end)
  end,
})

-- Fallback for anything the watcher missed (network drives, deleted and
-- recreated files).
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = group,
  callback = function(args)
    if not busy() then
      vim.cmd("silent! checktime")
      if args.event ~= "CursorHold" and not watchers[args.buf] then
        watch(args.buf)
      end
    end
  end,
})

-- Make the reload visible instead of silent.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = group,
  callback = function(args)
    vim.notify("Reloaded " .. vim.fn.fnamemodify(args.file, ":~:."), vim.log.levels.INFO)
  end,
})
