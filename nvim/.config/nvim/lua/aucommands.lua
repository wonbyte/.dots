local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing whitespace on save (preserve cursor/view)
autocmd("BufWritePre", {
  group = augroup("RemoveWhitespace", { clear = true }),
  pattern = "*",
  desc = "Remove trailing whitespace before saving the file",
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "markdown" or ft == "diff" or ft == "gitcommit" then
      return
    end
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

autocmd("FileType", {
  group = augroup("WebIndent", { clear = true }),
  pattern = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "lua",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  desc = "2-space indentation for web/config/lua filetypes",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- colorcolumn and listchars are window options. Set from an ftplugin they
-- would stick to the window and leak into the next file opened there, so
-- re-apply them whenever a buffer is shown: the override for its filetype, or
-- the global value from settings.lua.
local win_opts_by_ft = {
  -- Go indents with tabs, so do not mark every tab
  go = { listchars = (vim.go.listchars:gsub("tab:[^,]*", "tab:  ")) },
  rust = { colorcolumn = "100" },
}

autocmd({ "BufWinEnter", "FileType" }, {
  group = augroup("FiletypeWindowOptions", { clear = true }),
  desc = "Per-filetype colorcolumn and listchars",
  callback = function(args)
    -- Leave special buffers (help, terminal, pickers, ...) alone
    if vim.bo[args.buf].buftype ~= "" then
      return
    end
    local overrides = win_opts_by_ft[vim.bo[args.buf].filetype] or {}
    for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
      if vim.api.nvim_win_get_config(win).relative == "" then
        for _, name in ipairs({ "colorcolumn", "listchars" }) do
          vim.wo[win][0][name] = overrides[name] or vim.go[name]
        end
      end
    end
  end,
})
