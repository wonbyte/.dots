return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "dockerfile",
          "fish",
          "html",
          "go",
          "graphql",
          "javascript",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "ocaml",
          "ocaml_interface",
          "ocamllex",
          "rust",
          "scss",
          "sql",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = {
          enable = {
            "bash",
            "c",
            "cpp",
            "css",
            "dockerfile",
            "fish",
            "html",
            "go",
            "graphql",
            "javascript",
            "json",
            "jsonc",
            "lua",
            "markdown",
            "ocaml",
            "ocaml_interface",
            "ocamllex",
            "rust",
            "scss",
            "sql",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
          },
        },
      })
    end,
  },
}
