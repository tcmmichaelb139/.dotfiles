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
                    local prompt = "#2d3149"
                    hl.TelescopeNormal = {
                        bg = c.bg_dark,
                        fg = c.fg_dark,
                    }
                    hl.TelescopeBorder = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopePromptNormal = {
                        bg = prompt,
                    }
                    hl.TelescopePromptBorder = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePromptTitle = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
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
