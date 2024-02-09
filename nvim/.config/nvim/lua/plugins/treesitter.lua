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
          "html",
          "graphql",
          "json",
          "jsonc",
          "lua",
          "markdown",
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
            "html",
            "graphql",
            "json",
            "jsonc",
            "lua",
            "markdown",
            "rust",
            "sql",
            "toml",
            "vim",
            "vimdoc",
            "yaml",
          },
        },
      })
    end
  },
}
