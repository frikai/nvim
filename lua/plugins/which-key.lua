local function gh(repo) return 'https://github.com/' .. repo end

-- Useful plugin to show you pending keybinds.
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  -- Delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    { '<leader>f', group = 'Telescope [F]ind', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>g', group = '[G]it', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
    { '<leader>gt', group = '[G]it [T]oggle', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
    { '<leader>l', group = '[L]SP Actions', mode = { 'n' } },
    { '<leader>aN', '<cmd>tabnew %<cr>', desc = 'New Tab' },
    { '<leader>ah', '<cmd>-tabmove<cr>', desc = 'Move Left' },
    { '<leader>al', '<cmd>+tabmove<cr>', desc = 'Move Right' },
    { '<leader>an', '<cmd>$tabnew<cr>', desc = 'New Empty Tab' },
    { '<leader>ao', '<cmd>tabonly<cr>', desc = 'Only' },
    { '<leader>ac', '<cmd>tabclose<cr>', desc = 'Close Tab' },
    { '<leader>aj', '<cmd>Tabby jump_to_tab<cr>', desc = 'Jump To Tab' },
    { '<leader>;', '<cmd>Alpha<cr>', desc = 'Show Greeter' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
