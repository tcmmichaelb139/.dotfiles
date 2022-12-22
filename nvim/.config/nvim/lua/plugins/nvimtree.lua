local M = {
	"nvim-tree/nvim-tree.lua",
	cmd = {
		"NvimTreeClipboard",
		"NvimTreeClose",
		"NvimTreeCollapse",
		"NvimTreeCollapseKeepBuffers",
		"NvimTreeFindFile",
		"NvimTreeFindFileToggle",
		"NvimTreeFocus",
		"NvimTreeOpen",
		"NvimTreeRefresh",
		"NvimTreeResize",
		"NvimTreeToggle",
	},

	dependencies = "nvim-tree/nvim-web-devicons",
}

function M.config()
	require("nvim-tree").setup({
		filters = {
			dotfiles = false,
			exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
		},
		disable_netrw = true,
		hijack_netrw = true,
		open_on_setup = false,
		ignore_ft_on_setup = { "alpha" },
		hijack_cursor = true,
		hijack_unnamed_buffer_when_opening = false,
		update_cwd = true,
		update_focused_file = {
			enable = true,
			update_cwd = false,
		},
		view = {
			adaptive_size = true,
			side = "left",
			width = 25,
			hide_root_folder = true,
		},
		git = {
			enable = false,
			ignore = true,
		},
		filesystem_watchers = {
			enable = true,
		},
		actions = {
			open_file = {
				resize_window = true,
			},
		},
		renderer = {
			highlight_git = false,
			highlight_opened_files = "none",

			indent_markers = {
				enable = false,
			},

			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = false,
				},

				glyphs = {
					default = "",
					symlink = "",
					folder = {
						default = "",
						empty = "",
						empty_open = "",
						open = "",
						symlink = "",
						symlink_open = "",
						arrow_open = "",
						arrow_closed = "",
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌",
					},
				},
			},
		},
	})
end

return M