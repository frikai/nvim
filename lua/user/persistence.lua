local M = {
  "folke/persistence.nvim",
  event = "BufReadPre",
}

function M.config()
  require("persistence").setup{}
end

return M
