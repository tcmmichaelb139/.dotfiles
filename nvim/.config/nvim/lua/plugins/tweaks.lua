return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
    keys = {
      { "<leader>uu", "<cmd> UndotreeToggle<CR>", desc = "Undo Tree" },
    },
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
