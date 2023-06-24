local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
        vim.notify = require "notify"
      end,
    }

    -- Colorscheme
    use {
      "Mofiqul/dracula.nvim",
      config = function()
        vim.cmd "colorscheme dracula"
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Icons
    use {
      'nvim-tree/nvim-web-devicons'
    }

    -- Smooth scrolling
    use {
      'declancm/cinnamon.nvim',
      config = function()
        require('cinnamon').setup({
          extra_keymaps = true,
          max_length = 400,
          scroll_limit = 3000,
        })
      end
    }

    -- Colorcolumn
    use {
      'Bekaboo/deadcolumn.nvim',
      config = function()
        require("deadcolumn").setup({
          modes = { 'n', 'i', 'ic', 'ix', 'R', 'Rc', 'Rx', 'Rv', 'Rvc', 'Rvx' },
          warning = {
            alpha = 0.6,
            colorcode = '#ff5555',
          },
        })
      end

    }

    -- Status line
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
      config = function()
        require("config.lualine").setup()
      end,
    }

    -- Tabline
    use {
      'romgrk/barbar.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
      config = function()
        require("config.barbar").setup()
      end,

    }

    -- Indentation
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline").setup {
        }
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
      requires = {
        "nvim-lua/plenary.nvim",
        'sindrets/diffview.nvim',
      },
      config = function()
        require("config.neogit").setup()
      end,
    }
    use { 'f-person/git-blame.nvim' }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end,
    }

    -- Key Mapping
    -- WhichKey
    use {
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
    }
    -- Legendary
    use {
      'mrjones2014/legendary.nvim',
      -- To use frequency sorting
      requires = { 'kkharji/sqlite.lua' },
    }

    -- Session
    use {
      'rmagatti/auto-session',
      config = function()
        require("auto-session").setup {
          log_level = "error",
          auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        }
      end
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- Comments
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    -- Surround
    use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    })

    -- Machine Learning Code completion
    use {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("config.copilot_lua").setup()
      end,
    }

    use {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua", "nvim-cmp" },
      config = function()
        require("copilot_cmp").setup()
      end
    }

    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        { "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("config.luasnip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
      },
      disable = false,
    }

    -- LSP
    use {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    }
    use {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup()
      end,
    }
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      config = function()
        require("config.lsp").setup()
      end,
    }
    use { "onsails/lspkind.nvim" }

    -- nvim-tree
    use {
      "nvim-tree/nvim-tree.lua",
      requires = {
        "nvim-tree/nvim-web-devicons",
      },
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- Aerial
    use {
      'stevearc/aerial.nvim',
      config = function()
        require("config.aerial").setup()
      end
    }

    -- FZF Lua
    use {
      "ibhagwan/fzf-lua",
      event = "BufEnter",
      wants = "nvim-web-devicons",
      config = function()
        require("config.fzf").setup()
      end
    }

    -- User interface
    use {
      "stevearc/dressing.nvim",
      event = "BufEnter",
      config = function()
        require("dressing").setup {
          select = {
            backend = { "telescope", "fzf", "builtin" },
          },
        }
      end,
      disable = true,
    }

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      as = "telescope"
    }

    -- Notes
    use {
      "mickael-menu/zk-nvim",
      requires = {
        "folke/which-key.nvim",
      },
      config = function()
        require("config.zk").setup()
      end,
    }

    -- GitHub
    use {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'telescope',
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        require "octo".setup()
      end
    }

    use {
      'glacambre/firenvim',
      run = function() vim.fn['firenvim#install'](0) end
    }

    -- Markdown
    use {
      'ellisonleao/glow.nvim',
      config = function()
        require("glow").setup()
      end
    }

    --Fun
    use 'eandrju/cellular-automaton.nvim'

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
