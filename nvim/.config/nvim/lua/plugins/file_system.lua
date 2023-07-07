return {
  -- oil.nvim
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
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
  }
}
