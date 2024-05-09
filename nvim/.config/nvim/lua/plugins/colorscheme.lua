return {
  -- Tokyonight
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {},
    config = function()
      require("gruvbox").setup({})
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
