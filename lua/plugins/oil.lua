local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'nvim-tree/nvim-web-devicons', gh 'stevearc/oil.nvim' }

local oil = require 'oil'
oil.setup {
  float = {
    max_height = 30,
    max_width = 80,
    padding = 2,
    border = 'rounded', -- rounded, single, double, solid, none
  },
  view_options = {
    show_hidden = true,
  },
  keymaps = { ['q'] = { 'actions.close', mode = 'n' }, ['<Esc>'] = { 'actions.close', mode = 'n' } },
}
vim.keymap.set('n', '-', '<CMD>Oil --preview --float<CR> ', { desc = 'Open parent directory in OIL' })
