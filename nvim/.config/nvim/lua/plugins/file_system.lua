return {
  -- oil.nvim
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        -- "size",
        -- "mtime",
      },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<TAB>"] = { "actions.select", opts = { tab = true } },
        ["<ESC>"] = { "actions.close" }
      },
      view_options = {
        show_hidden = true,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          if name:match("^%.git$") then
            return true
          end

          return false
        end,
      },
      float = {
        padding = 8,
        max_width = 80,
        max_height = 0,
        win_options = {
          winblend = 10,
        },
      },
    },
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
