local M = {
  "ggandor/leap.nvim",
}

function M.config()
  require("leap")
  vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
  vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
  vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
end

return M

