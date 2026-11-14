-- tsgo: root dir -> the buffer that started it. root_dir records it so cmd
-- can resolve TypeScript from that file (see tsgo below).
local tsgo_start_buf = {}

local servers = {
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork" },
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
      gopls = {
        staticcheck = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
      ".luarc.json",
      ".luarc.jsonc",
      ".stylua.toml",
      "stylua.toml",
      ".git",
    },
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
  -- TypeScript / JavaScript (TS 7 native Go-based LSP, invoked as `tsc --lsp`).
  tsgo = {
    -- cmd as a function: resolve the workspace's OWN TypeScript at server
    -- start, so each project uses the version it pins. When cmd is a
    -- function it must start the RPC client itself via vim.lsp.rpc.start().
    cmd = function(dispatchers, config)
      -- Resolve from the file that started this client, not from the root:
      -- in a monorepo the root can be the .git dir above the package, so
      -- an upward search from the root would miss the package's own
      -- node_modules. root_dir below records that buffer per root. The
      -- current buffer is only a fallback.
      local bufnr = tsgo_start_buf[config.root_dir]
      if not (bufnr and vim.api.nvim_buf_is_valid(bufnr)) then
        bufnr = 0
      end
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local start = (bufname ~= "") and vim.fs.dirname(bufname) or vim.uv.cwd()

      -- Returns the major version number (7, 5, ...) from a version string
      -- like "7.0.1" or "Version 7.0.1". Returns nil if no number is found.
      local function major(s)
        return tonumber((s or ""):match("(%d+)%."))
      end

      -- Returns the major version of the `typescript` package inside one
      -- node_modules dir, or nil if it is missing or unreadable.
      -- Why: `.bin/tsc` exists for BOTH old TypeScript (5.x, JavaScript) and
      -- TS 7+ (native Go). Only 7+ understands `--lsp`. Old tsc exits with
      -- code 1 and prints its error to stdout, which Neovim reads as LSP
      -- data and drops -- so lsp.log shows nothing. We must check first.
      local function ts_major(nm)
        local ok, lines =
          pcall(vim.fn.readfile, nm .. "/typescript/package.json")
        if not ok or #lines == 0 then
          return nil
        end
        local ok2, pkg = pcall(vim.json.decode, table.concat(lines, "\n"))
        if not ok2 or type(pkg) ~= "table" then
          return nil
        end
        return major(pkg.version)
      end

      -- Every node_modules going up from the file, nearest first.
      -- limit = math.huge covers monorepos where deps are hoisted higher up.
      local nm_dirs = vim.fs.find("node_modules", {
        upward = true,
        type = "directory",
        path = start,
        limit = math.huge,
      })

      -- Remember if we skipped an old tsc, so the error message can say why.
      local skipped_old = nil

      local bin
      for _, nm in ipairs(nm_dirs) do
        -- 1. @typescript/native-preview ships `tsgo`. It is always native,
        --    so it wins with no version check.
        local tsgo = nm .. "/.bin/tsgo"
        if vim.uv.fs_stat(tsgo) then
          bin = tsgo
          break
        end

        -- 2. `tsc` only counts when the typescript package is 7 or newer.
        local tsc = nm .. "/.bin/tsc"
        if vim.uv.fs_stat(tsc) then
          local v = ts_major(nm)
          if v and v >= 7 then
            bin = tsc
            break
          end
          skipped_old = skipped_old
            or (tsc .. " (TypeScript " .. (v or "unknown version") .. ")")
        end
      end

      -- No usable local binary: fall back to a global one on PATH.
      if not bin then
        if vim.fn.executable("tsgo") == 1 then
          -- Global tsgo is always native.
          bin = "tsgo"
        elseif vim.fn.executable("tsc") == 1 then
          -- Global tsc may also be old 5.x. Read the version from its
          -- package.json instead of running `tsc --version`, which would
          -- block the editor while Node starts. A global install links
          -- tsc to <node_modules>/typescript/bin/tsc.
          local real = vim.uv.fs_realpath(vim.fn.exepath("tsc"))
          local v = real
            and ts_major(vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(real))))
          if v and v >= 7 then
            bin = "tsc"
          else
            skipped_old = skipped_old
              or ("global tsc (TypeScript " .. (v or "unknown version") .. ")")
          end
        end
      end

      -- cmd-as-function MUST return an rpc client: client.lua assigns the
      -- return value to self.rpc with no nil check. error() gives a clear
      -- message here instead of a cryptic nil-index traceback later.
      if not bin then
        local msg = "tsgo: no native tsgo or TypeScript 7+ tsc found "
          .. "upward from "
          .. start
        if skipped_old then
          msg = msg
            .. "; skipped old "
            .. skipped_old
            .. ". Fix: npm install -D typescript@latest (7+)"
        end
        error(msg)
      end

      return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers)
    end,

    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },

    -- typescript-go panics ("path \"tsconfig.json\" is not absolute") if it is
    -- started with NO workspace root (null rootUri) -- it has no usable
    -- single-file mode. root_dir as a function resolves an ABSOLUTE root from
    -- the buffer (vim.fs.root walks upward, returns an absolute dir or nil)
    -- and only activates when one is found. Passing bufnr, not a name string,
    -- avoids any relative-path issue. This replaces root_markers, which is
    -- ignored once root_dir is defined.
    root_dir = function(bufnr, on_dir)
      local root = vim.fs.root(bufnr, {
        "tsconfig.json",
        "jsconfig.json",
        "package.json",
        ".git",
      })
      -- Only start when we have a real root. If nil, we don't call on_dir, so
      -- the server does not attach for this buffer instead of crashing.
      if root then
        tsgo_start_buf[root] = bufnr
        on_dir(root)
      end
    end,

    -- Belt-and-suspenders: never let Neovim launch tsgo root-less even if the
    -- above ever yields nothing. Native equivalent of lspconfig's
    -- single_file_support = false.
    workspace_required = true,

    -- tsgo's inlay hint settings are nested per-language and each hint type
    -- takes an object (not a flat boolean) -- a different shape than the old
    -- ts_ls / tsserver config. These describe WHICH hints the server sends;
    -- rendering them in the buffer is still gated by vim.lsp.inlay_hint.enable,
    -- which starts off (toggle with <leader>h).
    settings = {
      typescript = {
        inlayHints = {
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      javascript = {
        inlayHints = {
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
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

  -- Prettier (via conform) owns JS/TS formatting. Turn off tsgo's own
  -- formatter so files are never reformatted with different rules, even if
  -- Prettier is missing.
  if client and client.name == "tsgo" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  local keymaps = {
    { "n", "gd", vim.lsp.buf.definition, "[LSP] Go to definition" },
    { "n", "gD", vim.lsp.buf.declaration, "[LSP] Go to declaration" },
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

-- C# (Roslyn). The server needs a lot of custom client code, so use the
-- maintained config from nvim-lspconfig instead of a copy. See init.lua for
-- why the file is read from disk.
local lspconfig = vim.pack.get({ "nvim-lspconfig" })[1]
local roslyn_path = lspconfig and (lspconfig.path .. "/lsp/roslyn_ls.lua")
if roslyn_path and vim.uv.fs_stat(roslyn_path) then
  servers.roslyn_ls = dofile(roslyn_path)
end

for server_name, server_config in pairs(servers) do
  vim.lsp.config(server_name, server_config)
  vim.lsp.enable(server_name)
end
