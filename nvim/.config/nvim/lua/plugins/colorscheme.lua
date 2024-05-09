return {
  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false, -- Ensure it's loaded at startup
    priority = 1000, -- Load before other plugins
    opts = {},
    config = function()
      require("gruvbox").setup({
        overrides = {
          StatusLine = { fg = "#a89984", bg = "#282828" }, -- Active status line
          StatusLineNC = { fg = "#a89984", bg = "#282828" }, -- Inactive status line
        },
      })

      -- Set the color scheme to gruvbox
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
