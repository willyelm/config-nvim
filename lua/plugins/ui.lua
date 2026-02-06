return {    
  -- Breadcrumbs (Winbar)
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic" },
    opts = {
        show_modified = true, -- Crucial for tracking unsaved state
	show_navic_icon = false,
        symbols = { separator = "/", modified = "*", ellipsis = "..." },
    },
  },
  -- Statusline with Git Branch and LSP status
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = "auto",
        --icons_enabled = false,
        component_separators = "|",
        section_separators = "",     
      },
      sections = {
        lualine_b = {'branch', 'diff', 'diagnostics'},
      }
    }
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- 1. The Logo (Header)
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }

      -- 2. The Buttons (Shortcuts)
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
        dashboard.button("p", "  Recent Projects", ":Telescope projects <CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
        dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- 3. The Footer (Project Context)
      local stats = vim.uv.uptime()
      dashboard.section.footer.val = "Nvim loaded in " .. stats .. "ms"

      -- 4. Apply Highlights
      dashboard.section.header.opts.hl = "Function"
      dashboard.section.buttons.opts.hl = "Identifier"
      dashboard.section.footer.opts.hl = "Comment"

      alpha.setup(dashboard.config)
    end,
  },
}
