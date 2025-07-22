return {
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    -- The configuration is now directly in plugins/cmp.lua
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
    -- The configuration is now directly in plugins/luasnip.lua
    dependencies = {
      "honza/vim-snippets",
      "rafamadriz/friendly-snippets",
    }
  },

  { "honza/vim-snippets" },
  { "rafamadriz/friendly-snippets" },

  -- -- Machine Learning Code completion
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   dependencies = { "zbirenbaum/copilot.lua" },
  --   cond = not vim.g.started_by_firenvim,
  --   opt = {
  --   panel = {
  --     enabled = false,
  --     auto_refresh = false,
  --     keymap = {
  --       jump_prev = "[[",
  --       jump_next = "]]",
  --       accept = "<CR>",
  --       refresh = "gr",
  --       open = "<M-CR>"
  --     },
  --     layout = {
  --       position = "bottom", -- | top | left | right
  --       ratio = 0.5
  --     },
  --   },
  --   suggestion = {
  --     enabled = false,
  --     auto_trigger = false,
  --     debounce = 75,
  --     keymap = {
  --       accept = "<M-l>",
  --       accept_word = false,
  --       accept_line = false,
  --       next = "<M-]>",
  --       prev = "<M-[>",
  --       dismiss = "<C-]>",
  --     },
  --   },
  --   filetypes = {
  --     yaml = false,
  --     markdown = false,
  --     help = false,
  --     gitcommit = false,
  --     gitrebase = false,
  --     hgcommit = false,
  --     svn = false,
  --     cvs = false,
  --     ["."] = false,
  --   },
  --   copilot_node_command = '/Users/andrewlechowicz/.asdf/installs/nodejs/19.8.1/bin/node', -- Node.js version must be > 16.x
  --   server_opts_overrides = {},
  -- }

  -- },
  --
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   event = "InsertEnter",
  --   cond = not vim.g.started_by_firenvim,
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- },
}
