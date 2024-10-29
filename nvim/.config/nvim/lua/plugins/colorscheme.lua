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
      vim.opt.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
