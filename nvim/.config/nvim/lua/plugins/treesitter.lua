-- nvim-treesitter (main branch) installs parsers and links their queries into
-- stdpath("data") .. "/site", which is on runtimepath by default.

-- Enable highlighting/indentation per buffer
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
  callback = function(args)
    -- Fails (silently) when no parser exists for the filetype
    if pcall(vim.treesitter.start, args.buf) then
      vim.bo[args.buf].indentexpr =
        "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Each plugin version expects specific parser versions; stale parsers break
-- their queries. Bring installed parsers in line (same as :TSUpdate). This
-- only compares local revision files, so it is cheap when all are current.
require("nvim-treesitter").update()

-- Install missing parsers (already-installed ones are skipped)
require("nvim-treesitter").install({
  "bash",
  "c_sharp",
  "css",
  "dockerfile",
  "fish",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "html",
  "json",
  "javascript",
  "jsdoc",
  "lua",
  "markdown",
  "proto",
  "rust",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
})
