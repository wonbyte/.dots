return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "NvimTree", "packer" },
          theme = {
            normal = {
              a = { fg = "#1b1e2b", bg = "#88c0d0", gui = "bold" },
              b = { fg = "#88c0d0", bg = "#1b1e2b" },
              c = { fg = "#d8dee9", bg = "#1b1e2b" },
            },
            insert = {
              a = { fg = "#1b1e2b", bg = "#8fbcbb", gui = "bold" },
            },
            visual = {
              a = { fg = "#1b1e2b", bg = "#81a1c1", gui = "bold" },
            },
            replace = {
              a = { fg = "#1b1e2b", bg = "#d08770", gui = "bold" },
            },
            inactive = {
              a = { fg = "#4c566a", bg = "#1b1e2b" },
              b = { fg = "#4c566a", bg = "#1b1e2b" },
              c = { fg = "#4c566a", bg = "#1b1e2b" },
            },
          },
        },
        sections = {
          lualine_a = { { "mode" } },
          lualine_b = { "filename", "branch" },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = { { "location" } },
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
        extensions = { "quickfix" },
      })
    end,
  },
}
