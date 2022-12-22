local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
}

function M.config()
	require("indent_blankline").setup({
		buftype_exclude = { "terminal", "nofile" },
		filetype_exclude = {
			"help",
			"terminal",
			"alpha",
			"packer",
			"lspinfo",
			"TelescopePrompt",
			"TelescopeResults",
			"mason",
			"",
			"NvimTree",
		},
		show_trailing_blankline_indent = false,
	})
end

return M
