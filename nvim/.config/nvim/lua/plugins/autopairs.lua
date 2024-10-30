return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- Load when entering insert mode for better performance
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" }, -- Prevent conflicts
      check_ts = true, -- Enable treesitter integration for better pair handling
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)
    end,
  },
}
