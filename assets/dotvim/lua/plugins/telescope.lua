local noremap = { noremap = true }

return {
	plugin = { -- jumpy navigation using fzf and other search tools
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"gbrlsnchs/telescope-lsp-handlers.nvim",
			"nvim-tree/nvim-web-devicons",
			"FeiyouG/commander.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			local t = require("telescope")
			local actions = require("telescope.actions")
			local trouble = require("trouble.sources.telescope")

			t.setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						"vendor/*",
						".git",
						"Godeps",
					},
					mappings = {
						i = { ["<c-t>"] = trouble.open },
						n = { ["<c-t>"] = trouble.open },
					},
				},
			})
			t.load_extension("file_browser")
			t.load_extension("lsp_handlers")
			t.load_extension("commander")
			t.load_extension("fzf")
		end,
	},
	keymap = {
		{
			desc = "Search inside current buffer",
			cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
			keys = { "n", "<leader>fl", noremap },
		},
		{
			-- If no keys are specified, no keymaps will be displayed nor set
			desc = "Find hidden files",
			cmd = "<CMD>Telescope find_files hidden=true<CR>",
		},
		{
			-- You can specify multiple keys for the same cmd ...
			desc = "Show document symbols",
			cmd = "<CMD>Telescope lsp_document_symbols<CR>",
			keys = {
				{ "n", "<leader>ss", noremap },
				{ "n", "<leader>ssd", noremap },
			},
		},
		{
			-- You can specify multiple keys for the same cmd ...
			desc = "Fuzzy find files",
			cmd = "<CMD>Telescope find_files<CR>",
			keys = {
				{ "n", "<C-P>", noremap },
			},
		},
		{
			-- You can specify multiple keys for the same cmd ...
			desc = "fuzzy search for text in workspace using ripgrep",
			cmd = "<CMD>Telescope live_grep<CR>",
			keys = {
				{ "n", "<leader>rg", noremap },
			},
		},
		{
			-- You can specify multiple keys for the same cmd ...
			desc = "Show and search across buffers",
			cmd = "<CMD>Telescope buffers<CR>",
			keys = {
				{ "n", "<leader>rb", noremap },
			},
		},
		{
			-- You can specify multiple keys for the same cmd ...
			desc = "fuzzy search in helptags",
			cmd = "<CMD>Telescope help_tags<CR>",
			keys = {
				{ "n", "<leader>rh", noremap },
			},
		},
	},
}
