local M = {}

function M.get_lsp_capabilities()
  return require("blink.cmp").get_lsp_capabilities()
end

function M.setup()
  -- vim.pack has no `build` hook (unlike lazy.nvim), so blink.cmp's Rust
  -- fuzzy matcher must be built manually before setup.
  require("blink.cmp").build():wait(60000)

  require("blink.cmp").setup({
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
