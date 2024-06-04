local command_center = require("commander")
local noremap = { noremap = true }
local silent_noremap = { noremap = true, silent = true }

-- base command center shortcut

vim.keymap.set("n", "<C-K>", ":Telescope commander<CR>", { noremap = true, desc = "Open fuzzy commander" })

-- keymaps for plugins
command_center.add(require("plugins.neotest").keymap)
command_center.add(require("plugins.telescope").keymap)
command_center.add(require("plugins.trouble").keymap)
command_center.add(require("plugins.chatgpt").keymap)
command_center.add(require("plugins.dap-debugging").keymap)

command_center.add({
	{
		-- ... and for different modes
		desc = "Show function signaure (hover)",
		cmd = "<CMD>lua vim.lsp.buf.hover()<CR>",
		keys = {
			{ "n", "K", silent_noremap },
			{ "i", "<C-k>", silent_noremap },
		},
	},
	{
		desc = "Toggle NvimTree",
		cmd = "<CMD>NvimTreeToggle<CR>",
		keys = {
			"n",
			"<Bslash>",
			noremap,
		},
	},
	{
		desc = "Open NvimTree to current file",
		cmd = "<CMD>NvimTreeFindFile<CR>",
		keys = {
			"n",
			"|",
			noremap,
		},
	},
	{
		desc = "Save (with Return key)",
		cmd = "<CMD>w<CR>",
		keys = {
			"n",
			"<CR>",
			noremap,
		},
	},

	-- better yanking
	{
		desc = "Yank to system clipboard",
		cmd = '"+y',
		keys = {
			"v",
			"Y",
		},
	},
	{
		desc = "Yank to end of line",
		cmd = "y$",
		keys = {
			"n",
			"Y",
			noremap,
		},
	},
	{
		desc = "Paste",
		cmd = "P",
		keys = {
			"v",
			"p",
			noremap,
		},
	},

	-- buffer management
	{
		desc = "Toggle alternate buffer",
		cmd = "<c-^>",
		keys = {
			"n",
			"<leader><leader>",
			noremap,
		},
	},
	{
		desc = "Previous buffer",
		cmd = "<CMD>bp<CR>",
		keys = {
			"n",
			"<leader>q",
			noremap,
		},
	},
	{
		desc = "Next buffer",
		cmd = "<CMD>bn<CR>",
		keys = {
			"n",
			"<leader>w",
			noremap,
		},
	},

	-- splits and windows
	{
		desc = "horizontal split",
		cmd = "<CMD>split<CR>",
		keys = {
			"n",
			"<leader>sh",
		},
	},
	{
		desc = "vertical split",
		cmd = "<CMD>vsplit<CR>",
		keys = {
			"n",
			"<leader>sv",
		},
	},
	{
		desc = "close split",
		cmd = "<CMD>close<CR>",
		keys = {
			"n",
			"<leader>sc",
		},
	},

	-- commenting
	{
		desc = "comment toggle current line",
		cmd = "<CMD>Commentary<CR>",
		keys = {
			"n",
			"<leader>/",
		},
	},
	{
		desc = "comment toggle selection",
		cmd = ":Commentary<CR>",
		keys = {
			"x",
			"<leader>/",
		},
	},
	{
		desc = "delete to end of line",
		cmd = "<C-O>D",
		keys = {
			"i",
			"<C-K>",
		},
	},
	{
		desc = "toggle wrap",
		cmd = function()
			vim.wo.wrap = not vim.wo.wrap
		end,
		keys = {
			"n",
			"<Space>w",
		},
	},
})

-- convenience shortcuts for hot releasing shift fast enough
vim.api.nvim_create_user_command("W", function(opts)
	vim.cmd("w")
end, { nargs = 0 })

vim.api.nvim_create_user_command("WQ", function(opts)
	vim.cmd("wq")
end, { nargs = 0 })

vim.api.nvim_create_user_command("Wq", function(opts)
	vim.cmd("wq")
end, { nargs = 0 })
vim.api.nvim_create_user_command("Q", function(opts)
	vim.cmd("q")
end, { nargs = 0 })
