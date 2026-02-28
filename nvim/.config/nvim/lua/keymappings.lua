_G.P = vim.print

local keymap = vim.keymap.set

-- ============================================================================
-- SEARCH & NAVIGATION
-- ============================================================================

-- Clear search highlighting
keymap("n", "<C-h>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- Toggle display of hidden characters
keymap("n", "<leader>,", ":set invlist<CR>", { desc = "Toggle hidden characters" })

-- Open file explorer
keymap("n", "<leader>o", ":Ex<CR>", { desc = "Open file explorer" })

-- "Very magic" regexes by default
keymap("n", "?", "?\\v", { desc = "Search backward (very magic)" })
keymap("n", "/", "/\\v", { desc = "Search forward (very magic)" })
keymap("c", "%s/", "%sm/", { desc = "Substitute (very magic)" })

-- ============================================================================
-- EDITING
-- ============================================================================

-- Keep selection while indenting
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ============================================================================
-- SPECIAL KEYS
-- ============================================================================

-- Disable F1
keymap("n", "<F1>", "<Nop>", { desc = "Disable F1" })
keymap("i", "<F1>", "<Nop>", { desc = "Disable F1" })

-- ============================================================================
-- DEVELOPER TOOLS
-- ============================================================================

-- Source File
keymap("n", "<leader>s", ":source <CR>", { desc = "Source current file" })

-- Test Files
keymap("n", "<leader>t", "<cmd>PlenaryBustedFile %<CR>", { desc = "Run Plenary tests" })

-- Toggle Inlay Hints
keymap("n", "<leader>h", function()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled)
  if enabled then
    vim.notify("Inlay hints disabled", vim.log.levels.INFO)
  else
    vim.notify("Inlay hints enabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle inlay hints" })
