local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	},
}

function M.config()
	require("nvim-treesitter.configs").setup({
		-- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"help",
			"java",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"regex",
			"svelte",
			"typescript",
			"vim",
			"yaml",
		},
		sync_install = true,
		autopairs = {
			enable = true,
		},
		highlight = {
			enable = true, -- false will disable the whole extension
			-- disable = { "c", "rust" },  -- list of language that will be disabled
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = true,
		},
	})
end

return M
