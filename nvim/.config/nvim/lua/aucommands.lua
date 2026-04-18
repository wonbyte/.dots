local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing whitespace on save (preserve cursor/view)
autocmd("BufWritePre", {
  group = augroup("RemoveWhitespace", { clear = true }),
  pattern = "*",
  desc = "Remove trailing whitespace before saving the file",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Disable automatic commenting on new lines
autocmd("FileType", {
  group = augroup("NoAutoComment", { clear = true }),
  pattern = "*",
  desc = "Disable automatic commenting on new lines",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Highlight yanked text briefly
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  desc = "Highlight yanked text briefly",
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})
