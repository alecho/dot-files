return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("config.whichkey").setup()
  end,
}
