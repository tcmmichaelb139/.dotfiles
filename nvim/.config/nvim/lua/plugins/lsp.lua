local M = {
	"neovim/nvim-lspconfig",
	name = "lsp",
	event = "BufReadPre",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
}

function M.config()
	local lspconfig = require("lspconfig")

	-- Automatically update diagnostics
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		update_in_insert = false,
		virtual_text = { spacing = 4 },
		severity_sort = true,
	})

	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- local border = {
	-- 	{ "╭", "FloatBorder" },
	-- 	{ "─", "FloatBorder" },
	-- 	{ "╮", "FloatBorder" },
	-- 	{ "│", "FloatBorder" },
	-- 	{ "╯", "FloatBorder" },
	-- 	{ "─", "FloatBorder" },
	-- 	{ "╰", "FloatBorder" },
	-- 	{ "│", "FloatBorder" },
	-- }

	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or border
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end

	require("lspconfig").clangd.setup({})

	-- {{{ c++ lsp
	-- lspconfig.ccls.setup({
	-- 	cmd = { "ccls" },
	-- 	init_options = {
	-- 		index = {
	-- 			threads = 0,
	-- 			initialBlacklist = { ".*" },
	-- 			comments = 0,
	-- 		},
	-- 		cache = {
	-- 			directory = "/Users/tcmb139/.cache/ccls",
	-- 		},
	-- 		clang = {
	-- 			extraArgs = {
	-- 				"-Wall",
	-- 				"-O2",
	-- 				"-Wextra",
	-- 				"-Wshadow",
	-- 				"-Wconversion",
	-- 				"-Wfloat-equal",
	-- 				"-Wduplicated-cond",
	-- 				"-Wlogical-op",
	-- 				"-std=c++17",
	-- 				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/../../../../../../include/c++/12",
	-- 				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/../../../../../../include/c++/12/aarch64-apple-darwin21",
	-- 				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/../../../../../../include/c++/12/backward",
	-- 				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/include",
	-- 				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/include-fixed",
	-- 				"-isystem/library/developer/commandlinetools/sdks/macosx12.sdk/usr/include",
	-- 				"-isystem/library/developer/commandlinetools/sdks/macosx12.sdk/system/library/frameworks",
	-- 			},
	-- 		},
	-- 	},
	-- })
	-- }}}
end

return M
