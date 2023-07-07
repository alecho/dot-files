return {
  -- FZF Lua
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    config = function()
      require("config.fzf").setup()
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    name = "telescope"
  }
}
