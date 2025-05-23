local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

-- TODO: add keymaps for capture groups (function, class, call, parameter, loop, ...)
function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python" },
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M
