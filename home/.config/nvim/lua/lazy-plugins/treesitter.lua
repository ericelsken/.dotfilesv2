local M = {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		local ts = require("nvim-treesitter")
		local languages = {
			"bash",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"go",
			"javascript",
			"json",
			"lua",
			"markdown",
			"terraform",
			"toml",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		}
		local enabled_languages = {}

		for _, language in ipairs(languages) do
			enabled_languages[language] = true
		end

		ts.setup()

		if vim.fn.executable("tree-sitter") == 1 then
			ts.install(languages)
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("EgoElkTreesitter", { clear = true }),
			callback = function(args)
				local bufnr = args.buf
				local language = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)

				if not enabled_languages[language] then
					return
				end

				pcall(vim.treesitter.start, bufnr)
				vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}

return M
