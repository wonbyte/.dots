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
          "css",
          "dockerfile",
          "fish",
          "html",
          "graphql",
          "javascript",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "rust",
          "scss",
          "sql",
          "typescript",
          "tsx",
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
            "css",
            "dockerfile",
            "fish",
            "html",
            "graphql",
            "javascript",
            "json",
            "jsonc",
            "lua",
            "markdown",
            "rust",
            "scss",
            "sql",
            "typescript",
            "tsx",
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
