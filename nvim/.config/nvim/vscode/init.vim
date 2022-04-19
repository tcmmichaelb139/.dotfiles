" Sets {{{
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set joinspaces
set number
set relativenumber
set nohlsearch
set incsearch
set smartcase
set scrolloff=15
set hidden
set nowrap
set noswapfile
set nobackup
set undofile
set undodir=/Users/tcmb139/.cache/nvim/undodir
set backspace=indent,eol,start
set foldmethod=marker
set title
set noerrorbells
set nocursorline
set nocursorcolumn
set splitright
set splitbelow
set completeopt=menuone,noselect,noinsert
set shortmess=c
set clipboard=unnamedplus
set updatetime=50
set signcolumn=yes

set lazyredraw " }}}

" plugins {{{
if exists('g:vscode')
    call plug#begin()

    Plug 'tpope/vim-commentary'

    call plug#end()
endif
" }}}

" keybinds {{{
let mapleader = " "
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

vnoremap < <gv
vnoremap > >gv

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>+ :vertical resize +5<CR>

nnoremap <leader>n :tabnext<CR>
nnoremap <leader>p :tabp<CR>
nnoremap <leader>tn :tabnew<Space>
nnoremap <leader>tm :tabmove<Space>
nnoremap <leader>tp :tabclose<CR>
nnoremap <leader>to :tabonly<CR>


" }}}
