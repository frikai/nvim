local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Fuzzy Finder (files, lsp, etc) ]]
--
-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
-- There are lots of other alternative pickers (like snacks.picker, or fzf-lua)
-- so feel free to experiment and see what you like!
--
-- The easiest way to use Telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of `help_tags` options and
-- a corresponding preview of the help.
--
-- Two important keymaps to use while in Telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- Telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

---@type (string|vim.pack.Spec)[]
local telescope_plugins = {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
}
if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end
-- NOTE: You can install multiple plugins at once
vim.pack.add(telescope_plugins)

-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  -- You can put your default mappings / updates / etc. in here
  --  All the info you're looking for is in `:help telescope.setup()`
  --
  -- defaults = {
  --   mappings = {
  --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
  --   },
  -- },
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
      },
      n = {
        ['<esc>'] = 'close',
        ['j'] = 'move_selection_next',
        ['k'] = 'move_selection_previous',
        ['q'] = 'close',
      },
    },
  },
  pickers = {
    buffers = {
      theme = 'dropdown',
      previewer = false,
      initial_mode = 'normal',
      mappings = {
        i = {
          ['<C-d>'] = 'delete_buffer',
        },
        n = {
          ['dd'] = 'delete_buffer',
        },
      },
    },
  },

  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
}
-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[H]elp' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[K]eymaps' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]iles' })
vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = '[T]elescope Builtins' })
vim.keymap.set({ 'n', 'v' }, '<leader>fw', builtin.grep_string, { desc = 'Current [W]ord' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'by [G]rep' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[D]iagnostics' })
vim.keymap.set('n', '<leader>fl', builtin.resume, { desc = 'Resume [L]ast' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[R]ecent Files' })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '[C]ommands' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Existing [B]uffers' })

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
-- If you later switch picker plugins, this is where to update these mappings.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf

    -- Find references for the word under your cursor.
    vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { buffer = buf, desc = 'Find [R]eferences' })

    -- Jump to the implementation of the word under your cursor.
    -- Useful when your language has ways of declaring types without an actual implementation.
    vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { buffer = buf, desc = 'Goto [I]mplementation' })

    -- Jump to the definition of the word under your cursor.
    -- This is where a variable was first declared, or where a function is defined, etc.
    -- To jump back, press <C-t>.
    vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { buffer = buf, desc = 'Goto [D]efinition' })

    -- Fuzzy find all the symbols in your current document.
    -- Symbols are things like variables, functions, types, etc.
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document [S]ymbols' })

    -- Fuzzy find all the symbols in your current workspace.
    -- Similar to document symbols, except searches over your entire project.
    vim.keymap.set('n', '<leader>lw', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open [W]orkspace Symbols' })

    -- Jump to the type of the word under your cursor.
    -- Useful when you're not sure what type a variable is and you want to see
    -- the definition of its *type*, not where it was *defined*.
    vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions, { buffer = buf, desc = 'Goto [T]ype Definition' })
  end,
})

-- Override default behavior and theme when searching
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'fzf in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set(
  'n',
  '<leader>f/',
  function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end,
  { desc = 'fzf in Open Files' }
)

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>fn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[N]eovim files' })

-- vim: ts=2 sts=2 sw=2 et
