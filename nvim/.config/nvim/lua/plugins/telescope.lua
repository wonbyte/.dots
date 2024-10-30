return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            local telescope = require("telescope")
            local previewers = require("telescope.previewers")
            local sorters = require("telescope.sorters")

            telescope.setup({
                defaults = {
                    layout_config = {
                        horizontal = {
                            preview_width = 0.6, -- Adjust preview window size (60% of window)
                        },
                        vertical = {
                            preview_height = 0.5, -- Adjust preview height for vertical layout
                        },
                        prompt_position = "top", -- Move prompt to the top for better ergonomics
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    sorting_strategy = "ascending",  -- Show results in ascending order
                    prompt_prefix = " 🔍 ", -- More visually distinct prefix
                    selection_caret = " ", -- Better caret icon
                    color_devicons = true,

                    file_sorter = sorters.get_fuzzy_file,
                    file_ignore_patterns = { ".git/", },
                    path_display = { "smart" }, -- Smarter path display

                    file_previewer = previewers.vim_buffer_cat.new,
                    grep_previewer = previewers.vim_buffer_vimgrep.new,
                    qflist_previewer = previewers.vim_buffer_qflist.new,

                    -- Better mappings within Telescope prompts
                    mappings = {
                        i = {
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-q>"] = require("telescope.actions").send_to_qflist
                                + require("telescope.actions").open_qflist,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = false,   -- Show hidden files
                        previewer = true, -- Enable preview for `find_files`
                    },
                    live_grep = {
                        previewer = true, -- Enable preview for `live_grep`
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- Enable fuzzy matching
                        override_generic_sorter = true, -- Override built-in sorter
                        override_file_sorter = true,    -- Override file sorter
                        case_mode = "smart_case",       -- Case-sensitive if input contains uppercase
                    },
                },
            })

            -- Load the FZF extension
            telescope.load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make", -- Ensure the native extension is built
    },
}
