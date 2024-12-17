require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "Open debugging sidebar" })

map("n", "leader>dus", function()
  require("crates").upgrade_all_crates()
end, { desc = "Open debugging sidebar" })

-- map("n", ";", ":", { desc = "CMD enter command mode" })

-- local dap = require('dap')
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

map("n", "x", '"_x', { desc = "Delete single character" })

-- Yank till end of line
map("n", "Y", "y$", { desc = "Yank till end of line" })

-- Kill search highlights
map("n", "<CR>", ":noh<CR>", { desc = "Kill search highlights" })

-- To previous word
map("n", "E", "ge", { desc = "To previous word" })

-- Avoid cutting text pasted over
map("v", "p", '"_dP', { desc = "Paste text" })

-- Movement
map("n", "<c-u>", "<c-u>zz", { desc = "Move up" })
map("n", "<c-d>", "<c-d>zz", { desc = "Move down" })

-- Drag lines
map("n", "<A-j>", "<Esc>:m .+1<CR>==", { desc = "Move current line down" })
map("n", "<A-k>", "<Esc>:m .-2<CR>==", { desc = "Move current line up" })
map("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "l" })
map("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "" })
map("v", "<A-j>", ":m'>+<CR>gv", { desc = "Move selected lines down" })
map("v", "<A-k>", ":m-2<CR>gv", { desc = "Move selected lines up" })

-- Horizontal line movement
map("v", "<S-h>", "g^", { desc = "Select to end of line" })
map("v", "<S-l>", "g$", { desc = "Select to start of line" })
map("n", "<S-h>", "g^", { desc = "Move to end of line" })
map("n", "<S-l>", "g$", { desc = "Move to start of line" })

-- Indentation
map("v", "<", "<gv", { desc = "Indent backwards" })
map("v", ">", ">gv", { desc = "Indent forwards" })
map("n", "<", "<S-v><<esc>", { desc = "Indent backwards" })
map("n", ">", "<S-v>><esc>", { desc = "Indent forwards" })


map({"n", "v"}, "<leader>c", "<cmd>qa!<CR>", { desc = "Close all" })
map({"n", "v"}, "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
map({"n", "v"}, "<leader>W", "<cmd>wa!<CR>", { desc = "Write" })

