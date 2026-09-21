local M = {}

-- AI completion (needs a running FIM server, see README).
local AI_COMPLETION_ENABLED = true

function M.get_lsp_capabilities()
  return require("blink.cmp").get_lsp_capabilities()
end

function M.setup()
  require("minuet").setup({
    provider = "openai_fim_compatible",
    n_completions = 1,
    context_window = 512,
    throttle = 1000,
    debounce = 400,
    -- Both default to 0 for this provider, which disables minuet's own
    -- dedup filter -- lets the model re-echo code already before/after
    -- the cursor as part of the completion.
    after_cursor_filter_length = 15,
    before_cursor_filter_length = 15,
    provider_options = {
      openai_fim_compatible = {
        api_key = "TERM",
        name = "Ollama",
        end_point = "http://localhost:11434/v1/completions",
        model = "qwen2.5-coder:7b",
        optional = {
          max_tokens = 56,
          top_p = 0.9,
        },
      },
    },
  })
  if not AI_COMPLETION_ENABLED then
    vim.cmd("Minuet blink disable")
  end

  local blink = require("blink.cmp")

  -- Compiles blink.cmp's fuzzy matcher on first install / after updates.
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
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      menu = {
        border = "rounded",
        winblend = 15,
        draw = {
          treesitter = { "lsp" },
          padding = { 2, 2 },
          columns = {
            { "kind_icon" },
            { "label",      "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },
      ghost_text = {
        enabled = true,
        show_without_selection = true,
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
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    snippets = { preset = "default" },
    sources = {
      default = { "lsp", "snippets", "path", "buffer", "minuet" },
      providers = {
        lsp = { max_items = 20 },
        buffer = {
          min_keyword_length = 4,
          max_items = 5,
          opts = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
        },
        minuet = {
          name = "fim",
          module = "minuet.blink",
          async = true,
          timeout_ms = 3000,
          score_offset = 100,
          -- openai_fim_compatible doesn't trim trailing whitespace itself.
          -- openai_fim_compatible skips the leading/trailing whitespace
          -- trim minuet's other backends apply, so stray blank lines and
          -- indentation duplication land in accepted completions verbatim.
          transform_items = function(_, items)
            local trim = require("minuet.utils").trim_completion_item
            local out = {}
            for _, item in ipairs(items) do
              if item.insertText then
                local trimmed = trim(item.insertText)
                if trimmed then
                  item.insertText = trimmed
                  table.insert(out, item)
                end
              else
                table.insert(out, item)
              end
            end
            return out
          end,
        },
      },
    },
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = {
        menu = { auto_show = true },
        list = { selection = { preselect = false } },
      },
    },
    term = { enabled = false },
  })

  require("nvim-autopairs").setup({})
end

return M
