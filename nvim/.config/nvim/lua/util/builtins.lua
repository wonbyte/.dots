local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local M = {}

M.search_dotfiles = function()
  builtin.find_files({
    file_ignore_patterns = { ".git/" },
    prompt_title = "< VimRC > ",
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end

M.git_branches = function()
  builtin.git_branches({
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.git_delete_branch)
      map("n", "<c-d>", actions.git_delete_branch)
      return true
    end,
  })
end

return M
