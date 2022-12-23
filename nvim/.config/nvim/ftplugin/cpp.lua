vim.keymap.set(
	"n",
	"<Leader>r",
	':TermExec cmd="cr %:r.cpp" size=50 direction=tab go_back=0<CR>',
	{ noremap = true, silent = true }
)
