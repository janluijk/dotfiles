--  
-- CLEAN
--

return {
	"mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local daptext = require('nvim-dap-virtual-text')

    daptext.setup()
    dapui.setup({
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = ""
        }
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
      },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.5
            },
            {
              id = "watches",
              size = 0.5
            } },
          position = "left",
          size = 75
        },
        {
          elements = {
            {
              id = "breakpoints",
              size = 0.5
            },
            {
              id = "stacks",
              size = 0.5
            }
          },
          position = "right",
          size = 75
        }
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      render = {
        indent = 1,
        max_value_lines = 100
      }
    })

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

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "-i", "dap"}
    }

    dap.configurations.cpp = {
    {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
         vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
    },
    }

    dap.configurations.c = {
      {
        name = "debug compiler",
        type = "gdb",
        request = "launch",
        program = function()
           return vim.fn.input('path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function()
           return vim.fn.input('argument: ')
        end,

        cwd = "${workspacefolder}",

        stopatbeginningofmainsubprogram = false,
      },
    }
  end,
}

