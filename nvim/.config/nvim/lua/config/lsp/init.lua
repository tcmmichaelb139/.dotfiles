local lspconfig = require("lspconfig")

-- Automatically update diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
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

-- {{{ c++ lsp
lspconfig.ccls.setup({
	cmd = { "ccls" },
	init_options = {
		index = {
			threads = 0,
			initialWhitelist = { "." },
		},
		cache = {
			directory = "/Users/tcmb139/.cache/ccls",
		},
		clang = {
			extraArgs = {
				"-std=c++17",
				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/../../../../../../include/c++/12",
				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/../../../../../../include/c++/12/aarch64-apple-darwin21",
				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/../../../../../../include/c++/12/backward",
				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/include",
				"-isystem/opt/homebrew/cellar/gcc/12.2.0/bin/../lib/gcc/current/gcc/aarch64-apple-darwin21/12/include-fixed",
				"-isystem/library/developer/commandlinetools/sdks/macosx12.sdk/usr/include",
				"-isystem/library/developer/commandlinetools/sdks/macosx12.sdk/system/library/frameworks",
			},
		},
	},
})
-- }}}

-- {{{ python lsp
lspconfig.pyright.setup({ on_attach = on_attach }) -- }}}

--{{{ lua lsp
require("lspconfig").sumneko_lua.setup({})
--}}}

-- {{{ bash lsp
require("lspconfig").bashls.setup({ on_attach = on_attach }) -- }}}

--{{{ html and css and angular
--Enable (broadcasting) snippet capability for completion

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
	capabilities = capabilities,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
	capabilities = capabilities,
})

local project_library_path = "/path/to/project/lib"
local cmd =
	{ "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations", project_library_path }

require("lspconfig").angularls.setup({
	cmd = cmd,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = cmd
	end,
})

--}}}
