local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "

-------------------- Personal Keymaps --------------------

-- Debugging
local dap = require('dap')
vim.keymap.set('n', '<F9>', function() dap.continue() end)
vim.keymap.set('n', '<F8>', function() dap.step_over() end)
vim.keymap.set('n', '<F7>', function() dap.step_into() end)
vim.keymap.set('n', '<F6>', function() dap.step_out() end)

-------------------- General Keymaps --------------------

-- delete single character without copying into register
keymap("n", "x", '"_x', opts)
keymap("v", "p", '"_p', opts)

-- Unmappings
keymap("n", "<C-z>", "<nop>", opts)

-- Kill search highlights
keymap("n", "<CR>", ":noh<CR>", opts)

-- Find project files
vim.keymap.set("n", "<C-p>", function()
	require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({ previewer = false }))
end, { remap = true })

-- Toggle comments
keymap("n", "<C-Bslash>", "<Plug>(comment_toggle_linewise_current)", opts)
keymap("x", "<C-Bslash>", "<Plug>(comment_toggle_linewise_visual)", opts)

-- Open help on word
keymap("n", "<S-m>", ':execute "help " . expand("<cword>")<cr>', opts)

-- Fix 'Y', 'E'
keymap("n", "Y", "y$", opts)
keymap("n", "E", "ge", opts)
keymap("v", "Y", "y$", opts)

-- Avoid cutting text pasted over
keymap("v", "p", '"_dP', opts)

-- Center cursor
keymap("n", "m", "zt", opts)
keymap("v", "m", "zt", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)

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

-- Navigate display lines
keymap("n", "J", "gj", opts)
keymap("n", "K", "gk", opts)
-- keymap("v", "J", "gj", opts)
keymap("v", "K", "gk", opts)
