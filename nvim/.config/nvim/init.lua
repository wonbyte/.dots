-- Set <Space> as the leader key (must be set before plugins are loaded)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("settings")
require("aucommands")
require("keymappings")

-- ============================================================================
-- Plugin declarations via vim.pack (Neovim 0.12 built-in plugin manager)
-- Update plugins with :lua vim.pack.update() (then :write to confirm)
-- ============================================================================

-- vim.pack has no build step, so compile telescope-fzf-native ourselves
local function build_fzf_native(path)
  local result = vim.system({ "make" }, { cwd = path }):wait()
  if result.code ~= 0 then
    vim.notify(
      "telescope-fzf-native build failed:\n" .. (result.stderr or ""),
      vim.log.levels.WARN
    )
  end
end

-- Rebuild after every install/update (must exist before vim.pack.add)
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("PackBuild", { clear = true }),
  callback = function(ev)
    local kind = ev.data.kind
    if
      ev.data.spec.name == "telescope-fzf-native.nvim"
      and (kind == "install" or kind == "update")
    then
      build_fzf_native(ev.data.path)
    end
  end,
})

vim.pack.add({
  -- Colorscheme
  "https://github.com/ellisonleao/gruvbox.nvim",

  -- Statusline
  "https://github.com/nvim-lualine/lualine.nvim",

  -- Treesitter
  "https://github.com/nvim-treesitter/nvim-treesitter",

  -- Telescope
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",

  -- LSP & Completion
  "https://github.com/mason-org/mason.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v1" },
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/folke/lazydev.nvim",

  -- Formatting
  "https://github.com/stevearc/conform.nvim",

  -- Autopairs
  "https://github.com/windwp/nvim-autopairs",
})

-- Build once if the plugin is present but was never compiled
local fzf_native = vim.pack.get({ "telescope-fzf-native.nvim" })[1]
if fzf_native and not vim.uv.fs_stat(fzf_native.path .. "/build/libfzf.so") then
  build_fzf_native(fzf_native.path)
end

-- ============================================================================
-- Plugin setup (each file calls require("plugin").setup())
-- ============================================================================
require("plugins")
