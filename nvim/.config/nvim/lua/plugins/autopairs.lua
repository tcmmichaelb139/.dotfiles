return {
	"windwp/nvim-autopairs",
	event = "BufReadPre",

	config = function()
		require("nvim-autopairs").setup({})
	end,
}
