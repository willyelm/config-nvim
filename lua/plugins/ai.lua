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
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>a",
        function()
          local context = vim.fn.expand("%:p")
          -- Add selection if in visual mode
          if vim.fn.mode():match("[vV]") then
            vim.cmd('normal! "vy')
            context = context .. "\n\n" .. vim.fn.getreg('v')
          end
          -- Use Telescope picker
          require('telescope.pickers').new({}, {
            prompt_title = 'Select AI Tool',
            finder = require('telescope.finders').new_table({
              results = {
                { display = 'Claude Code', cmd = 'claude --permission-mode bypassPermissions' },
                { display = 'Open Code',   cmd = 'opencode' },
                { display = 'Codex',       cmd = 'codex' },
              },
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.display,
                  ordinal = entry.display,
                }
              end,
            }),
            sorter = require('telescope.config').values.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
              local actions = require('telescope.actions')
              local action_state = require('telescope.actions.state')
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.ui.input({ prompt = '❯ Question: ' }, function(question)
                  if not question then return end
                  local prompt = context .. "\n\n" .. question
                  vim.cmd('botright 15split')
                  vim.fn.termopen(selection.value.cmd, { on_exit = function() end })
                  vim.api.nvim_chan_send(vim.b.terminal_job_id, prompt .. "\n")
                  vim.cmd('startinsert')
                end)
              end)
              return true
            end,
          }):find()
        end,
        mode = { "n", "v" },
        desc = "Ask AI"
      }
    }
  }
  -- {
  --   "nvim-lua/plenary.nvim",
  --   keys = {
  --     {
  --       "<leader>a",
  --       function()
  --         local context = vim.fn.expand("%:p")
  --
  --         -- Add selection if in visual mode
  --         if vim.fn.mode():match("[vV]") then
  --           vim.cmd('normal! "vy')
  --           context = context .. "\n\n" .. vim.fn.getreg('v')
  --         end
  --
  --         -- Pick tool and ask question
  --         vim.ui.select({ "claude", "opencode", "codex" }, { prompt = "AI tool:" }, function(tool)
  --           if not tool then return end
  --
  --           vim.ui.input({ prompt = "Question: " }, function(question)
  --             if not question then return end
  --
  --             -- Escape for shell
  --             local escaped_context = context:gsub('"', '\\"'):gsub('\n', '\\n')
  --             local escaped_question = question:gsub('"', '\\"')
  --
  --             local cmd
  --             if tool == "claude" then
  --               cmd = 'claude --permission-mode bypassPermissions -p "' ..
  --               escaped_context .. '\\n\\n' .. escaped_question .. '"'
  --             elseif tool == "opencode" then
  --               cmd = 'opencode -p "' .. escaped_context .. '\\n\\n' .. escaped_question .. '"'
  --             else -- codex
  --               cmd = 'codex -p "' .. escaped_context .. '\\n\\n' .. escaped_question .. '"'
  --             end
  --
  --             vim.cmd('botright 15split')
  --             vim.cmd('term ' .. cmd)
  --           end)
  --         end)
  --       end,
  --       mode = { "n", "v" },
  --       desc = "Ask AI"
  --     }
  --   }
  -- }
}
