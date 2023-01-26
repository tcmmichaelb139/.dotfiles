return {
    {
        {
            "zbirenbaum/copilot.lua",
            event = "InsertEnter",
            config = function()
                require("copilot").setup({
                    suggestion = {
                        auto_trigger = true,
                        debounce = 75,
                        keymap = {
                            accept = "<C-l>",
                        },
                    },
                    filetypes = {
                        yaml = true,
                        cpp = false,
                        ["."] = true,
                    },
                })
            end,
        },
        {
            "zbirenbaum/copilot-cmp",
            event = "InsertEnter",
            config = function()
                require("copilot_cmp").setup()
            end,
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "onsails/lspkind-nvim",
        },

        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                formatting = {
                    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
                },

                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                },
                sources = {
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "path" },
                },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
            })
        end,
    },
}
