return {
	{ -- colorscheme
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load(
				-- TODO: fix the visual highlight color to be more visible
			)
		end,
	},
	{ -- provides keymap hints
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
		end,
	},
	{ -- git integrations
		"tpope/vim-fugitive",
	},
	--	{ -- lua development plugin
	--		"bfredl/nvim-luadev",
	--	},
	{ -- good commenting
		"tpope/vim-commentary",
	},
	{ -- paired character navigation
		"tpope/vim-unimpaired",
	},
    { -- ruby on rails basics
      "tpope/vim-rails"
    },
	{ -- better LSP experience TODO: investigate how to use this better
		"nvimdev/lspsaga.nvim",
	},
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "debugpy",
        "ruff-lsp",
        "pyright",
      },
    },
  },
	-- REPLACED by efm autoformat: { "nvimdev/guard.nvim" },
	{ -- sidebar for git status per line
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{ -- AST analysis for various languages
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = "all",

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				highlight = {
					enable = false,
				},
			})
		end,
	},
	{ -- shows status of LSP server
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
	},
	{ -- more useable nvim-tree visuals
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({})
		end,
	},
	{ -- fast statusbar
		"nvim-lualine/lualine.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("lualine").setup({
				sections = {
					lualine_x = {
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
						},
					},
				},
			})
		end,
	},
	{ -- sidebar tree nav
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				renderer = {
					group_empty = true,
				},
				filters = {
					git_ignored = false
				},
			})
		end,
	},
	{ -- highlight and autoclean whitespace
		"ntpeters/vim-better-whitespace",
		config = function()
			-- TODO: make active insert line not show whitespace
			vim.g.better_whitespace_enabled = 1
			vim.g.strip_whitespace_on_save = 1
			vim.g.strip_whitespace_confirm = 0
		end,
	},
	{ -- debugging binary for js/ts
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out && git checkout .",
	},
	{ --better visuals for lsp categories
		"onsails/lspkind.nvim",
	},
	{ -- fzf for native sort override
		"nvim-telescope/telescope-fzf-native.nvim",
		event = "VeryLazy",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{ -- command palette
		"FeiyouG/commander.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("commander").setup({
				integration = {
					telescope = {
						enable = true,
					},
				},
				lazy = {
					enable = true,
					--set_plugin_name_as_cat = true,
				},
			})
		end,
	},
  { -- terraform syntax highlighting
    "hashivim/vim-terraform",
    ft = { 'hcl', 'tf', 'tfbackend', 'tfvars', 'terraform' },
  },
	-- plugins with advanced configuration
	require("plugins/telescope").plugin,
	require("plugins/chatgpt").plugin,
	require("plugins/nvim-cmp").plugin,
	require("plugins/rust-tools").plugin,
	require("plugins/autofmt-efm").plugin,
	require("plugins/trouble").plugin,
	require("plugins/neotest").plugin,
	require("plugins/dap-debugging").plugin,
	require("plugins/venv-selector").plugin,

	-- specific language support
	{ "niklasl/vim-rdf" },
	{ "LnL7/vim-nix" },
}
