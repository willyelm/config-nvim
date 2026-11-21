-- Byte-compile and cache Lua modules; roughly a quarter off startup.
vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local plugins = {
  { src = "https://github.com/willyelm/pulse.nvim" },
  { src = "https://github.com/willyelm/clasp" },
  { src = "https://github.com/Saghen/blink.lib" },
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/Bekaboo/dropbar.nvim", name = "dropbar" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/milanglacier/minuet-ai.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
}

-- Local dev: load plugins directly from source. Must come before vim.pack.add,
-- or vim.loader resolves the installed copy instead.
-- vim.opt.rtp:prepend("/Users/willyelm/Git/pulse.nvim")
-- vim.opt.rtp:prepend("/Users/willyelm/Git/clasp.nvim")

-- Build blink.cmp's Rust fuzzy matcher in the background after an install or
-- update. Building at startup blocked Neovim, and every new instance started a
-- competing cargo build that timed out.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local data = ev.data
    if data.spec.name ~= "blink.cmp" or data.kind == "delete" then
      return
    end
    vim.notify("blink.cmp: building fuzzy matcher in the background…")
    vim.system({ "cargo", "build", "--release" }, { cwd = data.path }, function(res)
      vim.schedule(function()
        if res.code == 0 then
          vim.notify("blink.cmp: fuzzy matcher built; active on next start")
        else
          vim.notify("blink.cmp: build failed, using Lua matcher\n" .. (res.stderr or ""), vim.log.levels.WARN)
        end
      end)
    end)
  end,
})

vim.pack.add(plugins, { load = true, confirm = false })

-- Everything else lives in plugin/*.lua, sourced automatically after this
-- file (alphabetically); lsp/*.lua holds the language server configs.
