-- keymaps

vim.g.mapleader = ' '
local opts = { noremap = true, silent = true }

-- pairs
-- vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<Esc>O', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '{}', '{}', { noremap = true, silent = true })

-- better moving keys
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', {silent = true})

-- better indentation
vim.api.nvim_set_keymap('v', '<', '<gv', opts)
vim.api.nvim_set_keymap('v', '>', '>gv', opts)

-- better moving lines
vim.api.nvim_set_keymap('v', 'J', ':m \'>+1<CR>gv=gv', opts)
vim.api.nvim_set_keymap('v', 'K', ':m \'<-2<CR>gv=gv', opts)

-- undotree
vim.api.nvim_set_keymap('n', '<Leader>u', ':UndotreeShow<CR>', opts)

-- resizing
vim.api.nvim_set_keymap('n', '<Leader>-', ':vertical resize -5<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>=', ':vertical resize +5<CR>', opts)

-- ctrl+backspace
vim.api.nvim_set_keymap('i', '<C-h>', '<C-w>', opts)

-- tab movements
vim.api.nvim_set_keymap('n', '<Leader>n', ':tabn<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>p', ':tabp<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tn', ':tabnew<Space>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tm', ':tabmove<Space>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tp', ':tabclose<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>to', ':tabonly<CR>', {noremap = true})

-- quickfix
vim.api.nvim_set_keymap('n', '<Leader>j', ':cnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>k', ':cprev<CR>', opts)

-- file tree
vim.api.nvim_set_keymap('n', '<Leader>f', ':NvimTreeToggle<CR>', {noremap = true})

-- toggle term
function _G.set_terminal_keymaps()
  local opt = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<C-[>', [[<C-\><C-n>]], opt)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opt)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opt)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opt)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opt)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opt)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- lsp
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)

-- telescope
vim.api.nvim_set_keymap('n', '<Leader>tt', ':Telescope find_file<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>tf', ':Telescope find_file<CR>', opts)

-- competitive programming (toggle term)
-- vim.api.nvim_set_keymap('n', '<Leader>c', ':w <bar> :TermExec cmd="g++ -o %:r % -std=c++17 -O3 -Wall -lm -ggdb -fsanitize=address,undefined" size=50 direction=float go_back=0<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<Leader>r', ':TermExec cmd="./%:r" size=50 direction=tab go_back=0<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<Leader>r', ':TermExec cmd="python3 %:r.py" size=50 direction=tab go_back=0<CR>', opts)
-- vim.cmd('autocmd FileType cpp nnoremap :TermExec cmd="./%:r" size=50 direction=tab go_back=0<CR>')
-- vim.cmd('autocmd FileType python nnoremap :TermExec cmd="python3 %:r" size=50 direction=tab go_back=0<CR>')

vim.api.nvim_exec(
[[
autocmd FileType cpp nnoremap <leader>c :w <bar> :TermExec cmd="g++ -o %:r % -std=c++17 -O3 -Wall -lm -ggdb -fsanitize=address,undefined" size=50 direction=float go_back=0<CR>
autocmd FileType cpp nnoremap <leader>r :TermExec cmd="./%:r" size=50 direction=tab go_back=0<CR>
autocmd FileType python nnoremap <leader>r :TermExec cmd="python %" size=50 direction=tab go_back=0<CR>
]], false)
