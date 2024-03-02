local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- No auto commenting for new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=cro | setlocal fo-=cro",
})

-- Set indentation to 2 spaces
augroup("setIndent", { clear = true })
autocmd("Filetype", {
  group = "setIndent",
  pattern = {
    "css",
    "graphql",
    "html",
    "javascript",
    "json",
    "react",
    "scss",
    "tsx",
    "typescript",
    "xml",
    "xhtml",
    "yaml",
  },
  command = "setlocal shiftwidth=2 tabstop=2",
})

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "40" })
  end,
})

-- https://github.com/dmmulroy/dotfiles/blob/main/.config/nvim/after/ftdetect/ocamlinterface.lua
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mli",
  desc = "Detect and set the proper file type for Ocaml interface files",
  command = "set filetype=ocamlinterface",
})

autocmd({ "FileType" }, {
  pattern = "ocaml",
  desc = "Disable automatic comment indentation for OCaml files",
  command = "setlocal indentexpr=",
})

autocmd({ "FileType" }, {
  pattern = "ocamlinterface",
  desc = "Disable automatic comment indentation for OCaml files",
  command = "setlocal indentexpr=",
})
