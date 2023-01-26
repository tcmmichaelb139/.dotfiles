return {
    "folke/which-key.nvim",
    {
        "mbbill/undotree",
        cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
    },
    { "NvChad/nvim-colorizer.lua", ft = { "css" } },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 100
        end,
    },
    { "nvim-tree/nvim-web-devicons" },
    {
        "folke/todo-comments.nvim",
        event = "BufReadPost",
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
}
