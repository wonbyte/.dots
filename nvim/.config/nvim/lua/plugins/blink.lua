require("blink.cmp").setup({
  appearance = {
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  fuzzy = { implementation = "prefer_rust" },
  enabled = function()
    if vim.b.completion ~= nil then
      return vim.b.completion
    end
    -- Off by default; set vim.g.completion = true to opt in globally
    return vim.g.completion == true
  end,
})
