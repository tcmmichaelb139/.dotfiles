function Map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- better moving keys
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

Map("t", "<ESC>", "<C-\\><C-n>")

Map("n", "<C-s>", "<cmd> w <CR>")

Map("i", "<C-z>", "<C-O>u")

-- nitpicky stuff
Map("n", "J", "mzJ`z")
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")
Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

-- better indentation
Map("v", "<", "<gv")
Map("v", ">", ">gv")

-- better moving lines
Map("v", "J", ":m '>+1<CR>gv=gv")
Map("v", "K", ":m '<-2<CR>gv=gv")

-- undotree
Map("n", "<Leader>u", ":UndotreeToggle<CR>")

-- resizing
Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize -2<CR>")
Map("n", "<C-Right>", ":vertical resize +2<CR>")

-- U = redo
Map("n", "U", "<C-r>")

-- tab movements
Map("n", "<TAB>", ":bn<CR>")
Map("n", "<S-TAB>", ":bp<CR>")
Map("n", "<leader>bd", ":bd<CR>")
-- Map("n", "<leader>tn", ":tabnew<Space>")
-- Map("n", "<leader>tm", ":tabmove<Space>")
-- Map("n", "<leader>tc", ":tabclose<CR>")
-- Map("n", "<leader>to", ":tabonly<CR>")

-- file tree
Map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- lsp
Map("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
Map("n", "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>")
Map("n", "K", ":lua vim.lsp.buf.hover()<CR>")
Map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
Map("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>")

-- telescope
Map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
Map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
Map("n", "<leader>fe", "<cmd> Telescope file_browser <CR>")
Map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
Map("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
Map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
Map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
Map("n", "<leader>fc", "<cmd> Telescope colorschemes <CR>")

-- toggleterm
Map("n", "<leader>ot", ":ToggleTerm size=20<CR>")

Map("t", "<C-h>", "<cmd>wincmd h<CR>")
Map("t", "<C-j>", "<cmd>wincmd j<CR>")
Map("t", "<C-k>", "<cmd>wincmd k<CR>")
Map("t", "<C-l>", "<cmd>wincmd l<CR>")

Map("t", "<C-Up>", "<cmd>resize -2<CR>")
Map("t", "<C-Down>", "<cmd>resize +2<CR>")
Map("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
Map("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- format
Map("n", "<C-f>", ":FormatWrite<CR>")
vim.api.nvim_create_autocmd("BufWritePost", { command = "FormatWrite" })
