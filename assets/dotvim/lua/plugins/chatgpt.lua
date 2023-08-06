return {
	plugin = {
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	keymap = {
		{
			desc = "Edit with AI assistance",
			cmd = function()
				require("chatgpt").edit_with_instructions()
			end,
			keys = {
				{ "x", "<leader>.e", noremap, group = "leader-dot" },
				{ "n", "<leader>.e", noremap, group = "leader-dot" },
			},
		},
		{
			desc = "AI conversation with actor prompt",
			cmd = "<CMD>ChatGPTActAs<CR>",
			keys = {
				{ "n", "<leader>.a", noremap, group = "leader-dot" },
			},
		},
		{
			desc = "AI conversation with vanilla turbo",
			cmd = "<CMD>ChatGPT<CR>",
			keys = {
				{ "n", "<leader>.t", noremap, group = "leader-dot" },
			},
		},
	},
}
