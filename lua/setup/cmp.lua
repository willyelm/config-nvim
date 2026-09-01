local M = {}

function M.get_lsp_capabilities()
  return require("blink.cmp").get_lsp_capabilities()
end

function M.setup()
  -- Copilot runs headless (no inline ghost text, no keymaps); its suggestions
  -- are surfaced only as ranked items in the blink.cmp menu via blink-copilot.
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = true, auto_refresh = false },
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
      default = { "lsp", "snippets", "path", "buffer", "copilot" },
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
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          max_items = 3,
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

  vim.keymap.set("n", "<leader>cp", function()
    require("copilot.panel").open()
  end, { desc = "Copilot panel" })

  -- Jump between snippet placeholders regardless of the completion menu state.
  vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if vim.snippet.active({ direction = 1 }) then
      vim.snippet.jump(1)
    end
  end, { desc = "Snippet: next placeholder" })
  vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if vim.snippet.active({ direction = -1 }) then
      vim.snippet.jump(-1)
    end
  end, { desc = "Snippet: previous placeholder" })
end

return M
