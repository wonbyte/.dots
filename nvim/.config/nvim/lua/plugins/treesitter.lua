return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "css",
          "dockerfile",
          "fish",
          "html",
          "go",
          "javascript",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "ocaml",
          "ocaml_interface",
          "rust",
          "scss",
          "sql",
          "toml",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = { "ocaml", "ocaml_interface" },
        },
        autopairs = {
          enable = true,
        },
      })
    end,
  },
}
