local M = {}

-- Native vim.ui.input/select render as plain bottom-line prompts; give them
-- a rounded box docked at the bottom of the screen instead. Interaction
-- stays native: prompt-buffer's own <CR>-submits/<Esc>-cancels, no new
-- keymaps.
local function bottom_dock(width, height)
  return {
    relative = "editor",
    anchor = "SW",
    row = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus == 3 and 1 or 0),
    col = math.floor((vim.o.columns - width) / 2),
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
  }
end

local function setup_prompts()
  vim.ui.input = function(opts, on_confirm)
    opts = opts or {}
    local prompt = (opts.prompt or "Input") .. ": "

    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buftype = "prompt"
    vim.fn.prompt_setprompt(buf, prompt)
    vim.fn.prompt_setcallback(buf, function(value)
      vim.api.nvim_win_close(0, true)
      on_confirm(value)
    end)
    vim.fn.prompt_setinterrupt(buf, function()
      vim.api.nvim_win_close(0, true)
      on_confirm(nil)
    end)
    if opts.default then
      vim.api.nvim_buf_set_lines(buf, 0, 1, false, { prompt .. opts.default })
    end

    vim.api.nvim_open_win(buf, true, bottom_dock(math.min(80, vim.o.columns - 4), 1))
    vim.cmd("startinsert!")
  end

  vim.ui.select = function(items, opts, on_choice)
    opts = opts or {}
    local format_item = opts.format_item or tostring

    local lines, width = {}, 20
    for i, item in ipairs(items) do
      lines[i] = string.format("%d. %s", i, format_item(item))
      width = math.max(width, #lines[i] + 2)
    end
    width = math.min(width, vim.o.columns - 4)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false

    local win_config = bottom_dock(width, math.min(#lines, 15))
    win_config.title = opts.prompt or "Select"
    win_config.title_pos = "center"
    local win = vim.api.nvim_open_win(buf, true, win_config)

    vim.keymap.set("n", "<CR>", function()
      local idx = vim.api.nvim_win_get_cursor(win)[1]
      vim.api.nvim_win_close(win, true)
      on_choice(items[idx], idx)
    end, { buffer = buf })
    vim.keymap.set("n", "<Esc>", function()
      vim.api.nvim_win_close(win, true)
      on_choice(nil, nil)
    end, { buffer = buf })
  end
end

function M.setup()
  setup_prompts()

  require("nvim-web-devicons").setup({
    default = true,
    strict = true,
    color_icons = true,
    icons = true,
  })

  require("dropbar").setup({
    menu = {
      win_configs = {
        border = "rounded",
        style = "minimal",
      },
    },
  })

  require("lualine").setup({
    options = {
      globalstatus = true,
      theme = require("theme.lualine"),
      section_separators = { left = "", right = "" },
      component_separators = { left = "/", right = "/" },
    },
    sections = {
      lualine_a = { "branch" },
      lualine_b = { "diff", "diagnostics" },
      lualine_x = {
        {
          "filesize",
          cond = function()
            return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
          end,
        },
        "encoding",
        "fileformat",
      },
    },
  })

  local colorizer_filetypes = {
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "go",
    "html",
    "json",
    "jsonc",
    "json5",
    "yaml",
    "yml",
    "lua",
    "markdown",
    "mdx",
  }

  local colorizer = require("colorizer")

  colorizer.setup({
    filetypes = {
      unpack(colorizer_filetypes),
    },
    options = {
      parsers = {
        css_fn = true,
        css = true,
        names = { enable = false },
        -- The Tailwind LSP path can return stale/out-of-range columns during
        -- rehighlight on WinScrolled, which crashes extmark placement.
        -- Keep bundled Tailwind color parsing enabled and disable the LSP
        -- documentColor integration until upstream handles those ranges safely.
        tailwind = { enable = true, lsp = false, update_names = false },
        custom = {
          {
            name = "oklch",
            prefixes = { "oklch", "Oklch" },
            parse = function(ctx)
              local start, end_pos, l, c, h = ctx.line:find(
                "[Oo]klch%s*%(%s*([%d.]+)%%?%s*[, ]%s*([%d.]+)%s*[, ]%s*([%d.]+)%s*%)",
                ctx.col
              )
              if not start then
                return
              end
              l, c, h = tonumber(l), tonumber(c), tonumber(h)
              if not l or not c or not h then
                return
              end
              if l > 1 then
                l = l / 100
              end
              h = h * (math.pi / 180)
              local a, b = c * math.cos(h), c * math.sin(h)
              local l_, m_, s_ =
                  l + 0.3963377774 * a + 0.2158037573 * b,
                  l - 0.1055613458 * a - 0.0638541728 * b,
                  l - 0.0894841775 * a - 1.2914855480 * b
              local l3, m3, s3 = l_ * l_ * l_, m_ * m_ * m_, s_ * s_ * s_
              local r, g, b_out =
                  4.0767416621 * l3 - 3.3077363322 * m3 + 0.2309101289 * s3,
                  -1.2684380046 * l3 + 2.6097574011 * m3 - 0.3413193761 * s3,
                  -0.0041960863 * l3 - 0.7034186147 * m3 + 1.7076147010 * s3
              local gamma = function(v)
                return v <= 0.0031308 and 12.92 * v or 1.055 * v ^ (1 / 2.4) - 0.055
              end
              r, g, b_out =
                  math.max(0, math.min(1, gamma(r))),
                  math.max(0, math.min(1, gamma(g))),
                  math.max(0, math.min(1, gamma(b_out)))
              return end_pos - start + 1,
                  string.format(
                    "%02x%02x%02x",
                    math.floor(r * 255),
                    math.floor(g * 255),
                    math.floor(b_out * 255)
                  )
            end,
          },
        },
      },
      display = {
        mode = "background",
      },
    },
  })

  if vim.tbl_contains(colorizer_filetypes, vim.bo.filetype) then
    colorizer.attach_to_buffer(0)
  end
end

return M
