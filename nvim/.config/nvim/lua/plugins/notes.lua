return {
  "mickael-menu/zk-nvim",
  cmd = { "ZkNew", "ZkNotes", "ZkInsertLink" },
  config = function()
    require("zk").setup({
      picker = "telescope",
    })
  end,
}
