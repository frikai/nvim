local python_cmd = vim.fn.has("win32") == 1 and "python" or "python3"

vim.keymap.set("n", "<leader>r", "<cmd>split | term " .. python_cmd .. " %<CR>", {
	buffer = true,
	silent = true,
	desc = "Run Python file in built-in terminal",
})
