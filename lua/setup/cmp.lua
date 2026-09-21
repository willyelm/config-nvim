local M = {}

function M.get_lsp_capabilities()
  return require("blink.cmp").get_lsp_capabilities()
end

function M.setup()
  -- FIM code completion against local Ollama, surfaced through blink.cmp
  -- itself -- no separate frontend, no new keymaps. qwen2.5-coder is used
  -- specifically because Ollama's `insert` (FIM/suffix) capability is
  -- model-dependent -- qwen3-coder:30b returned "does not support insert"
  -- against the same endpoint.
  require("minuet").setup({
    provider = "openai_fim_compatible",
    n_completions = 1,
    context_window = 512,
    throttle = 1000,
    debounce = 400,
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
    -- default preset already binds <C-y> accept, <C-e> hide, <C-n>/<C-p>
    -- select, <C-space> show/docs, <C-k> signature.
    keymap = {
      preset = "default",
      ["<C-Space>"] = { "show", "hide" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
      -- Nothing is preselected, so <CR> only accepts after an explicit
      -- <Tab>/<C-n>; a bare <CR> stays a newline and nvim-autopairs keeps
      -- working.
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      menu = {
        border = "rounded",
        winblend = 15,
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },
      ghost_text = {
        enabled = true,
        -- Preview the top-ranked item (usually minuet, given its
        -- score_offset below) inline without requiring <Tab> first --
        -- <C-y> already accepts whatever's previewed (preset default:
        -- "select first item if none selected, then accept").
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
            -- Only complete words from buffers that are actually on screen.
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
          -- Shown as the source_name column in the menu; name it after the
          -- model actually answering, not the plugin routing the request.
          name = "qwen2.5-coder",
          module = "minuet.blink",
          async = true,
          timeout_ms = 3000,
          score_offset = 100,
          -- openai_fim_compatible (unlike minuet's other backends) doesn't
          -- trim trailing whitespace from the model's raw output, so stray
          -- double-spaces at line ends show up as literal completion text.
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              if item.insertText then
                item.insertText = item.insertText:gsub("[ \t]+\n", "\n"):gsub("[ \t]+$", "")
              end
            end
            return items
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

  vim.keymap.set("n", "<leader><Right>", "<cmd>Minuet blink toggle<cr>", { desc = "Toggle AI completion" })

  -- Snippet placeholders are jumped with <Tab>/<S-Tab> (blink in insert,
  -- Neovim's built-in default in select mode); no extra maps needed.
end

return M
