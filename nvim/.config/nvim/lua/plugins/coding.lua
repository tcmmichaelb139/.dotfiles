return {
	{
		"windwp/nvim-autopairs",
		event = "BufReadPre",

		config = function()
			local npairs = require("nvim-autopairs")

			npairs.setup({})
		end,
	},
	{
		"terrortylor/nvim-comment",
		keys = { { "gc", mode = { "n", "v" }, "gcc" } },

		config = function()
			require("nvim_comment").setup({
				-- Linters prefer comment and line to have a space in between markers
				marker_padding = true,
				-- should comment out empty or whitespace only lines
				comment_empty = true,
				-- Should key mappings be created
				create_mappings = true,
				-- Normal mode mapping left hand side
				line_mapping = "gcc",
				-- Visual/Operator mapping left hand side
				operator_mapping = "gc",
				-- Hook function to call before commenting takes place
				hook = nil,
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		-- event = "VeryLazy",
		keys = { "<C-u>", "<C-d>", "gg", "G" },
		enabled = false,
		config = function()
			require("neoscroll").setup({
				mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
				hide_cursor = true,
			})
			local map = {}

			map["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "80" } }
			map["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "80" } }
			map["zt"] = { "zt", { "150" } }
			map["zz"] = { "zz", { "150" } }
			map["zb"] = { "zb", { "150" } }

			require("neoscroll.config").set_mappings(map)
		end,
	},
	{
		"akinsho/nvim-toggleterm.lua",
		cmd = { "TermExec", "ToggleTerm" },
		config = function()
			require("toggleterm").setup({
				-- size can be a number or function which is passed the current terminal
				-- size = 20 | function(term)
				function(term)
					if term.direction == "horizontal" then
						return 20
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				hide_numbers = false, -- hide the number column in toggleterm buffers
				shade_filetypes = {},
				shade_terminals = true,
				start_in_insert = true,
				insert_mappings = false, -- whether or not the open mapping applies in insert mode
				persist_size = true,
				-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
				direction = "horizontal",
				close_on_exit = true, -- close the terminal window when the process exits
				shell = zsh, -- change the default shell
				-- This field is only relevant if direction is set to 'float'
				float_opts = {
					-- The border key is *almost* the same as 'nvim_open_win'
					-- see :h nvim_open_win for details on borders however
					-- the 'curved' border is a custom border type
					-- not natively supported but implemented in this plugin.
					-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
					border = "curved",
					winblend = 3,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})
		end,
	},
}
