local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
}

function M.config()
  local dashboard = require "alpha.themes.dashboard"
  local icons = require "user.icons"

  local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    b.opts.hl_shortcut = "Include"
    return b
  end

  dashboard.section.header.val = {

[[     ★                          *              ((   ✯  ]],
[[         ✯                ★              ★     ~       ]],
[[                   .       ❄️                  *     ★  ]],
[[    ★        |       ✯           *             ❄️       ]],
[[             I-                                        ]],
[[ ❄️          ,I?8,      ❄️                ✯              ]],
[[            d|`888.        ★                      /\   ]],
[[           d8| 8888b                             /  \  ]],
[[          ,88| ?8888b                           /    \ ]],
[[         ,888| `88888b          ❄️           ___/      \]],
[[        ,8888|  8888g8b                    /    . .. . ]],
[[       ,88888|  888PX?8b                 - .......... .]],
[[      ,888888|  8888bd88,          ___/........ . . .. ]],
[[     o8888888| ,888888888     ____/  . . .. . . .. ... ]],
[[.~..d8888888P| d888888888b..../........................]],
[[ _ ==========| 8gg88888888,.    \._._._._._._._._._._._]],
[['H=;,,,,TTTTTT\,,,,,,-===7    ~~     ~   _._-._      ~ ]],
[[_ \__...____...__ .._ __/ _~~~         ~/ .- ~~\      ~]],
[[  ~              ~~~~  ~~      ~~~   ~  \~__.  /~~~    ]],
  }
  dashboard.section.buttons.val = {
    button("f", icons.ui.Files .. " Find file", ":Telescope find_files <CR>"),
    button("n", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
    button("p", icons.git.Repo .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
    button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
    button("t", icons.ui.Text .. " Find text", ":Telescope live_grep <CR>"),
    button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
    button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
  }
  local function footer()
    return "chrisatmachine.com"
  end

  dashboard.section.footer.val = footer()

  dashboard.section.header.opts.hl = "Keyword"
  dashboard.section.buttons.opts.hl = "Include"
  dashboard.section.footer.opts.hl = "Type"

  dashboard.opts.opts.noautocmd = true
  require("alpha").setup(dashboard.opts)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
      vim.cmd [[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
    end,
  })
end

return M
