return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
      })
      vim.o.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
