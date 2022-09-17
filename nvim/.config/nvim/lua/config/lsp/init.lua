local lspconfig = require('lspconfig')


-- Automatically update diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
	severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- {{{ c++ lsp
-- lspconfig.clangd.setup{ on_attach = on_attach }
require'lspconfig'.ccls.setup{on_attach = on_attach}-- }}}

-- {{{ python lsp
lspconfig.pyright.setup{ on_attach = on_attach }-- }}}

-- --{{{ lua lsp
-- -- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
-- USER = vim.fn.expand('$USER')
--
-- local system_name
-- if vim.fn.has("mac") == 1 then
-- 	system_name = "macOS"
-- elseif vim.fn.has("unix") == 1 then
-- 	system_name = "Linux"
-- elseif vim.fn.has('win32') == 1 then
-- 	system_name = "Windows"
-- else
-- 	print("Unsupported system for sumneko")
-- end
--
-- -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
-- local sumneko_root_path = '/Users/'..USER..'/.config/nvim/lsps/lua-language-server'
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
--
-- require'lspconfig'.sumneko_lua.setup {
-- 	on_attach = on_attach,
-- 	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				-- Get the language server to recognize the `vim` global
-- 				globals = {'vim'},
-- 			},
-- 			workspace = { 
-- 				maxPreload = 100000,
-- 				preloadFileSize = 10000,
-- 			},
-- 		},
-- 	},
-- }--}}}

-- {{{ bash lsp
require'lspconfig'.bashls.setup{ on_attach = on_attach }-- }}}

--{{{ html and css and angular 
--Enable (broadcasting) snippet capability for completion

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

local project_library_path = "/path/to/project/lib"
local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

require'lspconfig'.angularls.setup{
  cmd = cmd,
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
}

--}}}
