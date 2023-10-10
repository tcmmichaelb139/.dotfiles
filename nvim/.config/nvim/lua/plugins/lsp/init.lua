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
		"stevearc/conform.nvim",
		event = "BufReadPre",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { { "prettierd", "prettier" } },
					cpp = { "clang-format" },
					bash = { "shfmt" },
					java = { "google-java-format" },
					json = { "prettierd", "prettier" },
					tex = { "latexindent" },
					markdown = { "markdownlint" },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}
