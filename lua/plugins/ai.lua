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
				desc = "Run AI",
			},
		},
		opts = {
			hint_text = "Implement with AI (⌥+a)",
			tools = {
				Claude = "claude --permission-mode bypassPermissions",
				Codex = "codex",
			},
		},
	},
}
