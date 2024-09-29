return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>tf", ":Neotree filesystem reveal float<CR>")
		vim.keymap.set("n", "<leader>tr", ":Neotree filesystem toggle reveal right<CR>")
	end,
}
