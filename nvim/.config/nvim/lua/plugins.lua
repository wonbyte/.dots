return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use("neovim/nvim-lspconfig")

  -- Mason
  use({
    "williamboman/mason.nvim",
    requires = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("config.mason")
    end,
  })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })

  -- Cmp
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/vim-vsnip-integ" },
      { "rust-lang/vscode-rust" },
    },
    config = function()
      require("config.cmp")
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  })

  use("nvim-treesitter/nvim-treesitter-textobjects")

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function()
      require("config.telescope")
    end,
  })

  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Lualine
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("config.lualine")
    end,
  })

  -- Fidget
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })

  -- Lightbulb
  use({
    "kosayoda/nvim-lightbulb",
    requires = "antoinemadec/FixCursorHold.nvim",
    config = function()
      require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
    end,
  })

  -- Tokyonight
  use({
    "folke/tokyonight.nvim",
    config = function()
      require("config.tokyonight")
    end,
  })
end)
