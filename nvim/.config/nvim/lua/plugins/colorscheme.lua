return {
  -- Tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
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
    },
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
