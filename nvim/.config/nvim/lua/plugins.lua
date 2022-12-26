return {
	"MunifTanjim/nui.nvim",
	"nvim-lua/plenary.nvim",
	"folke/which-key.nvim",
	-- { "github/copilot.vim", lazy = false },
	{ "rebelot/kanagawa.nvim", event = "VeryLazy" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		event = "VeryLazy",
	},
	{ "EdenEast/nightfox.nvim", event = "VeryLazy" },
	{ "ellisonleao/gruvbox.nvim", event = "VeryLazy" },
	{
		"mbbill/undotree",
		cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
	},
	{ "NvChad/nvim-colorizer.lua", ft = { "css" } },
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
}
