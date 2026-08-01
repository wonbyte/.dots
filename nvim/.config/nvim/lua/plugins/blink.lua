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
    return vim.g.completion ~= false -- on by default; set vim.g.completion = false to opt out globally
  end,
})
