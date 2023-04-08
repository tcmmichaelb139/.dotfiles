return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function()
            local tokyonight = require("tokyonight")

            tokyonight.setup({
                style = "night",
                terminal_colors = true,
                on_highlights = function(hl, c)
                    hl.TelescopeNormal = {
                        bg = c.bg,
                        fg = c.fg,
                    }
                    hl.TelescopeBorder = {
                        bg = c.bg,
                        fg = c.comment,
                    }
                    hl.TelescopePromptBorder = {
                        bg = c.bg,
                        fg = c.comment,
                    }
                    hl.TelescopePromptTitle = {
                        bg = c.bg,
                        fg = c.cyan,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = c.bg,
                        fg = c.cyan,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = c.bg,
                        fg = c.cyan,
                    }
                    hl.FloatBorder = {
                        bg = c.bg,
                        fg = c.border_highlight,
                    }
                    hl.NormalFloat = {
                        bg = c.bg,
                        fg = c.border_highlight,
                    }
                end,
            })
            tokyonight.load()
        end,
    },
    { "rebelot/kanagawa.nvim",    event = "VeryLazy" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        event = "VeryLazy",
    },
    { "EdenEast/nightfox.nvim",   event = "VeryLazy" },
    { "ellisonleao/gruvbox.nvim", event = "VeryLazy" },
}
