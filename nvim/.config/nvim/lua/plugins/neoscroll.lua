return {
	"karb94/neoscroll.nvim",
	-- event = "VeryLazy",
	keys = { "<C-u>", "<C-d>", "gg", "G" },
	enabled = false,
	config = function()
		require("neoscroll").setup({
			mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
			hide_cursor = true,
		})
		local map = {}

		map["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "80" } }
		map["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "80" } }
		map["zt"] = { "zt", { "150" } }
		map["zz"] = { "zz", { "150" } }
		map["zb"] = { "zb", { "150" } }

		require("neoscroll.config").set_mappings(map)
	end,
}
