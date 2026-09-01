local M = {}

function M.get_lsp_capabilities()
  return require("blink.cmp").get_lsp_capabilities()
end

function M.setup()
  local blink = require("blink.cmp")

  -- vim.pack has no post-install `build` hook (unlike lazy.nvim), so blink.cmp's
  -- Rust fuzzy matcher is built here. The built library is keyed by commit, so
  -- `library_available()` is false only on a fresh install or right after a
  -- blink.cmp update -- that is the only time this actually blocks to compile.
  -- Any other startup skips straight to `setup()`.
  if not blink.library_available() then
    vim.notify("blink.cmp: building native fuzzy matcher (one-time)…", vim.log.levels.INFO)
    local ok, err = pcall(function()
      blink.build():wait(120000)
    end)
    if not ok then
      vim.notify(
        "blink.cmp: native build failed, falling back to Lua matcher (" .. tostring(err) .. ")",
        vim.log.levels.WARN
      )
    end
  end

  blink.setup({
    keymap = {
      preset = "default",
      ["<C-Space>"] = { "show", "hide" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
    completion = {
      menu = {
        border = "rounded",
        winblend = 15,
      },
      ghost_text = {
        enabled = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = "rounded",
          winblend = 15,
        },
      },
    },
    sources = {
      default = { "lsp", "path", "buffer", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  })

  require("nvim-autopairs").setup({})
end

return M
