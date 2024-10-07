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

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "40" })
  end,
})

-- Handle tmpl
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tmpl",
  desc = "Detect and set the proper file type for tmpl files",
  callback = function()
    vim.cmd(":set filetype=html")
  end,
})

-- Set indentation to 2 spaces
augroup("setIndent", { clear = true })
autocmd("Filetype", {
  group = "setIndent",
  pattern = {
    "css",
    "html",
    "javascript",
    "json",
    "scss",
    "xml",
    "xhtml",
    "yaml",
  },
  command = "setlocal shiftwidth=2 tabstop=2",
})

-- Create a group for quickfix update on save
local qf_group = augroup("QuickfixUpdate", { clear = true })

-- Add an autocommand to update quickfix list on save
autocmd("BufWritePost", {
  group = qf_group,
  pattern = "*",
  callback = function()
    -- Update the quickfix list without affecting the open state of the quickfix
    -- window.
    vim.diagnostic.setqflist({ open = false })
  end,
})
