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
                    local servers = require("plugins.lsp.servers")

                    for server, opts in pairs(servers) do
                        opts.capabilities = capabilities
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
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local nls = require("null-ls")

            nls.setup({
                sources = {
                    nls.builtins.formatting.black,
                    nls.builtins.formatting.clang_format,
                    nls.builtins.formatting.eslint,
                    nls.builtins.formatting.prettierd,
                    nls.builtins.formatting.shfmt,
                    nls.builtins.formatting.stylua,
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
