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
						accept = "<C-Right>", -- Accept the full ghost text
						next = "<C-Down>", -- Cycle to the next suggestion
						prev = "<C-Up>", -- Cycle to the previous suggestion
						dismiss = "<C-Left>", -- Keep C-e for "Escape/End"
						accept_word = "<C-l>",
						accept_line = "<C-f>",
					},
				},
			})
		end,
	},
}
