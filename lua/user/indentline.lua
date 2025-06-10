local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
}

function M.config()
  local icons = require "user.icons"

  require("ibl").setup {
    indent = { char = icons.ui.LineMiddle },
    whitespace = {
      remove_blankline_trail = true,
    },

    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
      },
      buftypes = { "terminal", "nofile" },
    },
  }
end

return M
