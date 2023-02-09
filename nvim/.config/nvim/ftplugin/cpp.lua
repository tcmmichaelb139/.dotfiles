local wk = require("which-key")

local leader = {
    ["r"] = {
        name = "+run",
        ["r"] = {
            ":w | :TermExec cmd='cr " .. vim.api.nvim_buf_get_name(0) .. "' size=50 direction=tab go_back=0<CR>",
            "Run",
        },
        ["d"] = {
            ":w | :TermExec cmd='cr " .. vim.api.nvim_buf_get_name(0) .. " -d' size=50 direction=tab go_back=0<CR>",
            "Debug",
        },
    },
}

wk.register(leader, { prefix = "<leader>" })
