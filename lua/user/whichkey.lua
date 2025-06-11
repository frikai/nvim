local M = {
  "folke/which-key.nvim",
}

function M.config()
  local which_key = require "which-key"
  which_key.setup {
    defaults = {
      mode = "n",
      prefix = "<leader>",
    },
    spec = {
      { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
      { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL" },
      { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
      { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
      { "<leader>b", group = "Buffers" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>p", group = "Plugins" },
      { "<leader>t", group = "Test" },
      { "<leader>a", group = "Tab" },
      { "<leader>aN", "<cmd>tabnew %<cr>", desc = "New Tab" },
      { "<leader>ah", "<cmd>-tabmove<cr>", desc = "Move Left" },
      { "<leader>al", "<cmd>+tabmove<cr>", desc = "Move Right" },
      { "<leader>an", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
      { "<leader>ao", "<cmd>tabonly<cr>", desc = "Only" },
      { "<leader>ac", "<cmd>tabclose<cr>", desc = "Close Tab" },
      { "<leader>aj", "<cmd>Tabby jump_to_tab<cr>", desc = "Jump To Tab" },
      { "<leader>T", group = "Treesitter" },
      { "<leader> ", "<cmd>Alpha<cr>", desc = "Show Greeter" },
      { "<leader>S", group = "Sessions" },
      {
        "<leader>Sc",
        function()
          require("persistence").load()
        end,
        desc = "Current Directory",
      },
      {
        "<leader>Ss",
        function()
          require("persistence").select()
        end,
        desc = "Pick Session",
      },
      {
        "<leader>Sl",
        function()
          require("persistence").load { last = true }
        end,
        desc = "Last Session",
      },
      {
        "<leader>Sq",
        function()
          require("persistence").stop()
          vim.cmd "wqa"
        end,
        desc = "Quit Without Session",
      },
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    win = {
      padding = { 2, 2, 2, 2 },
      border = "rounded",
    },
    -- ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }
end

return M
