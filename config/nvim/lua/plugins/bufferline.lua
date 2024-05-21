return {
	"akinsho/bufferline.nvim",
  branch = 'main',
	dependencies = {
    "nvim-tree/nvim-web-devicons"
  },

	config = function()
		require("bufferline").setup({
      options = {
        indicator = {
          style = 'underline',
        },
        diagnostics = "nvim_lsp",
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        separator_style = "thick"
      }
    })
	end,
}
