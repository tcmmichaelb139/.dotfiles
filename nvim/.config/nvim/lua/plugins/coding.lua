return {
    {
        "windwp/nvim-autopairs",
        event = "BufReadPre",

        config = function()
            local npairs = require("nvim-autopairs")

            npairs.setup({
                check_ts = true,
            })
        end,
    },
    {
        "terrortylor/nvim-comment",
        keys = { { "gc", mode = { "n", "v" }, "gcc" } },

        config = function()
            require("nvim_comment").setup({
                -- Linters prefer comment and line to have a space in between markers
                marker_padding = true,
                -- should comment out empty or whitespace only lines
                comment_empty = true,
                -- Should key mappings be created
                create_mappings = true,
                -- Normal mode mapping left hand side
                line_mapping = "gcc",
                -- Visual/Operator mapping left hand side
                operator_mapping = "gc",
                -- Hook function to call before commenting takes place
                hook = nil,
            })
        end,
    },
    {
        "karb94/neoscroll.nvim",
        -- event = "VeryLazy",
        keys = { "<C-u>", "<C-d>", "gg", "G" },
        enabled = false,
        config = function()
            require("neoscroll").setup({
                mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
                hide_cursor = true,
            })
            local map = {}

            map["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "80" } }
            map["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "80" } }
            map["zt"] = { "zt", { "150" } }
            map["zz"] = { "zz", { "150" } }
            map["zb"] = { "zb", { "150" } }

            require("neoscroll.config").set_mappings(map)
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = {
            "NvimTreeClipboard",
            "NvimTreeClose",
            "NvimTreeCollapse",
            "NvimTreeCollapseKeepBuffers",
            "NvimTreeFindFile",
            "NvimTreeFindFileToggle",
            "NvimTreeFocus",
            "NvimTreeOpen",
            "NvimTreeRefresh",
            "NvimTreeResize",
            "NvimTreeToggle",
        },

        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-tree").setup({
                filters = {
                    dotfiles = false,
                    exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
                },
                disable_netrw = true,
                hijack_netrw = true,
                open_on_setup = false,
                ignore_ft_on_setup = { "alpha" },
                hijack_cursor = true,
                hijack_unnamed_buffer_when_opening = false,
                update_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_cwd = false,
                },
                view = {
                    adaptive_size = true,
                    side = "left",
                    width = 25,
                    hide_root_folder = true,
                },
                git = {
                    enable = true,
                    ignore = true,
                },
                filesystem_watchers = {
                    enable = true,
                },
                actions = {
                    open_file = {
                        resize_window = true,
                    },
                },
                renderer = {
                    highlight_git = false,
                    highlight_opened_files = "none",

                    indent_markers = {
                        enable = false,
                    },

                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = false,
                        },

                        glyphs = {
                            default = "",
                            symlink = "",
                            folder = {
                                default = "",
                                empty = "",
                                empty_open = "",
                                open = "",
                                symlink = "",
                                symlink_open = "",
                                arrow_open = "",
                                arrow_closed = "",
                            },
                            git = {
                                unstaged = "✗",
                                staged = "✓",
                                unmerged = "",
                                renamed = "➜",
                                untracked = "★",
                                deleted = "",
                                ignored = "◌",
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "akinsho/nvim-toggleterm.lua",
        cmd = { "TermExec", "ToggleTerm" },
        config = function()
            require("toggleterm").setup({
                -- size can be a number or function which is passed the current terminal
                -- size = 20 | function(term)
                function(term)
                    if term.direction == "horizontal" then
                        return 20
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4
                    end
                end,
                hide_numbers = false, -- hide the number column in toggleterm buffers
                shade_filetypes = {},
                shade_terminals = true,
                start_in_insert = true,
                insert_mappings = false, -- whether or not the open mapping applies in insert mode
                persist_size = true,
                -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
                direction = "horizontal",
                close_on_exit = true, -- close the terminal window when the process exits
                shell = zsh, -- change the default shell
                -- This field is only relevant if direction is set to 'float'
                float_opts = {
                    -- The border key is *almost* the same as 'nvim_open_win'
                    -- see :h nvim_open_win for details on borders however
                    -- the 'curved' border is a custom border type
                    -- not natively supported but implemented in this plugin.
                    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
                    border = "curved",
                    winblend = 3,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<tab>",
                function()
                    require("luasnip").jump(1)
                end,
                mode = "s",
            },
            {
                "<s-tab>",
                function()
                    require("luasnip").jump( -1)
                end,
                mode = { "i", "s" },
            },
        },
    },
    {
        "toppair/peek.nvim",
        build = "cd ~/.local/share/nvim/lazy/peek.nvim && deno task --quiet build:fast",
        cmd = { "PeekOpen", "PeekClose" },
        config = function()
            require("peek").setup({})
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
        ft = "markdown",
    },
}
