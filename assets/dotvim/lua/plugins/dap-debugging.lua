return {
	plugin = {
		"mfussenegger/nvim-dap",
		dependencies = { -- TODO: is this backwards lazy-wise? should split all the language plugins as dependents, not dependencies, of nvim-dap
			"microsoft/vscode-js-debug",
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			require("dap-vscode-js").setup({ -- FROM https://github.com/mxsdev/nvim-dap-vscode-js
				-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
				-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
				-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
				-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
				-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
				-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
	keymap = {
		{
			desc = "DAP: Continue",
			cmd = function()
				require("dap").continue()
			end,
			keys = { "n", "<C-Space><C-Space>", noremap },
		},
		{
			desc = "DAP: Step over",
			cmd = function()
				require("dap").step_over()
			end,
			keys = { "n", "<C-Space><C-Bslash>", noremap },
		},
		{
			desc = "DAP: Step into",
			cmd = function()
				require("dap").step_into()
			end,
			keys = { "n", "<C-Space><C-]>", noremap },
		},
		{
			desc = "DAP: Step out",
			cmd = function()
				require("dap").step_out()
			end,
			keys = { "n", "<C-Space><C-[>", noremap },
		},
		{
			desc = "DAP: Toggle breakpoint",
			cmd = function()
				require("dap").toggle_breakpoint()
			end,
			keys = { "n", "<Leader>db", noremap },
		},
		{
			desc = "DAP: Set breakpoint",
			cmd = function()
				require("dap").set_breakpoint()
			end,
			keys = { "n", "<Leader>dB", noremap },
		},
		{
			desc = "DAP: Set log point",
			cmd = function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			keys = { "n", "<Leader>dL", noremap },
		},
		{
			desc = "DAP: Open repl",
			cmd = function()
				require("dap").repl.open()
			end,
			keys = { "n", "<Leader>dr", noremap },
		},
		{
			desc = "DAP: Run last",
			cmd = function()
				require("dap").run_last()
			end,
			keys = { "n", "<Leader>dl", noremap },
		},
		{
			desc = "DAP: Hover",
			cmd = function()
				require("dap.ui.widgets").hover()
			end,
			keys = { { "n", "v" }, "<Leader>dh", noremap },
		},
		{
			desc = "DAP: Preview",
			cmd = function()
				require("dap.ui.widgets").preview()
			end,
			keys = { { "n", "v" }, "<Leader>dp", noremap },
		},
		{
			desc = "DAP: Frames",
			cmd = function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			keys = { "n", "<Leader>df", noremap },
		},
		{
			desc = "DAP: Scopes",
			cmd = function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			keys = { "n", "<Leader>ds", noremap },
		},
	},
}
