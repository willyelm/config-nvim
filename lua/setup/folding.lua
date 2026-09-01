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

-- Keep the fold's first line, then a " 󰁂 N lines" counter, clamped to width.
local function fold_virt_text(virt_text, lnum, end_lnum, width, truncate)
  local result = {}
  local suffix = (" 󰁂 %d lines "):format(end_lnum - lnum)
  local suffix_width = vim.fn.strdisplaywidth(suffix)
  local target_width = width - suffix_width
  local cur_width = 0

  for _, chunk in ipairs(virt_text) do
    local text = chunk[1]
    local chunk_width = vim.fn.strdisplaywidth(text)
    if target_width > cur_width + chunk_width then
      table.insert(result, chunk)
    else
      text = truncate(text, target_width - cur_width)
      table.insert(result, { text, chunk[2] })
      chunk_width = vim.fn.strdisplaywidth(text)
      if cur_width + chunk_width < target_width then
        suffix = suffix .. (" "):rep(target_width - cur_width - chunk_width)
      end
      break
    end
    cur_width = cur_width + chunk_width
  end

  table.insert(result, { suffix, "UfoFoldedEllipsis" })
  return result
end

function M.setup()
  require("ufo").setup({
    open_fold_hl_timeout = 150,
    fold_virt_text_handler = fold_virt_text,
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

  local ufo = require("ufo")
  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = desc })
  end

  map("<leader>z", "za", "Toggle fold under cursor")
  map("zR", ufo.openAllFolds, "Open all folds")
  map("zM", ufo.closeAllFolds, "Close all folds")
  map("zr", ufo.openFoldsExceptKinds, "Open folds one level")
  map("zm", ufo.closeFoldsWith, "Close folds one level")
  map("<leader>K", function()
    -- Peek the folded lines; if the cursor is not on a fold, fall through to
    -- the LSP hover so the key is always useful.
    if not ufo.peekFoldedLinesUnderCursor() then
      vim.lsp.buf.hover({ border = "rounded" })
    end
  end, "Peek fold / hover")

  M.persist_views()
end

-- Save/restore fold (and cursor) state per file across sessions. ufo applies
-- its folds as manual folds, so `mkview` captures which ones are closed.
function M.persist_views()
  vim.opt.viewoptions = { "folds", "cursor" }

  local group = vim.api.nvim_create_augroup("willyelm_fold_view", { clear = true })

  local function eligible(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    return vim.bo[buf].buftype == ""
      and vim.bo[buf].filetype ~= ""
      and name ~= ""
      and vim.fn.filereadable(name) == 1
  end

  vim.api.nvim_create_autocmd("BufWinLeave", {
    group = group,
    callback = function(args)
      if eligible(args.buf) then
        pcall(vim.cmd.mkview, { mods = { emsg_silent = true } })
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function(args)
      if eligible(args.buf) then
        pcall(vim.cmd.loadview, { mods = { emsg_silent = true } })
      end
    end,
  })
end

return M
