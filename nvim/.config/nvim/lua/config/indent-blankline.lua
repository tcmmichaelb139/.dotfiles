vim.opt.list = true
-- vim.opt.listchars:append("space:·")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
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
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    }
