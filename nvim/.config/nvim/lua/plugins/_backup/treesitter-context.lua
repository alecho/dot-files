return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {}
}
