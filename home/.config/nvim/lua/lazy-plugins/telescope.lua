local M = {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					attach_mappings = function(prompt_bufnr)
						local dot = vim.fn.getreg(".")
						local dot_type = vim.fn.getregtype(".")

						vim.api.nvim_create_autocmd("BufWinLeave", {
							buffer = prompt_bufnr,
							once = true,
							callback = function()
								vim.fn.setreg(".", dot, dot_type)
							end,
						})

						return true
					end,
					preview = {
						treesitter = false,
					},
					mappings = {
						i = {
							["<C-k>"] = "move_selection_previous",
							["<C-j>"] = "move_selection_next",
						},
					},
				},
			})

			local builtin = require("telescope.builtin")

			local function find_files()
				local inside_git_repo = vim.fn.systemlist({ "git", "rev-parse", "--is-inside-work-tree" })[1] == "true"
				if inside_git_repo then
					builtin.git_files({ show_untracked = true })
				else
					builtin.find_files()
				end
			end

			vim.keymap.set("n", "<C-p>", find_files, { desc = "[Ctrl-p] for Telescope custom find_files" })
			vim.keymap.set("n", "<C-b>", builtin.buffers, { desc = "[Ctrl-b] for Telescope builtin.buffers" })
		end,
	},
}

return M
