vim.opt.guicursor = ""

vim.o.winborder = "rounded"

vim.opt.termguicolors = true
vim.cmd [[let g:gruvbox_material_background = 'soft']]
vim.cmd [[colorscheme gruvbox-material]]

-- Get the initial colorscheme
local colorscheme = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")
vim.opt.background = colorscheme:gsub("%s+", "") == "'prefer-dark'" and "dark" or "light"

-- Start polling for theme changes

function on_monitor_stdout(err, data)
	if (data:gsub("%s+", "") == "color-scheme:'prefer-dark'") then
		vim.defer_fn(function()
			vim.opt.background = "dark"
		end, 1)
	else
		vim.defer_fn(function()
			vim.opt.background = "light"
		end, 1)
	end
end

vim.system(
	{ "gsettings", "monitor", "org.gnome.desktop.interface", "color-scheme" },
	{ text = true, stdout = on_monitor_stdout })
