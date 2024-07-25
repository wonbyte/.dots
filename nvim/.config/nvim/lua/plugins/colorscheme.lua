return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("catppuccin").setup({
        -- latte, frappe, macchiato, mocha
        flavour = "mocha",
        -- :h background
        background = {
          dark = "mocha",
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
