local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
}

function M.config()
    require("indent_blankline").setup({
        space_char_blankline = " ",
        show_current_context = true,
        buftype_exclude = { "terminal", "nofile" },
        filetype_exclude = {
            "help",
            "terminal",
            "alpha",
            "packer",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "mason",
            "",
            "NvimTree",
        },
        show_trailing_blankline_indent = false,
    })
end

return M
