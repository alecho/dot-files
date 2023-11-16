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
    event = "VeryLazy",
    config = function()
      require("config.autopairs").setup()
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
}
