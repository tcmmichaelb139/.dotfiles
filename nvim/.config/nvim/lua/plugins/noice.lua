local M = {
    "folke/noice.nvim",
    event = "VeryLazy",

    dependencies = {
        "MunifTanjim/nui.nvim",
    },
}

function M.config()
    require("noice").setup({
        presets = {
            command_palette = true,
            long_message_to_split = true,
            cmdline_output_to_split = false,
        },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            progress = {
                enabled = false,
            },
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            },
        },
    })
end

return M
