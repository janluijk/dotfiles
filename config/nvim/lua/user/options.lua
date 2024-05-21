local options = {
  number = true,                  -- set numbered lines
  relativenumber = true,          -- set relative numbered lines
  cursorline = true,              -- highlight the current line
  wrap = false,                   -- display lines as one long line
  tabstop = 2,                    -- insert 2 spaces for a tab
  shiftwidth = 2,                 -- the number of spaces inserted for each indentation
  softtabstop = 2,                -- insert 2 spaces for a tab
  expandtab = true,               -- convert tabs to spaces
  clipboard = "unnamedplus",      -- allows neovim to access the system clipboard
}

-- turns on all values in options table above
for k, v in pairs(options) do
  vim.opt[k] = v
end
