---@param v any Value to inspect and print
---@return any The same value for chaining
P = function(v)
  print(vim.inspect(v))
  return v
end

local keymap = vim.keymap.set

-- ============================================================================
-- SEARCH & NAVIGATION
-- ============================================================================

-- Clear search highlighting
keymap("n", "<C-h>", "<cmd>noh<CR>")

-- Toggle display of hidden characters
keymap("n", "<leader>,", ":set invlist<CR>")

-- Open file explorer
keymap("n", "<leader>o", ":Ex<CR>")

-- "Very magic" regexes by default
keymap("n", "?", "?\\v")
keymap("n", "/", "/\\v")
keymap("c", "%s/", "%sm/")

-- ============================================================================
-- EDITING
-- ============================================================================

-- Keep selection while indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- ============================================================================
-- SPECIAL KEYS
-- ============================================================================

-- Disable F1
keymap("n", "<F1>", "<Nop>")
keymap("i", "<F1>", "<Nop>")

-- ============================================================================
-- DEVELOPER TOOLS
-- ============================================================================

-- Source File
keymap("n", "<leader>s", ":source <CR>")

-- Test Files
keymap("n", "<leader>t", "<cmd>PlenaryBustedFile %<CR>")

-- Toggle Inlay Hints
keymap("n", "<leader>h", function()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled)
  if enabled then
    vim.notify("Inlay hints disabled", vim.log.levels.INFO)
  else
    vim.notify("Inlay hints enabled", vim.log.levels.INFO)
  end
end)
