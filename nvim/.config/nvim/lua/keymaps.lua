function keymap(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- better moving keys
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

keymap("t", "<ESC>", "<C-\\><C-n>")

keymap("n", "<C-s>", "<cmd> w <CR>")

keymap("i", "<C-z>", "<C-O>u")

-- nitpicky stuff
keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- better indentation
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- better moving lines
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- undotree
keymap("n", "<Leader>u", ":UndotreeToggle<CR>")

-- resizing
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- U = redo
keymap("n", "U", "<C-r>")

-- tab movements
keymap("n", "<TAB>", ":bn<CR>")
keymap("n", "<S-TAB>", ":bp<CR>")
keymap("n", "<leader>bd", ":bd<CR>")
-- Map("n", "<leader>tn", ":tabnew<Space>")
-- Map("n", "<leader>tm", ":tabmove<Space>")
-- Map("n", "<leader>tc", ":tabclose<CR>")
-- Map("n", "<leader>to", ":tabonly<CR>")

-- file tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")

-- lsp
keymap("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
keymap("n", "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>")
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>")
keymap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
keymap("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>")

-- telescope
keymap("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
keymap("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
keymap("n", "<leader>fe", "<cmd> Telescope file_browser <CR>")
keymap("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
keymap("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
keymap("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
keymap("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
keymap("n", "<leader>fc", "<cmd> Telescope colorscheme <CR>")

-- toggleterm
keymap("n", "<leader>ot", ":ToggleTerm size=20<CR>")

keymap("t", "<C-h>", "<cmd>wincmd h<CR>")
keymap("t", "<C-j>", "<cmd>wincmd j<CR>")
keymap("t", "<C-k>", "<cmd>wincmd k<CR>")
keymap("t", "<C-l>", "<cmd>wincmd l<CR>")

keymap("t", "<C-Up>", "<cmd>resize -2<CR>")
keymap("t", "<C-Down>", "<cmd>resize +2<CR>")
keymap("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
keymap("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- format
keymap("n", "<C-f>", ":FormatWrite<CR>")
