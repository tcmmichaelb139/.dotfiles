return {
    "folke/which-key.nvim",
    {
        "mbbill/undotree",
        cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
    },
    { "NvChad/nvim-colorizer.lua",  ft = { "css" } },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 100
        end,
    },
    { "nvim-tree/nvim-web-devicons" },
    {
        "goolord/alpha-nvim",
        event = "BufWinEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    },
}
