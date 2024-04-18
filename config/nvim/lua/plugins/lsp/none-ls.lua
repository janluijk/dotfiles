return {
	"nvimtools/none-ls.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		local mason_null_ls = require("mason-null-ls")
		mason_null_ls.setup({
			"stylua",
		})

		local null_ls = require("null-ls")
		local null_ls_utils = require("null-ls.utils")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		null_ls.setup({
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			sources = {
				formatting.prettier.with({
					extra_filetypes = { "svelte" },
					disabled_filetypes = { "txt" },
				}),
				formatting.stylua,
				-- diagnostics./
			},
		})
	end,
}
