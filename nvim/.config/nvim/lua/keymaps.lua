function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- better moving keys
Map('n', '<leader>wh', ':wincmd h<CR>', { silent = true })
Map('n', '<leader>wj', ':wincmd j<CR>', { silent = true })
Map('n', '<leader>wk', ':wincmd k<CR>', { silent = true })
Map('n', '<leader>wl', ':wincmd l<CR>', { silent = true })

Map('t', '<ESC>', '<C-\\><C-n><CR>')

-- better indentation
Map('v', '<', '<gv')
Map('v', '>', '>gv')

-- better moving lines
Map('v', 'J', ':m \'>+1<CR>gv=gv')
Map('v', 'K', ':m \'<-2<CR>gv=gv')

-- undotree
Map('n', '<Leader>u', ':UndotreeShow<CR>')

-- resizing
Map('n', '<Leader>-', ':vertical resize -5<CR>')
Map('n', '<Leader>=', ':vertical resize +5<CR>')

-- ctrl+backspace
-- api.nvim_set_keyMap('i', '<C-h>', '<C-w>', opts)

-- U = redo
Map('n', 'U', '<C-r>')

-- tab movements
Map('n', '<leader>n', ':bn<CR>')
Map('n', '<leader>p', ':bp<CR>')
Map('n', '<leader>tn', ':tabnew<Space>')
Map('n', '<leader>tm', ':tabmove<Space>')
Map('n', '<leader>tc', ':tabclose<CR>')
Map('n', '<leader>to', ':tabonly<CR>')

-- quickfix
Map('n', '<leader>j', ':cnext<CR>')
Map('n', '<leader>k', ':cprev<CR>')

-- file tree
Map('n', '<leader>f', ':NvimTreeToggle<CR>')

-- lsp
Map('n', '<leader>gd', ':lua vim.lsp.buf.definition()<CR>')
Map('n', '<leader>gi', ':lua vim.lsp.buf.implementation()<CR>')
Map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
Map('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
Map('n', '<leader>gr', ':lua vim.lsp.buf.references()<CR>')


-- telescope
local builtin = require('telescope.builtin')
Map('n', '<leader>.', builtin.find_files)

-- toggleterm
Map('n', '<leader>ot', ':ToggleTerm<CR>')

-- vim.cmd('autocmd BufWritePre * lua vim.lsp.buf.format()')
