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

local nnoremap = bind("n")
local vnoremap = bind("v")
local inoremap = bind("i")
local cnoremap = bind("c")

-- General
nnoremap("<C-h>", "<cmd>noh<CR>")

nnoremap("<space>,", ":set invlist<CR>")

nnoremap("<F1>", "<Nop>")
inoremap("<F1>", "<Nop>")

-- https://vim.fandom.com/wiki/Simplifying_regular_expressions_using_magic_and_no-magic
nnoremap("?", "?\\v")
nnoremap("/", "/\\v")
cnoremap("%s/", "%sm/")

vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Telescope
nnoremap("<leader>rc", require("config.telescope").search_dotfiles)

nnoremap("<leader>gb", require("config.telescope").git_branches)

nnoremap("<leader>gc", require("telescope.builtin").git_commits)

nnoremap("<leader>gs", require("telescope.builtin").git_status)

nnoremap("<leader>fb", require("telescope.builtin").current_buffer_fuzzy_find)

nnoremap("<leader>ff", function()
	require("telescope.builtin").find_files({
		file_ignore_patterns = { ".git", "target", "node_modules" },
	})
end)

nnoremap("<leader>fg", require("telescope.builtin").live_grep)

nnoremap("<leader>cb", require("telescope.builtin").buffers)

nnoremap("<leader>gw", require("telescope.builtin").grep_string)

nnoremap("<leader>hh", ":Telescope help_tags<CR>")

-- Tests
nnoremap(",t", "<Plug>PlenaryTestFile")

-- Diagnostics
nnoremap("<leader>e", vim.diagnostic.open_float)
nnoremap("[d", vim.diagnostic.goto_prev)
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("<leader>q", vim.diagnostic.setloclist)
