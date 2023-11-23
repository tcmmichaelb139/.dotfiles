-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map("t", "<ESC>", "<C-\\><C-n>")

-- U = redo
map("n", "U", "<C-r>", { desc = "Redo" })

vim.keymap.del("n", "s")
