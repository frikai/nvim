local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'goolord/alpha-nvim' }

local dashboard = require 'alpha.themes.dashboard'
local icons = require 'plugins.icons'

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl_shortcut = 'Include'
  return b
end

dashboard.section.header.val = {

  [[     ★                          *                    ✯    ]],
  [[         ✯                ★               ★     ~         ]],
  [[                   .       ❄️                  *     ★    ]],
  [[    ★        |       ✯           *          ❄️            ]],
  [[             |8.                                          ]],
  [[ ❄️          |`88.      ❄️              ____   ✯          ]],
  [[            d|`888.        ★           <WW>>>             ]],
  [[           ,8| 8888b                  /WWWI; \          /\]],
  [[          ,88| `8888b                /WWWWII; \====.  _/WW]],
  [[         ,888| `88888b          ❄️  /WWWWWII;..     \/WWWW]],
  [[        ,8888|  888888b            /WWWWWIIIIi;..:    \WWW]],
  [[       ,88888|  888P888b  .      _/WWWWWIII❄️;;:...:  ;\WW]],
  [[      ,888888|  88888888;       /WWWWWIWIiii;;;.:.. :  ;\W]],
  [[     o8888888|  888888888,     /WWWWWIIIIiii;;::.... :  ;\]],
  [[~~~~d88888888|  888888888b~~~~/WWWWWWWWWIIIIIWIIii;;::;..;]],
  [[  o==========| o88888888888b.       ~~~~    ~~~      ~~~  ]],
  [[[]::,,,TTTTTT\_/=========7/    ~~    ~~       ~~~~      ~ ]],
  [[  \__...____...__ .._____/ _~~~         ~~~~~~~        ~~~]],
  [[  ~    ~~~       ~~~~  ~~      ~~~   ~~~~~      ~~~       ]],
}
dashboard.section.buttons.val = {
  button('f', icons.ui.Files .. ' Find file', ':Telescope find_files <CR>'),
  button('n', icons.ui.NewFile .. ' New file', ':ene <BAR> startinsert <CR>'),
  button('p', icons.git.Repo .. ' Find project', ":lua require('telescope').extensions.projects.projects()<CR>"),
  button('r', icons.ui.History .. ' Recent files', ':Telescope oldfiles <CR>'),
  button('s', icons.ui.History .. ' Recent sessions', function() require('persistence').select() end),
  button('t', icons.ui.Text .. ' Find text', ':Telescope live_grep <CR>'),
  button('c', icons.ui.Gear .. ' Config', ':e ' .. vim.fn.stdpath 'config' .. '/init.lua <CR>'),
  button('q', icons.ui.SignOut .. ' Quit', ':qa<CR>'),
}
local function footer() return 'hds' end

dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = 'Keyword'
dashboard.section.buttons.opts.hl = 'Include'
dashboard.section.footer.opts.hl = 'Type'

dashboard.opts.opts.noautocmd = true
require('alpha').setup(dashboard.opts)

vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  callback = function()
    local stats = require('lazy').stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val = 'Loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
    pcall(vim.cmd.AlphaRedraw)
  end,
})

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = { 'AlphaReady' },
  callback = function()
    vim.cmd [[
    set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
  ]]
  end,
})
