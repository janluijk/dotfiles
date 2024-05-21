-- Lazy install 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Load all plugins in a table
local lazy = require("lazy")
lazy.setup({
  { import = "plugins" },
})

-- Post plugin configuration
--
vim.cmd 'colorscheme gruvbox'
