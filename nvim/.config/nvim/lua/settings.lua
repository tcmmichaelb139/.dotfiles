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

-- credit folke
local M = {}
_G.Status = M

---@return {name:string, text:string, texthl:string}[]
function M.get_signs()
    local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    return vim.tbl_map(function(sign)
        return vim.fn.sign_getdefined(sign.name)[1]
    end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
end

function M.column()
    local sign, git_sign
    for _, s in ipairs(M.get_signs()) do
        if s.name:find("GitSign") then
            git_sign = s
        else
            sign = s
        end
    end

    local nu = " "
    local number = vim.api.nvim_win_get_option(vim.g.statusline_winid, "number")
    if number and vim.wo.relativenumber and vim.v.virtnum == 0 then
        nu = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
    end
    local components = {
        sign and ("%#" .. sign.texthl .. "#" .. sign.text .. "%*") or "  ",
        [[%=]],
        nu .. " ",
        git_sign and ("%#" .. git_sign.texthl .. "#" .. git_sign.text .. "%*") or "  ",
    }
    return table.concat(components, "")
end

if vim.fn.has("nvim-0.9.0") == 1 then
    vim.opt.statuscolumn = [[%!v:lua.Status.column()]]
end

return M
