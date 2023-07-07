return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead",
  build = ":TSUpdate",
  config = function()
    require("config.treesitter").setup()
  end,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
}
