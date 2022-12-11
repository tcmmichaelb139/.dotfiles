-- plugins

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path })
end

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

return require('packer').startup(function()
    -- Packer can manage itself
    use({ 'wbthomason/packer.nvim' })

    -- lsp
    use({
        "neovim/nvim-lspconfig",
        config = [[require('config.lsp')]],
    })

    -- completion
    use({
        "hrsh7th/nvim-cmp",
        config = [[require('config.cmp')]],
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            -- "L3MON4D3/LuaSnip",
            "onsails/lspkind-nvim",
        }
    })

    -- treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        config = [[require('config.treesitter')]]
    })

    -- telescope
    use({ 'nvim-lua/plenary.nvim' })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
    use({
        'nvim-telescope/telescope.nvim',
        config = [[require('config.telescope')]],
        requires = 'nvim-lua/plenary.nvim'
    })

    -- undotree
    use({
        'mbbill/undotree',
        cmd = { 'UndotreeShow', 'UndotreeToggle', 'UndotreeHide', 'UndotreeFocus' }
    })

    -- comments
    use({
        'terrortylor/nvim-comment',
        config = [[require('config.comment')]]
    })

    -- autopairs
    use({
        'windwp/nvim-autopairs',
        config = [[require('config.autopairs')]],
        event = "InsertEnter",
    })

    -- which key
    use({
        "folke/which-key.nvim",
        config = [[require('config.which-key')]]
    })

    -- colorscheme
    use({
        'folke/tokyonight.nvim',
    })

    use({
        'rebelot/kanagawa.nvim',
    })

    use({
        "catppuccin/nvim", as="catppuccin",
    })

    use({
        "EdenEast/nightfox.nvim"
    })

    use({
        "ellisonleao/gruvbox.nvim"
    })


    -- statusline
    use({
        'nvim-lualine/lualine.nvim',
        config = [[require('config.lualine')]],
    })

    -- bufferline
    use({
        'akinsho/bufferline.nvim',
        config = [[require('config.bufferline')]],
        requires = 'nvim-tree/nvim-web-devicons',
    })

    -- nvim tree
    use({
        'nvim-tree/nvim-tree.lua',
        config = [[require('config.tree')]],
        requires = 'nvim-tree/nvim-web-devicons',
    })

    -- toggle term
    use({
        'akinsho/toggleterm.nvim',
        config = [[require('config.toggleterm')]]
    })

    -- use ({
    -- 	'lukas-reineke/indent-blankline.nvim',
    -- 	config = [[require('config.indent-blankline')]]
    -- })

    -- ccs colors
    use({
        'norcalli/nvim-colorizer.lua',
    })

    use({
        'ThePrimeagen/vim-be-good'
    })

    -- startup time
    use({
        'lewis6991/impatient.nvim',
        config = [[require('config.impatient')]]
    })

    use({ 'tweekmonster/startuptime.vim' })



end)
