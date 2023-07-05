return {

  -- Notification
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      vim.notify = require "notify"
    end,
  },

  -- Colorscheme
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_cmd({
        cmd = "colorscheme",
        args = { "dracula" },
      }, {})
    end,
  },

  -- Icons
  {
    'nvim-tree/nvim-web-devicons'
  },

  -- Smooth scrolling
  {
    'declancm/cinnamon.nvim',
    config = {
      extra_keymaps = true,
      max_length = 400,
      scroll_limit = 3000,
    }
  },

  -- Colorcolumn
  {
    'Bekaboo/deadcolumn.nvim',
    config = {
      scope = 'visible',
      modes = { 'n', 'i', 'ic', 'ix', 'R', 'Rc', 'Rx', 'Rv', 'Rvc', 'Rvx' },
      warning = {
        alpha = 0.6,
        colorcode = '#ff5555',
      },
    }
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("config.lualine").setup()
    end,
  },

  -- Tabline
  {
    'romgrk/barbar.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("config.barbar").setup()
    end,

  },

  -- Indentation
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
      }
    end,
  },

  -- Git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      'sindrets/diffview.nvim',
    },
    config = function()
      require("config.neogit").setup()
    end,
  },
  { 'f-person/git-blame.nvim' },
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- Key Mapping
  -- WhichKey
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require('legendary').setup({
        which_key = {
          auto_register = true,
        },
      })
      require("config.whichkey").setup()
    end,
  },
  -- Legendary
  {
    'mrjones2014/legendary.nvim',
    -- To use frequency sorting
    dependencies = { 'kkharji/sqlite.lua' },
  },

  -- Session
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = {
          "~/",
          "~/Projects",
          "~/Downloads",
          "/",
        },
      }
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter").setup()
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    config = function()
      require("config.autopairs").setup()
    end,
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- Movement
  {
    'smoka7/hop.nvim',
    version = '*', -- optional but strongly recommended
    config = function()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      hop.setup {}
      vim.keymap.set('', 'f', function()
        hop.hint_char1({
          direction = directions.AFTER_CURSOR,
          current_line_only = true
        })
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({
          direction = directions.BEFORE_CURSOR,
          current_line_only = true
        })
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1({
          direction = directions.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1
        })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.int_char1({
          direction = directions.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = 1
        })
      end, { remap = true })
      vim.keymap.set('', 'W', hop.hint_words, { remap = true })
      vim.keymap.set('', '\\', hop.hint_patterns, { remap = true })
    end
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to defaults
      })
    end
  },

  -- Code toggle (split and join)
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    config = function()
      require('treesj').setup()
    end,
  },

  -- Batch editing
  {
    "ray-x/sad.nvim",
    dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
    config = function()
      require("sad").setup {}
    end,
  },

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
    config = function()
      require("copilot_cmp").setup()
    end
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("config.cmp").setup()
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "zbirenbaum/copilot.lua",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      { "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("config.luasnip").setup()
        end,
      },
      "honza/vim-snippets",
    },
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require("config.lsp").setup()
    end,
  },
  { "onsails/lspkind.nvim" },

  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      require("config.nvimtree").setup()
    end,
  },

  -- File system
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end
  },

  -- Aerial
  {
    'stevearc/aerial.nvim',
    config = function()
      require("config.aerial").setup()
    end
  },

  -- FZF Lua
  {
    "ibhagwan/fzf-lua",
    event = "BufEnter",
    config = function()
      require("config.fzf").setup()
    end
  },

  -- User interface
  {
    "stevearc/dressing.nvim",
    event = "BufEnter",
    config = function()
      require("dressing").setup {
        select = {
          backend = { "telescope", "fzf", "builtin" },
        },
      }
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    name = "telescope"
  },

  -- Notes
  {
    "mickael-menu/zk-nvim",
    dependencies = {
      "folke/which-key.nvim",
    },
    config = function()
      require("config.zk").setup()
    end,
  },

  -- GitHub
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'telescope',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  },

  {
    'glacambre/firenvim',
    build = function() vim.fn['firenvim#install'](0) end
  },

  -- Markdown
  {
    'ellisonleao/glow.nvim',
    config = function()
      require("glow").setup()
    end
  },

  --Fun
  { 'eandrju/cellular-automaton.nvim' },

}
