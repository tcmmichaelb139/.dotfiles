local wk = require("which-key")

local leader = {
	["r"] = {
		name = "+run",
		["r"] = { ":w | :TermExec cmd='cr %:r.cpp' size=50 direction=tab go_back=0<CR>", "Run" },
		["d"] = { ":w | :TermExec cmd='cr %:r.cpp -d' size=50 direction=tab go_back=0<CR>", "Debug" },
	},
}

wk.register(leader, { prefix = "<leader>" })
