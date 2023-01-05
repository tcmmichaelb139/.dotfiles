return {
	{
		"zbirenbaum/copilot.lua",
		enabled = false,
		event = "InsertEnter",
		config = function()
			vim.schedule(function()
				require("copilot").setup()
			end)
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
