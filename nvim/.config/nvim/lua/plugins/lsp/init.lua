return {
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		lazy = false,
		ensure_installed = {},
		config = function(plugin)
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		name = "lsp",
		event = "BufReadPre",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local lspconfig = require("lspconfig")

			vim.diagnostic.config({
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

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local servers = require("plugins.lsp.servers")

			for server, opts in pairs(servers) do
				opts.capabilities = capabilities
				require("lspconfig")[server].setup(opts)
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		config = function()
			local nls = require("null-ls")

			nls.setup({
				sources = {
					nls.builtins.formatting.black,
					nls.builtins.formatting.clang_format,
					nls.builtins.formatting.eslint,
					nls.builtins.formatting.prettier,
					nls.builtins.formatting.shfmt,
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.yamlfmt,

					nls.builtins.hover.dictionary,
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
		end,
	},
}
