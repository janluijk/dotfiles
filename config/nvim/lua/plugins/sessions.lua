return {
  "Shatur/neovim-session-manager",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local Path = require('plenary.path')

    require('session_manager').setup({
      sessions_dir = Path:new(vim.fn.stdpath('config'), 'other/sessions'), -- The directory where the session files will be saved.
      autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    })
  end,
}


