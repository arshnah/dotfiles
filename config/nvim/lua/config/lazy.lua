-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- setup plugins
require "lazy".setup {
	-- automatically check for plugin updates
	checker = { enabled = true },
	-- theme
	{ "sainnhe/gruvbox-material" },
	-- file explorer
	{
		"stevearc/oil.nvim",
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		config = function()
			require "oil".setup {
				default_file_explorer = true,
				skip_confirm_for_simple_edits = true,
				prompt_save_on_select_new_entry = false,
				keymaps = {
					["<cr>"] = { "actions.select", opts = { tab = true, close = true } },
					["<c-n>"] = { "actions.close" },
				},
				view_options = {
					show_hidden = true,
				},
			}
			vim.keymap.set("n", "<c-n>", "<cmd>Oil<cr>")
		end,
	},
	-- fuzzy find
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require "telescope".setup {}

			local telescope_builtin = require "telescope.builtin"
			vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files)
			vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep)
			vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics)
		end,
	},
	-- language servers
	-- see config examples: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",

			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- completion
			local cmp = require "cmp"
			cmp.setup {
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert {
					["<C-Space>"] = cmp.mapping(function(_)
						if cmp.visible() then
							cmp.close()
						else
							cmp.complete()
						end
					end),
					["<CR>"] = cmp.mapping.confirm { select = true },
				},
				sources = cmp.config.sources(
					{
						{ name = "nvim_lsp" },
						{ name = "vsnip" },
					},
					{
						{ name = "buffer" },
					}
				),
			}

			require "mason".setup {}
			require "mason-lspconfig".setup {
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					--"zls",
					"clangd",
				},
			}

			local lspconf = require "lspconfig"
			lspconf.lua_ls.setup {}
			lspconf.rust_analyzer.setup {}
			lspconf.zls.setup {}
			lspconf.clangd.setup {}
			lspconf.qmlls.setup {
				cmd = { "/usr/lib/qt6/bin/qmlls", "-E" },
			}
			lspconf.omnisharp.setup {
				cmd = { "omnisharp", "-z", "--hostPID", "DotNet:enablePackageRestore=false", vim.fn.getpid(), "--encoding", "utf-8", "--languageserver", "FormattingOptions:EnableEditorConfigSupport=true", "Sdk:IncludePrereleases=true" }
			}
		end,
	},
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		-- enable completion when available
		--if client:supports_method("textDocument/completion") then
		--	-- trigger completion menu on every keypress
		--	client.server_capabilities.completionProvider.triggerCharacters = {
		--		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
		--		'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
		--		'1', '2', '3', '4', '5', '6', '7', '8', '9',
		--		'!', '@', '#', '$', '%', '^', '&', '*',
		--	}
		--	vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		--end

		-- auto-format ("lint") on save
		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})
-- see `:h completeopt`
vim.opt.completeopt = "fuzzy,menuone,noinsert,popup"
-- map <c-space> to activate completion
vim.keymap.set("i", "<c-space>", function() vim.lsp.completion.get() end)
-- map <cr> to <c-y> when the popup menu is visible and item is selected
vim.keymap.set("i", "<cr>", function()
	local compinfo = vim.fn.complete_info({ "pum_visible", "selected" })
	if compinfo.pum_visible and
		compinfo.selected >= 0 then
		return "<c-y>"
	end
	return "<cr>"
end, { expr = true })
