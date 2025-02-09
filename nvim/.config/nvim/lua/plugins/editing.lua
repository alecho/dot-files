return {
  -- Indentation
  {
    "lukas-reineke/indent-blankline.nvim",
    module = "ibl",
    event = "BufRead",
    config = function()
      local highlight = {
        "Operator",    -- fg purple
        "Keyword",     -- fg cyan
        "Conditional", -- fg pink
        "Float",       -- fg orange
        "Character",   -- fg green
        "Constant",    -- fg yellow
        "DiffDelete",  -- fg red
      }

      require("ibl").setup { scope = { highlight = highlight } }
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    event = "InsertEnter",
    config = function()
      local np = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      np.setup({
        check_ts = true
      })

      np.add_rules({
        Rule("*", "*", { "markdown" }):with_pair(cond.not_before_regex("\n")),
        Rule("_", "_", { "markdown" }):with_pair(cond.before_regex("%s")),
      })
      np.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
      np.add_rules(require('nvim-autopairs.rules.endwise-lua'))
      np.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
    end,
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
      require('Comment').setup()
    end
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    opts = {},
    event = "VeryLazy",
  },

  -- Code toggle (split and join)
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    keys = { "<leader>s", "<leader>j", "<leader>m" },
    config = function()
      require('treesj').setup()
    end,
  },

  -- Batch editing
  {
    "ray-x/sad.nvim",
    dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
    cmd = "Sad",
    config = function()
      require("sad").setup {}
    end,
  },

  -- Bullets & lists
  {
    "dkarter/bullets.vim",
    event = "BufRead",
  },

  {
    'johmsalas/text-case.nvim',
    event = "BufRead",
    config = function()
      require('textcase').setup {}
      require('telescope').load_extension('textcase')
      vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Change case" })
      vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Change case" })
    end
  }
}
