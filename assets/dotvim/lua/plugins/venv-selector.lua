local noremap = { noremap = true }

return {
	plugin = {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap-python',
      'mfussenegger/nvim-dap',
      'microsoft/debugpy',
    },
    opts = {
      search_venv_managers = false,
    },
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },
	keymap = {
		{
			desc = "VenvSelect: Select New Python Venv",
			cmd = "<cmd>VenvSelect<cr>",
			keys = { "n", "<space>vs", noremap },
    },
		{
			desc = "VenvSelect: Select Cached Python Venv",
			cmd = "<cmd>VenvSelectCached<cr>",
			keys = { "n", "<space>vc", noremap },
    },
	},
}
