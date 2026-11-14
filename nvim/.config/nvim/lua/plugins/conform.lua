require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    go = { "gofmt" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = { timeout_ms = 2000 },
})

vim.keymap.set("n", "<leader>fm", function()
  require("conform").format({ async = true })
end, { desc = "Format buffer" })
