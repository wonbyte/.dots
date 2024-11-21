return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Diagnostics Configuration
      vim.diagnostic.config({
        float = {
          border = "rounded",
          source = "true",
        },
        -- Disable inline virtual text
        virtual_text = false,
        -- Enable diagnostic signs
        signs = false,
        -- Show underlines for diagnostics
        underline = false,
        -- Don't update diagnostics while typing
        update_in_insert = false,
        -- Sort diagnostics by severity
        severity_sort = true,
      })

      -- Float Window Borders
      local border = {
        { "🭽", "FloatBorder" },
        { "▔", "FloatBorder" },
        { "🭾", "FloatBorder" },
        { "▕", "FloatBorder" },
        { "🭿", "FloatBorder" },
        { "▁", "FloatBorder" },
        { "🭼", "FloatBorder" },
        { "▏", "FloatBorder" },
      }

      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover,
          { border = border }
        ),
        ["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = border }
        ),
      }

      -- https://github.com/neovim/neovim/issues/30985 (ISSUE)
      -- https://github.com/neovim/neovim/pull/30999 (FIX)
      for _, method in ipairs({
        "textDocument/diagnostic",
        "workspace/diagnostic",
      }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
          if err ~= nil and err.code == -32802 then
            return
          end
          return default_diagnostic_handler(err, result, context, config)
        end
      end

      -- Set up capabilities (optional, required if using completion plugins)
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Lua Language Server Configuration (lua_ls)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        handlers = handlers,
        settings = {
          Lua = {
            -- LuaJIT for Neovim
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        },
      })

      -- Rust Analyzer Configuration (rust_analyzer)
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        handlers = handlers,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
          },
        },
      })

      -- LspAttach AutoCommand for Buffer-Local Keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          -- Enable completion with <C-x><C-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer-Local Mappings
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set(
            { "n", "v" },
            "<space>ca",
            vim.lsp.buf.code_action,
            opts
          )
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },
}
