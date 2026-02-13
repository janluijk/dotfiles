local cmp = require('cmp')

local plugins = {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "codelldb",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      experimental = {
        ghost_text = true,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = require("cmp").config.sources {
        { name = "nvim_lsp", max_item_count = 3 },
        { name = "luasnip", max_item_count = 3 },
        { name = "path", max_item_count = 3 },
        { name = "buffer", max_item_count = 3 },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function()
      local mason_registry = require "mason-registry"
      if not mason_registry.has_package "codelldb" or not mason_registry.get_package("codelldb"):is_installed() then
        vim.notify("codelldb not installed. Run :MasonInstall codelldb", vim.log.levels.WARN)
        return
      end
      local codelldb = mason_registry.get_package "codelldb"
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require "rustaceanvim.config"

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "coder/claudecode.nvim",
    lazy = false,
    config = true,
  },
  {
    "folke/which-key.nvim",
    opts = {
      -- Only show explicitly defined spec entries, hide auto-discovered keymaps
      filter = function(mapping)
        return mapping.noremap == nil
      end,
      plugins = {
        marks = false,
        registers = false,
        spelling = { enabled = false },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = false,
          g = false,
        },
      },
      spec = {
        -- AI / Claude
        { "<leader>a", group = "AI/Claude" },
        { "<leader>ac", desc = "Toggle Claude" },
        { "<leader>af", desc = "Focus Claude" },
        { "<leader>as", desc = "Send to Claude", mode = "v" },
        { "<leader>ab", desc = "Add buffer to Claude" },
        { "<leader>aa", desc = "Accept diff" },
        { "<leader>ad", desc = "Deny diff" },

        -- Debugger
        { "<leader>d", group = "Debugger" },
        { "<leader>db", desc = "Toggle breakpoint" },
        { "<leader>dd", desc = "Conditional breakpoint" },
        { "<leader>dc", desc = "Continue" },
        { "<leader>dl", desc = "Step into" },
        { "<leader>dj", desc = "Step over" },
        { "<leader>dk", desc = "Step out" },
        { "<leader>de", desc = "Terminate" },
        { "<leader>dr", desc = "Run last" },
        { "<leader>ds", desc = "Diagnostics list" },

        -- Find (Telescope)
        { "<leader>f", group = "Find" },
        { "<leader>ff", desc = "Find files" },
        { "<leader>fa", desc = "Find all files" },
        { "<leader>fw", desc = "Live grep" },
        { "<leader>fb", desc = "Find buffers" },
        { "<leader>fh", desc = "Help tags" },
        { "<leader>fo", desc = "Recent files" },
        { "<leader>fz", desc = "Fuzzy find in buffer" },
        { "<leader>fm", desc = "Format file" },

        -- File explorer
        { "<leader>e", desc = "Toggle explorer" },

        -- Buffers
        { "<leader>b", desc = "New buffer" },
        { "<leader>x", desc = "Close buffer" },

        -- General
        { "<leader>c", desc = "Close all" },
        { "<leader>W", desc = "Save all" },
        { "<leader>/", desc = "Toggle comment" },
        { "<leader>n", desc = "Toggle line numbers" },

        -- LSP
        { "<leader>r", group = "Refactor" },
        { "<leader>ra", desc = "Rename symbol" },
        { "<leader>rn", desc = "Toggle relative numbers" },
        { "<leader>D", desc = "Type definition" },

        -- Theme
        { "<leader>th", desc = "Change theme" },
      },
    },
  },
}

return plugins
