-- DONE

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200
  end,
  opts = {
    setup = {
      plugins = { -- Disable a bunch of stuff
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = false,
          g = false,
          marks = false,
          registers = false,
          spelling = {
            enabled = false,
          },
        },
      },
      triggers = { "<leader>" },
      window = {
        border = "rounded",   -- none, single, double, shadow
        position = "bottom",  -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
        zindex = 1000,        -- positive value to position WhichKey above other floating windows.
      },
      ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
      triggers_nowait = {},
    },
    defaults = {
      nowait = true, -- use `nowait` when creating keymaps
      prefix = "<leader>",
      mode = { "n", "v" },

      c = { "<cmd>qa!<CR>", "Close all" },
      e = { "<cmd>Neotree filesystem toggle float<CR>", "Explorer" },
      h = { "<cmd>Alpha<CR>", "Home" },
      q = { "<cmd>update! | bdelete!<CR>", "Delete buffer" },
      w = { "<cmd>wa!<CR>", "Write" },

      d = {
        name = "DEBUG",
        t = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle" },
        f = { "<cmd>lua require('nvim-dap-projects').search_project_config()<CR>", "Search" },
        b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Breakpoint" },
        c = { "<cmd>DapTerminate<CR>", "Close" },
      },

      f = {
        name = "FIND",
        b = {
          "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
          "buffers",
        },
        f = { "<cmd>Telescope live_grep<CR>", "search" },
        p = { "<cmd>Telescope find_files<CR>", "files" },
        t = { "<cmd>Telescope colorscheme<CR>", "theme" },
        y = { "<cmd>YankyRingHistory<CR>", "yanks" },
      },

      g = {
        name = "GIT",
        d = { "<cmd>Gitsigns diffthis HEAD<CR>", "diff" },
        b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "blame" },
        g = { "<cmd>LazyGit<CR>", "lazygit" },
        j = { "<cmd>Gitsigns next_hunk<CR>", "next hunk" },
        k = { "<cmd>Gitsigns prev_hunk<CR>", "prev hunk" },
        p = { "<cmd>Gitsigns preview_hunk<CR>", "preview hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "reset hunk" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "stage hunk" },
        t = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "toggle current line blame" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "unstage hunk" },
      },

      l = {
        name = "LSP",
        b = { "<cmd>Telescope diagnostics bufnr=0<CR>", "buffer diagnostics" },
        c = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "code action" },
        d = { "<cmd>Telescope lsp_definitions<CR>", "definition" },
        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "declaration" },
        f = { "<cmd>lua vim.lsp.buf.format()<CR>", "format" },
        h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "help" },
        i = { "<cmd>Telescope lsp_implementations<CR>", "implementations" },
        l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "line diagnostics" },
        n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "next diagnostic" },
        p = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "previous diagnostic" },
        r = { "<cmd>Telescope lsp_references<CR>", "references" },
        R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
        T = { "<cmd>Telescope lsp_type_definitions<CR>", "type definition" },
      },

      S = {
        name = "SESSIONS",
        s = { "<cmd>SessionManager save_current_session<CR>", "save" },
        d = { "<cmd>SessionManager delete_session<CR>", "delete" },
        l = { "<cmd>SessionManager load_session<CR>", "load" },
      },

      s = {
        name = "SURROUND",
        s = { "<Plug>(nvim-surround-normal)", "surround" },
        d = { "<Plug>(nvim-surround-delete)", "delete" },
        c = { "<Plug>(nvim-surround-change)", "change" },
      },
    },
  },

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts.setup)
    wk.register(opts.defaults)
  end,
}
