local function gh(repo)
	return "https://github.com/" .. repo
end

-- [[ mini.nvim ]]
--  A collection of various small independent plugins/modules
vim.pack.add({ gh("frikai/arrow.nvim"), gh("nvim-tree/nvim-web-devicons") })

require("arrow").setup({
	show_icons = true,
	leader_key = "<leader><TAB>", -- Recommended to be a single key
	buffer_leader_key = "m", -- Per Buffer Mappings
	mappings = {
		edit = "e",
		delete_mode = "d",
		clear_all_items = "c",
		toggle = "s", -- used as save if separate_save_and_remove is true
		open_vertical = "v",
		open_horizontal = "-",
		quit = "q",
		remove = "x", -- only used if separate_save_and_remove is true
		next_item = "j",
		prev_item = "k",
	},
	cycle_mode = true,
})
