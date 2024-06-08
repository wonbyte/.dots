local g = vim.g
local opt = vim.opt

-- reuse the same window when browsing
g.netrw_browse_split = 0
-- suppress the banner
g.netrw_banner = 0

opt.background = "dark"

opt.completeopt = { "menu", "menuone", "noselect" }

opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.cmdheight = 1

opt.swapfile = false
opt.backup = false
opt.undofile = false

-- ignore case in search
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"
opt.colorcolumn = "80"

-- use clipboard for all operations
opt.clipboard = "unnamedplus"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

opt.listchars = {
  space = "⋅",
  eol = "~",
  extends = "»",
  precedes = "«",
  trail = "•",
}
