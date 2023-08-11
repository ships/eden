return {
	plugin = {
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"mfussenegger/nvim-dap",
			"tpope/vim-dispatch",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"vim-test/vim-test",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
			"olimorris/neotest-rspec",
			"jfpedroza/neotest-elixir",
			"nvim-neotest/neotest-vim-test",
			"folke/neodev.nvim",
		},
		config = function()
			require("neotest").setup({
				status = {
					signs = true,
					virtual_text = false,
				},
				summary = {
					expand_errors = true,
					follow = true,
					animated = true,
				},
				adapters = {
					require("neotest-rust"),
					require("neotest-python"),
					require("neotest-elixir"),
					require("neotest-rspec"),
					-- vim-test for all other types. use exclusion to match above lines.
					require("neotest-vim-test")({ ignore_filetypes = { "python", "rust", "ruby", "elixir" } }),
				},
			})

			-- TODO: confirm this setting works given neovim usage... set dispatch as runner for vim-test
			vim.g["test#strategy"] = "dispatch"

			require("neodev").setup({
				library = { plugins = { "neotest" }, types = true },
			})
		end,
	},
	keymap = {
		{
			desc = "Run this test file",
			cmd = function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			keys = { "n", "<leader>tf", noremap },
		},
		{
			desc = "Run nearest test",
			cmd = function()
				require("neotest").run.run()
			end,
			keys = { "n", "<leader>tt", noremap },
		},
		{
			desc = "Run nearest test in debug",
			cmd = function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			keys = { "n", "<leader>td", noremap },
		},
		{
			desc = "Watch tests with neotest",
			cmd = function()
				require("neotest").watch.toggle()
			end,
			keys = { "n", "<leader>tw", noremap },
		},
		{
			desc = "Stop nearest test",
			cmd = function()
				require("neotest").run.stop()
			end,
			keys = { "n", "<leader>tq", noremap },
		},
		{
			desc = "Toggle tests summary panel",
			cmd = function()
				require("neotest").summary.toggle()
			end,
			keys = { "n", "<leader>ts", noremap },
		},
		{
			desc = "Run entire test suite",
			cmd = function()
				local n = require("neotest")
				n.run.run({ suite = true })
				n.summary.open()
			end,
			keys = { "n", "<leader>ta", noremap },
		},
		{
			desc = "Re-run last test command",
			cmd = function()
				require("neotest").run.run_last()
			end,
			keys = { "n", "<leader>t<leader>", noremap },
		},
	},
}
