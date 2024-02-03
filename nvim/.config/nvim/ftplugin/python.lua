local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map(
  "n",
  "<leader>r",
  ":w | :TermExec cmd='python3 \"%\"' size=50 direction=tab go_back=0<CR>",
  { desc = "Run Python File" }
)
