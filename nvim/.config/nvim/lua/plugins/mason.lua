require("mason").setup({})

-- Language servers used in plugins/lsp.lua, by Mason package name.
-- Value: the tool Mason needs on PATH to install the package (false = none).
-- A package is skipped while its tool is missing, so Mason does not fail and
-- retry on every start.
-- tsgo is deliberately absent: its cmd resolves TypeScript 7+ from each
-- project's own node_modules.
local ensure_installed = {
  ["gopls"] = "go",
  ["lua-language-server"] = false,
  ["roslyn-language-server"] = "dotnet", -- roslyn_ls (C#)
  ["rust-analyzer"] = false,
}

local registry = require("mason-registry")

local missing = {}
for name, tool in pairs(ensure_installed) do
  local can_install = not tool or vim.fn.executable(tool) == 1
  if can_install and not registry.is_installed(name) then
    missing[#missing + 1] = name
  end
end

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
