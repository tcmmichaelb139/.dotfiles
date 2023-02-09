return {
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
                disabled_filetypes = { "packer", "NVimTree" },
            })
        end,
    },
    {
        "akinsho/bufferline.nvim",
        event = "BufReadPre",

        config = function()
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    separator_style = "thick",
                    diagnostics_indicator = function(_, _, diagnostics_dict)
                        local s = " "
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " "
                                or (e == "warning" and " " or (e == "info" and " " or " "))
                            s = s .. " " .. sym .. n
                        end
                        return s
                    end,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Nvim Tree",
                            highlight = "Directory",
                            text_align = "left",
                        },
                    },
                },
            })
        end,
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        event = "BufReadPre",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = function()
            require("barbecue").setup({
                create_autocmd = false, -- prevent barbecue from updating itself automatically
            })

            vim.api.nvim_create_autocmd({
                "WinResized",
                "BufWinEnter",
                "CursorHold",
                "InsertLeave",

                -- include these if you have set `show_modified` to `true`
                "BufWritePost",
                "TextChanged",
                "TextChangedI",
            }, {
                group = vim.api.nvim_create_augroup("barbecue.updater", {}),
                callback = function()
                    require("barbecue.ui").update()
                end,
            })
        end,
        -- opts = {
        --     -- configurations go here
        -- },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("noice").setup({
                presets = {
                    command_palette = true,
                    long_message_to_split = true,
                    cmdline_output_to_split = false,
                    inc_rename = true,
                },
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    progress = {
                        enabled = false,
                    },
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                        },
                        opts = { skip = true },
                    },
                    {
                        filter = {
                            event = "msg_show",
                            kind = "search_count",
                        },
                        opts = { skip = true },
                    },
                },
            })
        end,
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("notify").setup({
                timeout = 3000,
                level = vim.log.levels.INFO,
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.75)
                end,
                render = "minimal",
                stages = "static",
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            require("indent_blankline").setup({
                space_char_blankline = " ",
                show_current_context = true,
                buftype_exclude = { "terminal", "nofile" },
                filetype_exclude = {
                    "help",
                    "terminal",
                    "alpha",
                    "packer",
                    "lspinfo",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "mason",
                    "",
                    "NvimTree",
                },
                show_trailing_blankline_indent = false,
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "BufReadPost",
        opts = {},
        keys = {
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Next todo comment",
            },
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Previous todo comment",
            },
        },
    },
    {
        "tzachar/local-highlight.nvim",
        event = "BufReadPost",
        config = function()
            vim.api.nvim_set_hl(0, "TSDefinitionUsage", { bg = "#2f334d" })
            require("local-highlight").setup({
                file_types = { "*" },
            })
        end,
    },
}
