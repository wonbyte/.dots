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

-- Settings
require("settings")

-- Plugins
require("lazy").setup("plugins")

-- Lsp
require("lsp")

-- Keymappings
require("keymappings")

-- Aucommands
require("aucommands")
