return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
    require("neo-tree").setup({
      default_component_configs = {
        git_status = {
          symbols = {
            unstaged  = "U",
          }
        }
      }
    })
	end,
}
