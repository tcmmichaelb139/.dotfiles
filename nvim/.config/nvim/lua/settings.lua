local o = vim.o

-- settings
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4
o.expandtab = true
o.joinspaces = false
o.number = true
o.relativenumber = true
o.hlsearch = false
o.incsearch = true
o.smartcase = true
o.scrolloff = 15
o.hidden = true
o.wrap = false
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = '/Users/tcmb139/.cache/nvim/undodir'
o.backspace = 'indent,eol,start'
o.foldmethod = 'marker'
o.title = true
o.errorbells = false
o.cursorline = false
o.cursorcolumn = false
o.splitright = true
o.splitbelow = true
o.completeopt = 'menuone,noselect,noinsert'
o.shortmess = 'c'
o.clipboard = 'unnamedplus'
o.updatetime = 50
o.signcolumn = 'yes'
o.lazyredraw = true
o.timeoutlen = 250
o.showmode = false

vim.cmd("colorscheme tokyonight-night")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme catppuccin-mocha")
-- vim.cmd("colorscheme nightfox")
-- vim.cmd("colorscheme gruvbox")
