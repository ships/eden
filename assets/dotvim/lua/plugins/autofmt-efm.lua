local on_attach = function(client, bufnr)
	local command_center = require("command_center")

	local filter = function(client)
		return client.name == "efm"
	end

	command_center.add({
		{
			desc = "format whole buffer using efm",
			cmd = function()
				vim.lsp.buf.format({
					filter = filter,
				})
			end,
			keys = { "n", "==", { noremap = true } },
		},
	})

	if client.server_capabilities.document_range_formatting then
		command_center.add({
			{
				desc = "format selection using efm",
				cmd = function()
					vim.lsp.buf.format({ buffer = bufnr, filter = filter })
				end,
				keys = { "v", "=", { noremap = true } },
			},
		})
	end

	-- format on save
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("Format", { clear = true }),
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({
				filter = filter,
			})
		end,
	})
end

return {
	plugin = {
		"creativenull/efmls-configs-nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"FeiyouG/commander.nvim",
		},
		config = function()
			local efmls = require("efmls-configs")

			local languages = require("efmls-configs.defaults").languages()

			-- -- disable default of prettier, because it should be run by eslint
			-- local eslint = require('efmls-configs.linters.eslint')
			-- languages['typescript'] = { eslint }
			-- languages['javascript'] = { eslint }

			local efmls_config = {
				on_attach = on_attach,

				filetypes = vim.tbl_keys(languages),
				settings = {
					rootMarkers = { ".git/" },
					languages = languages,
				},
				init_options = {
					documentFormatting = true,
					documentRangeFormatting = true,
				},
			}

			require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {}))
		end,
	},
}
