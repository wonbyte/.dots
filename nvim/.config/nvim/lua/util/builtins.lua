local builtin = require("telescope.builtin")
local M = {}

-- Search dotfiles in the DOTFILES directory
M.search_dotfiles = function()
  builtin.find_files({
    prompt_title = "< VimRC >",
    cwd = vim.env.DOTFILES or "~/.config/nvim",
    hidden = true,
  })
end

return M
