local M = {
	{
		"folke/trouble.nvim",
		config = function()
			local trouble = require("trouble")
			trouble.setup({})

			vim.keymap.set("n", "<Leader>X", trouble.toggle, { desc = "<Leader>[X] for Trouble" })
		end,
	},
}

return M
