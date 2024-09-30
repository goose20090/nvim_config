return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader><space>", ":Neotree filesystem reveal float<CR>")
		vim.keymap.set("n", "<leader>rr", ":Neotree filesystem toggle reveal right<CR>")
		vim.keymap.set("n", "<leader>ll", ":Neotree filesystem toggle reveal left<CR>")
		vim.keymap.set("n", "<leader>f", ":Neotree filesystem left<CR>")
	end,
}
