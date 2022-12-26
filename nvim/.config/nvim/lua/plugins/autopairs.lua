return {
	"windwp/nvim-autopairs",
	event = "BufReadPre",

	config = function()
		local npairs = require("nvim-autopairs")

		npairs.setup({})
	end,
}
