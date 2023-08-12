local wk = require("which-key")

local leader = {
    ["r"] = {
        ":w | :TermExec cmd='python3 \"%\"' size=50 direction=tab go_back=0<CR>",
        "Run",
    },
}

wk.register(leader, { prefix = "<leader>" })
