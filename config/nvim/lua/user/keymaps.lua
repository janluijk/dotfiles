-- Variables
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = " "

-- -- Debugging
-- local dap = require('dap')
-- vim.keymap.set('n', '<F9>', function() dap.continue() end)
-- vim.keymap.set('n', '<F8>', function() dap.step_over() end)
-- vim.keymap.set('n', '<F7>', function() dap.step_into() end)
-- vim.keymap.set('n', '<F6>', function() dap.step_out() end)

-- -- Find project files
-- vim.keymap.set("n", "<C-p>", function()
-- 	require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({ previewer = false }))
-- end, { remap = true })

-- Toggle comments
-- keymap("n", "<C-Bslash>", "<Plug>(comment_toggle_linewise_current)", opts)
-- keymap("x", "<C-Bslash>", "<Plug>(comment_toggle_linewise_visual)", opts),,

-- delete single character without copying into register
keymap("n", "x", '"_x', opts)
keymap("v", "p", '"_p', opts)

-- Kill search highlights
keymap("n", "<CR>", ":noh<CR>", opts)

-- Yank till end of line
keymap("n", "Y", "y$", opts)

-- Kill search highlights
keymap("n", "<CR>", ":noh<CR>", opts)

-- To previous word
keymap("n", "E", "ge", opts)

-- Avoid cutting text pasted over
keymap("v", "p", '"_dP', opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)

-- Drag lines
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("v", "<A-j>", ":m'>+<CR>gv", opts)
keymap("v", "<A-k>", ":m-2<CR>gv", opts)

-- Horizontal line movments --
keymap("n", "<c-u>", "<c-u>zz", opts)
keymap("n", "<c-d>", "<c-d>zz", opts)

-- Horizontal line movments --
keymap("v", "<S-h>", "g^", opts)
keymap("v", "<S-l>", "g$", opts)
keymap("n", "<S-h>", "g^", opts)
keymap("n", "<S-l>", "g$", opts)

-- Indentation
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("n", "<", "<S-v><<esc>", opts)
keymap("n", ">", "<S-v>><esc>", opts)
