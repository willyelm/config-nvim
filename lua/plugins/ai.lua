return {
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			-- Disable Tab to avoid conflict with nvim-cmp
			-- vim.g.copilot_no_tab_map = true
		end,
	},
	-- {
	--   dir = "~/Git/sidekick.nvim",
	--   event = { "BufReadPre", "BufNewFile" },
	--   dependencies = { "nvim-lua/plenary.nvim" },
	--   config = function()
	--     require("sidekick").setup({
	--       hints = {
	--         enabled = true
	--         tip = "Implement with AI (⌥+a)",
	--       },
	--       tools = {
	--         claude = "claude --permission-mode bypassPermissions",
	--         ollama = "ollama launch claude",
	--       },
	--     })
	--   end,
	--   keys = {
	--     { "<M-a>", "<cmd>Sidekick<cr>", desc = "Start agent tool" },
	--   },
	-- },
}
