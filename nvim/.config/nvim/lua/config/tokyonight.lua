local tokyonight = require("tokyonight")

tokyonight.setup({
  style = "moon",
  hide_inactive_statusline = true,
  sidebars = {
    "qf",
    "terminal",
    "packer",
    "help",
  },
  on_highlights = function(hl, c)
    hl.CursorLineNr = { fg = c.orange, bold = true }
    hl.LineNr = { fg = c.orange, bold = true }
    hl.LineNrAbove = { fg = c.fg_gutter }
    hl.LineNrBelow = { fg = c.fg_gutter }
  end,
})

tokyonight.load()
