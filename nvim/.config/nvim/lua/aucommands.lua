local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

---@param group_name string The name of the autocommand group
---@param events table[] A list of event configurations
local function create_autocmd_group(group_name, events)
  local group = augroup(group_name, { clear = true })

  for _, event_config in ipairs(events) do
    event_config.group = group
    autocmd(event_config.event, event_config)
  end
end

-- Remove trailing whitespace on save
create_autocmd_group("RemoveWhitespace", {
  {
    event = "BufWritePre",
    pattern = "*",
    desc = "Remove trailing whitespace before saving the file",
    command = [[:%s/\s\+$//e]],
  },
})

-- Disable automatic commenting on new lines
create_autocmd_group("NoAutoComment", {
  {
    event = "BufEnter",
    pattern = "*",
    desc = "Disable automatic commenting on new lines",
    callback = function()
      vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
  },
})

-- Highlight yanked text briefly
create_autocmd_group("YankHighlight", {
  {
    event = "TextYankPost",
    desc = "Highlight yanked text briefly",
    callback = function()
      vim.hl.on_yank({
        higroup = "IncSearch",
        timeout = 100,
        on_visual = true,
      })
    end,
  },
})
