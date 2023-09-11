local g = vim.g
local opt = vim.opt

g.mapleader = " "

g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25

opt.background = "dark"
opt.termguicolors = true

opt.completeopt = { "menu", "menuone", "noselect" }

opt.number = true

opt.relativenumber = true

opt.scrolloff = 8

opt.cmdheight = 1

opt.swapfile = false

opt.backup = false

opt.undofile = false

opt.shortmess:append("c")

opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"
opt.colorcolumn = "80"

opt.clipboard = "unnamedplus"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true
opt.smartcase = true

opt.listchars = {
  space = "⋅",
  eol = "~",
  extends = "»",
  precedes = "«",
  trail = "•",
}

opt.wildmode = { "longest", "list", "full" }
opt.wildignore = { "*/.git/*", "*/node_modules/*", "*/target/*", "*/build/*" }
