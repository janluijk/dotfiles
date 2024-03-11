return {
	"mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require('dap')
    local dapui = require("dapui")

    dapui.setup()

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
      args = { "-i", "dap" }
    }

    dap.configurations.cpp = {
    {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
    },
    }

    vim.keymap.set('n', '<F5>', dap.continue, {})
    vim.keymap.set('n', '<F10>', dap.step_over, {})
    vim.keymap.set('n', '<F11>', dap.step_into, {})
    vim.keymap.set('n', '<F12>', dap.step_out, {})
    vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, {})
    vim.keymap.set('n', '<Leader>B', dap.set_breakpoint, {})
    vim.keymap.set('n', '<Leader>dr', dap.repl.open, {})
    vim.keymap.set('n', '<Leader>dl', dap.run_last, {})
  end,
}
