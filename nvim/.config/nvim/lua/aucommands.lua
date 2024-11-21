local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local remove_whitespace_group =
  vim.api.nvim_create_augroup("RemoveWhitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = remove_whitespace_group,
  pattern = "*",
  desc = "Remove trailing whitespace before saving the file",
  -- 'e' flag to suppress errors if no matches
  command = [[:%s/\s\+$//e]],
})

local no_comment_group =
  vim.api.nvim_create_augroup("NoAutoComment", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = no_comment_group,
  pattern = "*",
  desc = "Disable automatic commenting on new lines",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

local yank_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = yank_group,
  desc = "Highlight yanked text briefly",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      -- Increase timeout for better visibility
      timeout = 40,
      -- Ensures visual mode selections are highlighted
      on_visual = true,
    })
  end,
})

local tmpl_group = augroup("GoTmpl", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = tmpl_group,
  pattern = "*.tmpl",
  desc = "Set filetype to HTML for .tmpl files",
  callback = function()
    vim.bo.filetype = "html"
  end,
})

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
  desc = "Set two spaces for specific file types",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

local qf_group = augroup("QuickfixUpdate", { clear = true })
autocmd("BufWritePost", {
  group = qf_group,
  pattern = "*",
  desc = "Update Quickfix list on save",
  callback = function()
    vim.diagnostic.setqflist({ open = false })
  end,
})

local rust_group = vim.api.nvim_create_augroup("RustComments", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = rust_group,
  pattern = "rust",
  desc = "Set colorcolumn to 100 for Rust files",
  callback = function()
    vim.wo.colorcolumn = "100"
  end,
})
