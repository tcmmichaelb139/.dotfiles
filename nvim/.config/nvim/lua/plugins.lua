return {
	"MunifTanjim/nui.nvim",
	"nvim-lua/plenary.nvim",
	{ "github/copilot.vim", lazy = false },

	{ "rebelot/kanagawa.nvim", lazy = false },
	{
		"catppuccin/nvim",
		as = "catppuccin",
		lazy = false,
	},
	{ "EdenEast/nightfox.nvim", lazy = false },
	{ "ellisonleao/gruvbox.nvim", lazy = false },
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
