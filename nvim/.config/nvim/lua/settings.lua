-- settings

vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.joinspaces = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.scrolloff = 15
vim.o.hidden = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = '/home/tcmb139/.cache/nvim/undodir'
vim.o.backspace = 'indent,eol,start'
vim.o.foldmethod = 'marker'
vim.o.title = true
vim.o.errorbells = false
vim.o.cursorline = false
vim.o.cursorcolumn = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.shortmess = 'c'
vim.o.clipboard = 'unnamedplus'
vim.o.updatetime = 50
vim.o.signcolumn = 'yes'

vim.o.lazyredraw = true

-- vim.g.catppuccin_flavour = "macchiato"
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.cmd[[colorscheme catppuccin]]
-- vim.cmd[[highlight NormalFloat guibg=#24283b]]
-- vim.cmd[[highlight FloatBorder guifg=#a9b1d6 guibg=#24283b]]
