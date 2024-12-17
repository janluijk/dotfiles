require "nvchad.options"

local options = {
  number = true,
  relativenumber = true,
  cursorline = true,
  wrap = false,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
  clipboard = "unnamedplus"
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
