return {
  "mickael-menu/zk-nvim",
  dependencies = {
    "folke/which-key.nvim",
  },
  config = function()
    require("config.zk").setup()
  end,
}
