vim.keymap(
	"n",
	"<Leader>r",
	':w | :TermExec cmd="python3 %" size=50 direction=tab go_back=0<CR>',
	{ noremap = true, silent = true }
)
