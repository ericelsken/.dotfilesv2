local M = {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"lua_ls",
					"terraformls",
					"jsonls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Avoid deprecated `require('lspconfig')` top-level access.
			-- Instead, register configs directly to bypass the deprecated framework.
			local configs = require("lspconfig.configs")
			configs.gopls = require("lspconfig.configs.gopls")
			configs.lua_ls = require("lspconfig.configs.lua_ls")
			configs.jsonls = require("lspconfig.configs.jsonls")

			configs.gopls.setup({})
			configs.lua_ls.setup({})
			configs.jsonls.setup({})
			-- configs.terraformls = require("lspconfig.configs.terraformls")
			-- configs.terraformls.setup({})
		end,
	},
}

return M
