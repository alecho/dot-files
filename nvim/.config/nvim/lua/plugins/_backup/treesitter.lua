return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "eex",
        "elixir",
        "gitignore",
        "go",
        "graphql",
        "heex",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "ruby",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      },

      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,

      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        disable = { "html" },
      },

      indent = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gv",
          node_incremental = "gv",
          scope_incremental = false,
          node_decremental = "gV",
        },
      },

      -- vim-matchup
      matchup = {
        enable = true,
      },

      -- nvim-treesitter-textobjects
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {

            -- Function
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",

            -- Class
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",

            -- String
            ["a'"] = { query = "@string.outer", desc = "Select outer part of a string" },
            ["i'"] = { query = "@string.inner", desc = "Select inner part of a string" },

            -- Conditional
            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            -- Assigment
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

            -- Statement
            ["a;"] = { query = "@statement.outer", desc = "Select outer part of a statement" },
            ["i;"] = { query = "@statement.inner", desc = "Select inner part of a statement" },

            -- Parameter
            ["a,"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
            ["i,"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },

            -- Comment
            ["a/"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
            ["i/"] = { query = "@comment.inner", desc = "Select inner part of a comment" },

            -- Loop
            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
            -- Call
            ["a("] = { query = "@call.outer", desc = "Select outer part of a call" },
            ["i("] = { query = "@call.inner", desc = "Select inner part of a call" },

            -- Index
            ["a["] = { query = "@index.outer", desc = "Select outer part of an index" },
            ["i["] = { query = "@index.inner", desc = "Select inner part of an index" },

            -- Block
            ["a{"] = { query = "@block.outer", desc = "Select outer part of a block" },
            ["i{"] = { query = "@block.inner", desc = "Select inner part of a block" },

            -- Template
            ["a<"] = { query = "@template.outer", desc = "Select outer part of a template" },
            ["i<"] = { query = "@template.inner", desc = "Select inner part of a template" },
          },
        },

        swap = {
          enable = true,
          swap_next = {
            ["<leader>l,"] = "@parameter.inner",
            ["<leader>lp"] = "@paragraph.inner",
          },
          swap_previous = {
            ["<leader>h,"] = "@parameter.inner",
            ["<leader>hp"] = "@paragraph.inner",
          },
        },

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },

        lsp_interop = {
          enable = true,
          border = "none",
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },

      -- endwise
      endwise = {
        enable = true,
      },
    }
  end,
}
