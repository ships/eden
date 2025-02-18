return {
	plugin = { -- fancy navigation around quickfix/errors/diagnostics
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
      modes = {
        diagnostics = {
          auto_open = true,
        }
      }
		},
	},
	keymap = {
		{
			desc = "Open Trouble window",
			cmd = function()
				require("trouble").open()
			end,
			keys = { "n", "<space>xx", noremap },
		},
		{
			desc = "Open Trouble workspace diagnostics",
			cmd = function()
				require("trouble").open("workspace_diagnostics")
			end,
			keys = { "n", "<space>xw", noremap },
		},
		{
			desc = "Open Trouble document_diagnostics",
			cmd = function()
				require("trouble").open("document_diagnostics")
			end,
			keys = { "n", "<space>xd", noremap },
		},
		{
			desc = "Open Trouble quickfix window",
			cmd = function()
				require("trouble").open("quickfix")
			end,
			keys = { "n", "<space>xq", noremap },
		},
		{
			desc = "Open Trouble loclist",
			cmd = function()
				require("trouble").open("loclist")
			end,
			keys = { "n", "<space>xl", noremap },
		},
		{
			desc = "Open Trouble LSP references list",
			cmd = function()
				require("trouble").open("lsp_references")
			end,
			keys = { "n", "gR", noremap },
		},
	},
}
