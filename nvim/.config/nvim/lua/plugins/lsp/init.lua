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
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local nls = require("null-ls")

            nls.setup({
                on_init = function(new_client, _)
                    new_client.offset_encoding = "utf-16"
                end,
                sources = {
                    nls.builtins.formatting.black,
                    nls.builtins.formatting.clang_format,
                    nls.builtins.formatting.eslint_d,
                    nls.builtins.formatting.prettierd.with({
                        extra_filetypes = { "svelte" },
                    }),
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
