local o = vim.o

vim.g.mapleader = " "

-- settings
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4
o.expandtab = true
o.joinspaces = false

o.number = true
o.relativenumber = true

o.hlsearch = false
o.incsearch = true

o.smartcase = true
o.scrolloff = 15
o.hidden = true
o.wrap = false
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
o.backspace = "indent,eol,start"
o.foldmethod = "marker"
o.title = true
o.errorbells = false
o.cursorline = false
o.cursorcolumn = false
o.splitright = true
o.splitbelow = true
o.completeopt = "menuone,noselect,noinsert"
o.shortmess = "c"
o.clipboard = "unnamedplus"
o.updatetime = 50
o.signcolumn = "yes"
o.lazyredraw = false
o.timeoutlen = 250
o.showmode = false
o.shortmess = "filnxtToOFWIcC"

-- o.foldexpr = "nvim_treesitter#foldexpr()"
-- o.foldlevel = 6
-- o.foldmethod = "expr"

vim.opt.list = true

local gitsigns_bar = "▌"

local gitsigns_hl_pool = {
    GitSignsAdd = "GitSignsAdd",
    GitSignsChange = "GitSignsChange",
    GitSignsChangedelete = "GitSignsChange",
    GitSignsDelete = "GitSignsDelete",
    GitSignsTopdelete = "GitSignsDelete",
    GitSignsUntracked = "GitSignsAdd",
}

local diag_signs_icons = {
    DiagnosticSignError = " ",
    DiagnosticSignWarn = " ",
    DiagnosticSignHint = " ",
    DiagnosticSignInfo = " ",
}

local function get_sign_name(cur_sign)
    if cur_sign == nil then
        return nil
    end

    cur_sign = cur_sign[1]

    if cur_sign == nil then
        return nil
    end

    cur_sign = cur_sign.signs

    if cur_sign == nil then
        return nil
    end

    cur_sign = cur_sign[1]

    if cur_sign == nil then
        return nil
    end

    return cur_sign["name"]
end

local function mk_hl(group, sym)
    return table.concat({ "%#", group, "#", sym, "%*" })
end

local function get_name_from_group(bufnum, lnum, group)
    local cur_sign_tbl = vim.fn.sign_getplaced(bufnum, {
        group = group,
        lnum = lnum,
    })

    return get_sign_name(cur_sign_tbl)
end

local function get_statuscol_gitsign(bufnum, lnum)
    local cur_sign_nm = get_name_from_group(bufnum, lnum, "gitsigns_vimfn_signs_")

    if cur_sign_nm ~= nil then
        return mk_hl(gitsigns_hl_pool[cur_sign_nm], gitsigns_bar)
    else
        return " "
    end
end

local function get_statuscol_diag(bufnum, lnum)
    local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")

    if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "DiagnosticSign") then
        return mk_hl(cur_sign_nm, diag_signs_icons[cur_sign_nm])
    else
        return "  "
    end
end

_G.get_statuscol = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lnum = vim.v.lnum
    local str_table = {}

    local parts = {
        ["diagnostics"] = get_statuscol_diag(bufnr, lnum),
        ["fold"] = "%C",
        ["gitsigns"] = get_statuscol_gitsign(bufnr, lnum),
        ["num"] = "%{v:relnum?v:relnum:v:lnum}",
        ["sep"] = "%=",
        ["signcol"] = "%s",
        ["space"] = " ",
    }

    local order = {
        "diagnostics",
        "fold",
        "sep",
        "num",
        "space",
        "gitsigns",
        "space",
    }

    for _, val in ipairs(order) do
        table.insert(str_table, parts[val])
    end

    return table.concat(str_table)
end

vim.o.statuscolumn = "%!v:lua.get_statuscol()"
