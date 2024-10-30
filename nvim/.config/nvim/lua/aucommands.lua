local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Autogroup: Remove trailing whitespace on save
augroup("RemoveWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "RemoveWhitespace",
  pattern = "*",
  command = [[:%s/\s\+$//e]], -- Avoid error if no match found
})

-- Autogroup: Disable auto-commenting for new lines
augroup("NoAutoComment", { clear = true })
autocmd("BufEnter", {
  group = "NoAutoComment",
  pattern = "*",
  command = [[setlocal formatoptions-=cro]],
})

-- Autogroup: Highlight text on yank
local yank_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = yank_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
  end,
})

-- Autogroup: Set filetype for `.tmpl` files
local tmpl_group = augroup("GoTmpl", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = tmpl_group,
  pattern = "*.tmpl",
  desc = "Set filetype to HTML for .tmpl files",
  callback = function()
    vim.bo.filetype = "html"
  end,
})

-- Autogroup: Set 2-space indentation for certain filetypes
local indent_group = augroup("SetIndent", { clear = true })
autocmd("FileType", {
  group = indent_group,
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
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

-- Autogroup: Update Quickfix list on save without opening the window
local qf_group = augroup("QuickfixUpdate", { clear = true })
autocmd("BufWritePost", {
  group = qf_group,
  pattern = "*",
  callback = function()
    vim.diagnostic.setqflist({ open = false })
  end,
})
