vim.pack.add {
  { src = 'https://github.com/neogitorg/neogit', version = vim.version.range '*' },
}

vim.keymap.set('n', '<leader>gg', '<Cmd>Neogit<CR>', { desc = 'Neogit' })

require('neogit').setup {
  auto_refresh = true,
  disable_builtin_notifications = false,
  use_magit_keybindings = false,
  -- Change the default way of opening neogit
  kind = 'tab',
  -- Change the default way of opening the commit popup
  commit_popup = {
    kind = 'split',
  },
  -- Change the default way of opening popups
  popup = {
    kind = 'split',
  },
}
