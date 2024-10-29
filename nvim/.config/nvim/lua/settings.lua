local g = vim.g
local o = vim.opt
local api = vim.api

-- reuse the same window when browsing
g.netrw_browse_split = 0
-- suppress the banner
g.netrw_banner = 0

-- Better completion
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
opt.completeopt = { "menuone", "noinsert", "noselect" }

-- sweet sweet relative line numbers
opt.relativenumber = true
-- and show the absolute line number for the current line
opt.number = true

-- keep more context on screen while scrolling
opt.scrolloff = 2
-- more command line room
opt.cmdheight = 1

opt.swapfile = false
opt.backup = false
opt.undofile = false

-- case-insensitive search/replace
opt.ignorecase = true
-- unless uppercase in search term
opt.smartcase = true

-- more useful diffs (nvim -d) by ignoring whitespace
vim.opt.diffopt:append("iwhite")

-- always draw sign column. prevents buffer moving when adding/deleting sign
opt.signcolumn = "yes"

-- show a column at 80 characters as a guide for long lines
opt.colorcolumn = "80"

-- use clipboard for all operations
opt.clipboard = "unnamedplus"

-- tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

-- show more hidden characters
-- also, show tabs nicer
opt.listchars = {
  tab = "^ ",
  nbsp = "¬",
  extends = "»",
  precedes = "«",
  trail = "•",
}
