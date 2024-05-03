return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "ocaml", "ocamlinterface" },
      })
    end,
  },
}
