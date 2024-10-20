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
        },
        autopairs = {
          enable = true,
        },
      })
    end,
  },
}
