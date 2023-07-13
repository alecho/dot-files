return {
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("config.cmp").setup()
    end,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "zbirenbaum/copilot.lua",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      { "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("config.luasnip").setup()
    end,
    dependencies = {
      "honza/vim-snippets",
      "rafamadriz/friendly-snippets",
    }
  },

  { "honza/vim-snippets" },
  { "rafamadriz/friendly-snippets" },

  -- Machine Learning Code completion
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("config.copilot_lua").setup()
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end
  },
}
