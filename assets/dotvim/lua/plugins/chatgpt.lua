return {
	plugin = {
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup({
				edit_with_instructions = {
					diff = true,
				},
				openai_params = {
					model = "gpt-4",
					-- frequency_penalty = 0,
					-- presence_penalty = 0,
					max_tokens = 2048,
					temperature = 0.3,
					-- top_p = 1,
					-- n = 1,
				},
				openai_edit_params = {
					model = "code-davinci-edit-001",
					temperature = 0.2,
          -- presence_penalty = 0 - 1.0,
					top_p = 0.5,
					-- n = 1,
				},
			})
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
