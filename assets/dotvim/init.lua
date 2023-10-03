-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.g.mapleader = ","

-- setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("plugins"), {
	defaults = {
		lazy = false, -- default lazy everything?
	},
})

-- config modules
require("keymap")
require("autocomplete")

-- basic config
local HOME = os.getenv("HOME")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.swapfile = true
vim.opt.directory = "~/.vim-tmp,~/tmp,/var/tmp,/tmp"
vim.opt.backupdir = "~/.vim-tmp,~/tmp,/var/tmp,/tmp"
vim.opt.number = true
vim.opt.encoding = "utf-8"
vim.opt.guioptions = "cg"
vim.opt.guicursor =
	"n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175"
vim.opt.lazyredraw = true

vim.opt.autowriteall = true
vim.opt.formatoptions = "crql"
vim.opt.iskeyword = vim.opt.iskeyword + "$,@,-"
vim.opt.splitright = true

vim.opt.modeline = false

vim.opt.errorbells = false
vim.opt.visualbell = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- filetype commands
vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "turtle" },
	command = "setlocal commentstring=#\\ %s",
})
