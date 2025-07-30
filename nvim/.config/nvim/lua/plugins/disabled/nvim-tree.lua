return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        disable_netrw = true,
        hijack_netrw = true,
        sort_by = "name",
        view = {
          number = true,
          relativenumber = true,
        },
        filters = {
          custom = { ".git" },
        },
      }
    end,
  }
}
