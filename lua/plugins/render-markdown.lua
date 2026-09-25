local function gh(repo) return 'https://github.com/' .. repo end
vim.pack.add {
  gh 'MeanderingProgrammer/render-markdown.nvim',
  gh 'nvim-treesitter/nvim-treesitter',
  gh 'nvim-mini/mini.nvim',
} -- if you use the mini.nvim suite

require('render-markdown').setup {}
