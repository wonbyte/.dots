local cmp = require("cmp")

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
  local qf_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_open = true
      break
    end
  end
  if qf_open then
    vim.cmd("cclose")
  else
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
nnoremap("<leader>gb", require("util.builtins").git_branches)
nnoremap("<leader>gc", require("telescope.builtin").git_commits)
nnoremap("<leader>gs", require("telescope.builtin").git_status)
nnoremap("<leader>fb", require("telescope.builtin").current_buffer_fuzzy_find)
nnoremap("<leader>ff", function()
  require("telescope.builtin").find_files({
    file_ignore_patterns = {
      "_build",
      "build",
      ".git",
      "node_modules",
      "_opam",
      "target",
      "^tmp$",
    },
  })
end)
nnoremap("<leader>fg", require("telescope.builtin").live_grep)
nnoremap("<leader>cb", require("telescope.builtin").buffers)
nnoremap("<leader>gw", require("telescope.builtin").grep_string)
nnoremap("<leader>hh", ":Telescope help_tags<CR>")

-- Tests
nnoremap("<leader>t", "<Plug>PlenaryTestFile")

-- Cmp On/Off
nnoremap("<Leader>cm", function()
  local current_setting = cmp.get_config().completion.autocomplete
  if current_setting and #current_setting > 0 then
    cmp.setup({ completion = { autocomplete = false } })
    vim.notify("Cmp disabled")
  else
    cmp.setup({
      completion = { autocomplete = { cmp.TriggerEvent.TextChanged } },
    })
    vim.notify("Cmp enabled")
  end
end)

-- Inlay On/Off
nnoremap("<leader>h", function()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled)
  if enabled then
    vim.notify("Hints disabled")
  else
    vim.notify("Hints enabled")
  end
end)
