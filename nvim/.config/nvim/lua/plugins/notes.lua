return {
  "mickael-menu/zk-nvim",
  event = "BufReadPre",
  config = function()
    require("zk").setup({
      picker = "fzf_lua",
    })
  end,
}
