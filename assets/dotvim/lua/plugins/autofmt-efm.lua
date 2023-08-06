local on_attach = function(client, bufnr)
	local command_center = require("command_center")

	command_center.add({
		{
			desc = "format whole buffer using efm",
			cmd = "<cmd>lua vim.lsp.buf.format()<cr>",
			keys = { "n", "==", { noremap = true } },
		},
	})
	if client.server_capabilities.document_range_formatting then
		command_center.add({
			{
				desc = "format selection using efm",
				cmd = function()
					vim.lsp.buf.format({ buffer = bufnr })
				end,
				keys = { "v", "=", { noremap = true } },
			},
		})
	end
end

return {
	plugin = {
		"creativenull/efmls-configs-nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"FeiyouG/command_center.nvim",
		},
		config = function()
			local efmls = require("efmls-configs")
			efmls.init({
				-- Your custom attach function
				on_attach = on_attach,

				-- Enable formatting provided by efm langserver
				init_options = {
					documentFormatting = true,
				},
				default_config = true,
			})

			-- setup languages using defaults
			efmls.setup()
		end,
	},
}
