return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = {
            normal = {
              a = { fg = '#000000', bg = '#f5c2e7', gui = 'bold' },
              b = { fg = '#ffffff', bg = '#302d41' },
              c = { fg = '#ffffff', bg = '#302d41' },
            },
            insert = { a = { fg = '#000000', bg = '#50fa7b', gui = 'bold' } },
            visual = { a = { fg = '#000000', bg = '#ffb86c', gui = 'bold' } },
            replace = { a = { fg = '#000000', bg = '#ff5555', gui = 'bold' } },
            command = { a = { fg = '#000000', bg = '#8be9fd', gui = 'bold' } },
            inactive = {
              a = { fg = '#ffffff', bg = '#302d41', gui = 'bold' },
              b = { fg = '#ffffff', bg = '#302d41' },
              c = { fg = '#ffffff', bg = '#302d41' },
            },
          },
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
          },
          lualine_b = { "filename", "branch" },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
}
