local M = {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	enabled = false,
}

function M.config()
	local nls = require("null-ls")

	nls.setup({
		sources = {
			nls.builtins.completion.luasnip,

			nls.builtins.diagnostics.eslint,
			-- nls.builtins.diagnostics.cppcheck,
			nls.builtins.diagnostics.jsonlint,
			nls.builtins.diagnostics.ktlint,
			nls.builtins.diagnostics.markdownlint,
			nls.builtins.diagnostics.pylint,
			nls.builtins.diagnostics.selene,
			nls.builtins.diagnostics.shellcheck,
			nls.builtins.diagnostics.stylelint,
			nls.builtins.diagnostics.zsh,

			nls.builtins.formatting.black,
			nls.builtins.formatting.clang_format,
			nls.builtins.formatting.eslint,
			nls.builtins.formatting.ktlint,
			nls.builtins.formatting.markdownlint,
			nls.builtins.formatting.prettier,
			nls.builtins.formatting.shfmt,
			nls.builtins.formatting.stylua,
			nls.builtins.formatting.yamlfmt,
		},

		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end,
	})
end

return M
