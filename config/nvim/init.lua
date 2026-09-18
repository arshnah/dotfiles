vim.g.mapleader = " "

require "config.lazy"
require "config.theme" -- Must be called after loading plugins

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

-- Line info
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		-- disable comment on new line
		vim.opt.formatoptions:remove { "c", "r", "o" }
	end,
})

-- Ignore case in search
vim.opt.ignorecase = true

-- Retain undo history
vim.opt.undofile = true
