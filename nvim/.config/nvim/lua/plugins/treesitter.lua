return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "dockerfile",
          "fish",
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
            "dockerfile",
            "fish",
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
    end,
  },
}
