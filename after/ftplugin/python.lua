vim.keymap.set('n', '<leader>r', '<cmd>split | term python3 %<CR>', {
  buffer = true,
  silent = true,
  desc = 'Run Python file in built-in terminal',
})
