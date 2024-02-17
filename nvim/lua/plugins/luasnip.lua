return {
	"L3MON4D3/LuaSnip",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/" })
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
	end,
}
