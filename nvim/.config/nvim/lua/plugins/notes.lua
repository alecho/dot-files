return {
  "mickael-menu/zk-nvim",
  cmd = "ZkNotes",
  event = "BufReadPre",
  config = function()
    require("zk").setup({
      picker = "fzf_lua",
    })
  end,
}
