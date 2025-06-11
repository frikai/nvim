local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
    {"williamboman/mason.nvim", version = "^1.0.0" },
    {"williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
    -- TODO: unpin versions eventually when Lazy.nvim is compatible with v2.x
    "jay-babu/mason-null-ls.nvim",
  },
}

function M.config()
  local null_ls = require "null-ls"

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  local lsps = {
    "lua_ls",
    "pyright",
    "bashls",
    "jsonls",
    "ruff",
    "yamlls",
  }

  local others = {
    "black",
    "pylint",
    "stylua",
    "prettier",
    "yamllint",
  }

  require("mason-lspconfig").setup {
    ensure_installed = lsps,
    automatic_installation = true,
  }

  require("mason-null-ls").setup {
    ensure_installed = others,
    automatic_installation = true,
  }

  local code_actions = null_ls.builtins.code_actions
  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting
  local hover = null_ls.builtins.hover
  local completion = null_ls.builtins.completion

  null_ls.setup {
    debug = false,
    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
    sources = {
      formatting.stylua,
      formatting.prettier,
      formatting.black,
      formatting.stylua,
      completion.spell,
      diagnostics.yamllint,

      -- formatting.prettier.with {
      --   extra_filetypes = { "toml" },
      --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      -- },
      -- formatting.eslint,


      -- do this for none-ls-extras sources
      require "none-ls.diagnostics.ruff",
    },
  }
end

return M
