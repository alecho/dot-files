return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    opts = {}
  },
  {
    'f-person/git-blame.nvim',
    name = 'gitblame',
    event = 'BufRead',
    opts = {
      date_format = '%r'
    }
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
}
