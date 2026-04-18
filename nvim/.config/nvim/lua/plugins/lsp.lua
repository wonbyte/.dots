-- Set blink.cmp capabilities for all LSP servers (deep-merged with per-server config)
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

local ts_inlay_hints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

local servers = {
  clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
    init_options = {
      offsetEncoding = "utf-8",
    },
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
    settings = {
      Lua = {
        completion = {
          callSnippet = "Disable",
          keywordSnippet = "Disable",
        },
      },
    },
  },
  rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json", ".git" },
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        completion = { callable = { snippets = "add_parentheses" } },
      },
    },
  },
}

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  underline = false,
  severity_sort = true,
})

-- LSP keymaps on attach
local function on_lsp_attach(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if client then
    -- Enable inlay hints if supported
    if client:supports_method("textDocument/inlayHint", bufnr) then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Disable ts_ls formatting in favour of prettier via conform
    if client.name == "ts_ls" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end

  local keymaps = {
    { "n", "gd", vim.lsp.buf.definition, "[LSP] Go to definition" },
    { "n", "gD", vim.lsp.buf.declaration, "[LSP] Go to declaration" },
    { "n", "gr", vim.lsp.buf.references, "[LSP] References" },
    { "n", "<leader>D", vim.lsp.buf.type_definition, "[LSP] Type definition" },
    { "n", "<C-k>", vim.lsp.buf.signature_help, "[LSP] Signature help" },
    { "n", "<leader>rn", vim.lsp.buf.rename, "[LSP] Rename symbol" },
    {
      { "n", "v" },
      "<leader>ca",
      vim.lsp.buf.code_action,
      "[LSP] Code actions",
    },
    {
      "n",
      "[d",
      function()
        vim.diagnostic.jump({ count = -1, float = true })
      end,
      "[Diag] Prev",
    },
    {
      "n",
      "]d",
      function()
        vim.diagnostic.jump({ count = 1, float = true })
      end,
      "[Diag] Next",
    },
  }

  for _, km in ipairs(keymaps) do
    vim.keymap.set(km[1], km[2], km[3], { buffer = bufnr, desc = km[4] })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = on_lsp_attach,
})

for server_name, server_config in pairs(servers) do
  vim.lsp.config(server_name, server_config)
  vim.lsp.enable(server_name)
end
