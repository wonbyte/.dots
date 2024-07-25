return {
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    dark = "mocha",
                },
            })
            vim.cmd([[colorscheme catppuccin]])
        end,
    },
}
