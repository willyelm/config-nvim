return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<M-f>",      -- ⌥→  accept suggestion
            dismiss = "<M-b>",     -- ⌥←  dismiss
            next = "<M-Down>",     -- ⌥↓  next suggestion
            prev = "<M-Up>",       -- ⌥↑  prev suggestion
            accept_word = "<M-w>", -- ⌥w  accept word
            accept_line = "<M-l>", -- ⌥l  accept line
          },
        },
      })
    end,
  },
  {
    "willyelm/ai-hints.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<M-a>",
        function()
          require("ai-hints").run_ai()
        end,
        desc = "Run AI"
      }
    },
    opts = {
      hint_text = "Implement with AI (⌥+a)",
      tools = {
        Claude = "claude --permission-mode bypassPermissions",
        Codex = "codex",
      }
    }
  }
  -- {
  --   "nvim-lua/plenary.nvim",
  --   config = function()
  --     local ns_id = vim.api.nvim_create_namespace("ai_hints")
  --
  --     -- Function to run AI tool
  --     local function run_ai_tool(tool, prompt, file_path, line_num)
  --       local full_prompt = string.format(
  --         "Context Files:\n%s\nLine: %d\n\nTask:\n%s",
  --         file_path,
  --         line_num,
  --         prompt
  --       )
  --
  --       local base_cmd
  --       if tool == "claude" then
  --         base_cmd = 'claude --permission-mode bypassPermissions'
  --       elseif tool == "codex" then
  --         base_cmd = 'codex'
  --       else
  --         base_cmd = 'opencode'
  --       end
  --
  --       local tmp_file = os.tmpname()
  --       local f = io.open(tmp_file, 'w')
  --       f:write(full_prompt)
  --       f:close()
  --
  --       local current_buf = vim.api.nvim_get_current_buf()
  --       local buf = vim.api.nvim_create_buf(false, true)
  --       vim.api.nvim_buf_set_name(buf, string.format("[AI] %s", prompt:sub(1, 40)))
  --       vim.api.nvim_set_current_buf(buf)
  --
  --       local cmd = string.format('cat %s | %s', tmp_file, base_cmd)
  --       vim.fn.termopen(cmd, {
  --         on_exit = function()
  --           os.remove(tmp_file)
  --         end
  --       })
  --
  --       vim.api.nvim_set_current_buf(current_buf)
  --       vim.notify(string.format("AI running: %s", tool), vim.log.levels.INFO)
  --     end
  --
  --     -- Function to scan buffer and add virtual text
  --     local function update_hints(bufnr)
  --       bufnr = bufnr or vim.api.nvim_get_current_buf()
  --       vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  --
  --       local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  --       local file_path = vim.api.nvim_buf_get_name(bufnr)
  --
  --       for line_num, line in ipairs(lines) do
  --         local todo_match = line:match("TODO:%s*(.+)") or line:match("FIX:%s*(.+)")
  --         if todo_match then
  --           vim.api.nvim_buf_set_extmark(bufnr, ns_id, line_num - 1, 0, {
  --             virt_text = {
  --               { " → ", "Comment" },
  --               { "Claude <l-1>", "DiagnosticHint" },
  --               { " | ", "Comment" },
  --               { "Codex <l-2>", "DiagnosticHint" }
  --             },
  --             virt_text_pos = "eol",
  --           })
  --         end
  --       end
  --     end
  --
  --     -- Keymaps for triggering AI
  --     vim.keymap.set("n", "<leader>1", function()
  --       local line = vim.api.nvim_get_current_line()
  --       local todo_match = line:match("TODO:%s*(.+)") or line:match("FIX:%s*(.+)")
  --       if todo_match then
  --         local file_path = vim.fn.expand("%:p")
  --         local line_num = vim.fn.line(".")
  --         run_ai_tool("claude", todo_match, file_path, line_num)
  --       end
  --     end, { desc = "Run Claude on TODO/FIX" })
  --
  --     vim.keymap.set("n", "<leader>2", function()
  --       local line = vim.api.nvim_get_current_line()
  --       local todo_match = line:match("TODO:%s*(.+)") or line:match("FIX:%s*(.+)")
  --       if todo_match then
  --         local file_path = vim.fn.expand("%:p")
  --         local line_num = vim.fn.line(".")
  --         run_ai_tool("codex", todo_match, file_path, line_num)
  --       end
  --     end, { desc = "Run Codex on TODO/FIX" })
  --
  --     -- Auto-update hints
  --     local group = vim.api.nvim_create_augroup("AIHints", { clear = true })
  --     vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
  --       group = group,
  --       callback = function()
  --         update_hints()
  --       end,
  --     })
  --
  --     -- Initial load
  --     update_hints()
  --   end
  -- }
  -- ,
}
