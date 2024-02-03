local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map(
  "n",
  "<leader>rr",
  ":w | :TermExec cmd='cr \"%\"' size=50 direction=tab go_back=0<CR>",
  { desc = "Compile and Run C++ File" }
)

map(
  "n",
  "<leader>rd",
  ":w | :TermExec cmd='cr \"%\" -d' size=50 direction=tab go_back=0<CR>",
  { desc = "Compile and Run C++ File with Debug" }
)
