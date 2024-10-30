-- reuse the same window when browsing
vim.g.netrw_browse_split = 0
-- suppress the banner
vim.g.netrw_banner = 0

-- Better completion
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
-- Completion settings
vim.o.completeopt = "menuone,noinsert,noselect"

-- Line numbers
vim.o.relativenumber = true
vim.o.number = true

-- Scrolling context and command line height
vim.o.scrolloff = 2
vim.o.cmdheight = 1

-- Disable swap, backup, and undo files
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = false

-- Search settings
vim.o.ignorecase = true
vim.o.smartcase = true

-- Diff settings
vim.o.diffopt = vim.o.diffopt .. ",iwhite"

-- Always show the sign column to prevent layout shifts
vim.o.signcolumn = "yes"

-- Column guide at 80 characters
vim.o.colorcolumn = "80"

-- Use system clipboard for all operations
vim.o.clipboard = "unnamedplus"

-- Tab and indentation settings
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.shiftround = true

-- Display hidden characters
vim.o.listchars = [[tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•]]
