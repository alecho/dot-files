return {
  "zk-org/zk-nvim",
  cmd = "ZkNotes",
  event = "VeryLazy",
  config = function()
    require("zk").setup({
      picker = "fzf_lua",
    })
  end,
}
