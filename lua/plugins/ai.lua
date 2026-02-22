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
						accept = "<M-f>", -- ⌥→  accept suggestion
						dismiss = "<M-b>", -- ⌥←  dismiss
						next = "<M-Down>", -- ⌥↓  next suggestion
						prev = "<M-Up>", -- ⌥↑  prev suggestion
						accept_word = "<M-w>", -- ⌥w  accept word
						accept_line = "<M-l>", -- ⌥l  accept line
					},
				},
			})
		end,
	},
	-- {
	-- 	dir = "~/Git/sidekick.nvim",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("sidekick").setup({
	-- 			hints = {
	-- 				enabled = true
	-- 				tip = "Implement with AI (⌥+a)",
	-- 			},
	-- 			tools = {
	-- 				claude = "claude --permission-mode bypassPermissions",
	-- 				ollama = "ollama launch claude",
	-- 			},
	-- 		})
	-- 	end,
	-- 	keys = {
	-- 		{ "<M-a>", "<cmd>Sidekick<cr>", desc = "Start agent tool" },
	-- 	},
	-- },
}
