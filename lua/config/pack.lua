local M = {}

local plugins = {
  { src = "https://github.com/Saghen/blink.lib" },
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/milanglacier/minuet-ai.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/echasnovski/mini.surround" },
  { src = "https://github.com/andymass/vim-matchup" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/willyelm/pulse.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/Bekaboo/dropbar.nvim", name = "dropbar" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
}

function M.setup()
  -- Parsers are compiled against nvim-treesitter's queries; after an update the
  -- old parsers can fail new queries (broken highlights until a restart), so
  -- rebuild them whenever the plugin changes. Registered before add() so it
  -- also covers the first install.
  vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("willyelm_pack_hooks", { clear = true }),
    callback = function(ev)
      local data = ev.data
      if data.spec.name == "nvim-treesitter" and data.kind == "update" then
        if not data.active then
          vim.cmd.packadd("nvim-treesitter")
        end
        require("nvim-treesitter").update()
      end
    end,
  })

  vim.pack.add(plugins, { load = true, confirm = false })

  -- Local dev: load pulse.nvim directly from source
  -- vim.opt.rtp:prepend("/Users/willyelm/Git/pulse.nvim")

  require("setup.cmp").setup()
  require("setup.diagnostics").setup()
  require("setup.treesitter").setup()
  require("setup.textobjects").setup()
  require("setup.folding").setup()
  require("setup.editing").setup()
  require("setup.lsp").setup()
  require("setup.format").setup()
  require("setup.git").setup()
  require("setup.search").setup()
  require("setup.ui").setup()
end

return M
