return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"hrsh7th/cmp-cmdline",
		"petertriho/cmp-git",
		"f3fora/cmp-spell",
		"micangl/cmp-vimtex",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local kind_icons = {
			Text = "󰦨",
			-- Text = "󰸲",
			Method = "",
			Function = "󰊕",
			Constructor = "",
			Field = "󰅪",
			Variable = "󱃮",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "󰚯",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "󰌁",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "󰀫",
			Struct = "",
			Event = "",
			Operator = "󰘧",
			TypeParameter = "",
		}
		-- find more here: https://www.nerdfonts.com/cheat-sheet

		cmp.setup({
			completion = {
				completeopt = "menu",
				keyword_length = 1,
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-n>"] = cmp.mapping.complete(), -- show completion suggestions
				-- ["<C-h>"] = cmp.mapping.abort(), -- close completion window
				-- ["<C-l>"] = cmp.mapping.confirm({ select = false }),
				-- ["<Tab>"] = cmp.mapping.confirm({ select = true }),
				-- supertab
				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.expandable() then
						luasnip.expand()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
					elseif cmp.visible() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			-- formatting for autocompletion
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind]) -- Kind icons
					vim_item.menu = ({
						vimtex = (vim_item.menu ~= nil and vim_item.menu or ""),
						luasnip = "[Snippet]",
						nvim_lsp = "[LSP]",
						buffer = "[Buffer]",
						spell = "[Spell]",
						cmdline = "[CMD]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "vimtex" },
				{ name = "buffer", keyword_length = 3 }, -- text within current buffer
				-- {
				-- 	name = "spell",
				-- 	keyword_length = 4,
				-- 	option = {
				-- 		keep_all_entries = false,
				-- 		enable_in_context = function()
				-- 			return true
				-- 		end,
				-- 	},
				-- },
				{ name = "path" },
			}),
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			view = {
				entries = "custom",
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			performance = {
				trigger_debounce_time = 500,
				throttle = 550,
				fetching_timeout = 80,
			},
		})

		-- `/` cmdline setup.
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "path" },
				{ name = "cmdline" },
			},
		})
	end,
}
