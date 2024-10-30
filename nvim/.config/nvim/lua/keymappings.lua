-- Global helper
P = function(v)
  print(vim.inspect(v))
  return v
end

local function bind(op, outer_opts)
  outer_opts = outer_opts or { noremap = true, silent = true }
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local function toggle_qf()
  -- Check if a Quickfix window is open
  local qf_open = vim.iter(vim.fn.getwininfo()):find(function(win)
    return win.quickfix == 1
  end) ~= nil

  if qf_open then
    vim.cmd("cclose")
  else
    -- Populate the Quickfix list with diagnostics
    vim.diagnostic.setqflist()
    vim.cmd("copen")
  end
end

local nnoremap = bind("n")
local vnoremap = bind("v")
local inoremap = bind("i")
local cnoremap = bind("c")

-- General
nnoremap("<C-h>", "<cmd>noh<CR>")
nnoremap("<leader>,", ":set invlist<CR>")
nnoremap("<leader>o", ":Ex<CR>")
nnoremap("<F1>", "<Nop>")
inoremap("<F1>", "<Nop>")

-- https://vim.fandom.com/wiki/Simplifying_regular_expressions_using_magic_and_no-magic
-- "very magic" (less escaping needed) regexes by default
nnoremap("?", "?\\v")
nnoremap("/", "/\\v")
cnoremap("%s/", "%sm/")

vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Quickfix
nnoremap("<leader>q", toggle_qf)

-- Telescope
nnoremap("<leader>rc", require("util.builtins").search_dotfiles)
nnoremap("<leader>gb", require("telescope.builtin").git_branches)
nnoremap("<leader>gc", require("telescope.builtin").git_commits)
nnoremap("<leader>gs", require("telescope.builtin").git_status)
nnoremap("<leader>fb", require("telescope.builtin").current_buffer_fuzzy_find)
nnoremap("<leader>ff", require("telescope.builtin").find_files)
nnoremap("<leader>fg", require("telescope.builtin").live_grep)
nnoremap("<leader>cb", require("telescope.builtin").buffers)
nnoremap("<leader>gw", require("telescope.builtin").grep_string)
nnoremap("<leader>tj", ":Telescope help_tags<CR>")

-- Tests
nnoremap("<leader>t", "<Plug>PlenaryTestFile")

-- Inlay Hints On/Off
nnoremap("<leader>h", function()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled)
  if enabled then
    vim.notify("Hints disabled")
  else
    vim.notify("Hints enabled")
  end
end)
