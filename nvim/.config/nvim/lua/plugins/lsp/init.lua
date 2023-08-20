require("plugins.lsp.diagnostics")

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		cmd = "Mason",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"jayp0521/mason-null-ls.nvim",
		},
		config = function()
			require("mason").setup({})

			require("mason-lspconfig").setup({
				automatic_installation = true,
			})

			require("mason-lspconfig").setup_handlers({
				function()
					local capabilities =
						require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
					capabilities.offsetEncoding = { "utf-16" }

					local servers = require("plugins.lsp.servers")

					local handlers = {
						["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
						["textDocument/signatureHelp"] = vim.lsp.with(
							vim.lsp.handlers.signature_help,
							{ border = "single" }
						),
					}
					for server, opts in pairs(servers) do
						opts.capabilities = capabilities
						opts.handlers = handlers
						require("lspconfig")[server].setup(opts)
					end
				end,
			})
			require("mason-null-ls").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
	},
	{
		"nvimdev/guard.nvim",
		event = "BufReadPre",
		config = function()
			local ft = require("guard.filetype")

			ft("lua"):fmt("stylua")
			ft("c,cpp,json"):fmt("clang-format")
			ft("python"):fmt({ cmd = "black", args = { "--quiet", "-" }, stdin = true })
			ft("sh"):fmt("shfmt")
			ft("javascript,typescript,javascriptreact,typescriptreact,json"):fmt("prettierd")
			ft("tex"):fmt("latexindent")
			ft("java"):fmt("google-java-format")

			require("guard").setup({
				-- the only options for the setup function
				fmt_on_save = true,
				-- Use lsp if no formatter was defined for this filetype
				lsp_as_default_formatter = false,
			})
		end,
	},
}
