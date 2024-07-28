local g = vim.g
local opt = vim.opt
local api = vim.api

-- reuse the same window when browsing
g.netrw_browse_split = 0
-- suppress the banner
g.netrw_banner = 0

opt.background = "dark"

opt.completeopt = { "menu", "menuone", "noselect" }

-- sweet sweet relative line numbers
opt.relativenumber = true
-- and show the absolute line number for the current line
opt.number = true

opt.scrolloff = 8
opt.cmdheight = 1

opt.swapfile = false
opt.backup = false
opt.undofile = false

-- case-insensitive search/replace
opt.ignorecase = true
-- unless uppercase in search term
opt.smartcase = true

-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append("iwhite")

-- always draw sign column. prevents buffer moving when adding/deleting sign
opt.signcolumn = "yes"

-- show a column at 80 characters as a guide for long lines
opt.colorcolumn = "80"

--- except in Rust where the rule is 100 characters
api.nvim_create_autocmd(
  "Filetype",
  { pattern = "rust", command = "set colorcolumn=100" }
)

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
