return {
  "pwntester/octo.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
  },
  cmd = { "Octo", "OctoReactions" },
  config = function()
    require("octo").setup()
  end,
}
