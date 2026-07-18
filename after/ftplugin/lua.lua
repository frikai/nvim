-- set whatever options we want for files of this type. e.g. will only apply to .lua files
vim.opt_local.shiftwidth = 2
-- Some useful keybinds for live config development
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", {desc="Source current file"})
vim.keymap.set("n", "<space>x", ":.lua<CR>", {desc="Lua: Execute current line"})
vim.keymap.set("v", "<space>x", ":lua<CR>", {desc="Lua: Execute selection"})
