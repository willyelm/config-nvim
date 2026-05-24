local M = {}

local plugins = {
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/MagicDuck/grug-far.nvim" },
	{ src = "https://github.com/willyelm/pulse.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/utilyre/barbecue.nvim", name = "barbecue" },
	{ src = "https://github.com/SmiteshP/nvim-navic" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua" },
}

function M.setup()
	vim.pack.add(plugins, { load = true, confirm = false })

	-- Local dev: load pulse.nvim directly from source
	-- vim.opt.rtp:prepend("/Users/willyelm/Git/pulse.nvim")

	require("plugins.ai").setup()
	require("plugins.format").setup()
	require("plugins.git").setup()
	require("plugins.lsp").setup()
	require("plugins.search").setup()
	require("plugins.ui").setup()
end

return M
