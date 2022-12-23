return {
	"akinsho/bufferline.nvim",
	event = "BufReadPre",

	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "thick",
				diagnostics_indicator = function(_, _, diagnostics_dict)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and " "
							or (e == "warning" and " " or (e == "info" and " " or " "))
						s = s .. " " .. sym .. n
					end
					return s
				end,
				offsets = {
					{
						filetype = "NvimTree",
						text = "Nvim Tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		})
	end,
}
