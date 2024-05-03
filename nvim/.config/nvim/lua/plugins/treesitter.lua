return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "dockerfile",
          "fish",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "ocaml",
          "ocaml_interface",
          "ocamllex",
          "rust",
          "sql",
          "toml",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = {
          enable = {
            "bash",
            "c",
            "cpp",
            "dockerfile",
            "fish",
            "json",
            "jsonc",
            "lua",
            "markdown",
            "ocaml",
            "ocaml_interface",
            "ocamllex",
            "rust",
            "sql",
            "toml",
            "vim",
            "vimdoc",
            "yaml",
          },
        },
      })
    end,
  },
}
