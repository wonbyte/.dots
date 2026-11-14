require("mason").setup({})

-- Language servers used in plugins/lsp.lua (Mason package names)
-- tsgo is deliberately absent: its cmd resolves TypeScript 7+ from each
-- project's own node_modules.
local ensure_installed = {
  "gopls",
  "lua-language-server",
  "rust-analyzer",
}

local registry = require("mason-registry")

local missing = vim.tbl_filter(function(name)
  return not registry.is_installed(name)
end, ensure_installed)

-- Only touch the network when something is missing
if #missing > 0 then
  registry.refresh(function()
    for _, name in ipairs(missing) do
      local ok, pkg = pcall(registry.get_package, name)
      if not ok then
        vim.notify("Mason: unknown package " .. name, vim.log.levels.WARN)
      elseif not pkg:is_installing() then
        vim.notify("Mason: installing " .. name)
        pkg:install()
      end
    end
  end)
end
