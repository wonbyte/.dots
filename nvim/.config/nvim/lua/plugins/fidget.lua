return {
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("fidget").setup(opts)
    end,
  },
}
