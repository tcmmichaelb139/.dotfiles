require("gitsigns").setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	},
	-- signs = {
	-- 	add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
	-- 	change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
	-- 	delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
	-- 	topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
	-- 	changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
	-- },
})
