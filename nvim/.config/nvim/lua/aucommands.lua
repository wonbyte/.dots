local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "40" })
  end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- No auto commenting for new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- Set indentation to 2 spaces
augroup("setIndent", { clear = true })
autocmd("Filetype", {
  group = "setIndent",
  pattern = {
    "css",
    "html",
    "javascript",
    "lua",
    "typescript",
    "scss",
    "xml",
    "xhtml",
    "yaml",
  },
  command = "setlocal shiftwidth=2 tabstop=2",
})

-- https://github.com/dmmulroy/dotfiles/blob/main/.config/nvim/after/ftdetect/ocamlinterface.lua
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mli",
  desc = "Detect and set the proper file type for ocaml interface files",
  callback = function()
    vim.cmd(":set filetype=ocamlinterface")
  end,
})
