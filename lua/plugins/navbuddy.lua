local function gh(repo)
	return "https://github.com/" .. repo
end
vim.pack.add({
	gh("hasansujon786/nvim-navbuddy"),
	gh("SmiteshP/nvim-navic"),
	gh("MunifTanjim/nui.nvim"),
})

local navbuddy = require("nvim-navbuddy")
-- local actions = require("nvim-navbuddy.actions")
navbuddy.setup({
	window = {
		border = "rounded",
	},
	icons = require("plugins.icons").kind,
	lsp = { auto_attach = true },
})

vim.keymap.set("n", "<leader>o", "<Cmd>Navbuddy<CR>", { desc = "Nav" })
vim.keymap.set("n", "<m-s>", ":silent only | Navbuddy<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<m-o>", ":silent only | Navbuddy<cr>", { noremap = true, silent = true })

return M
