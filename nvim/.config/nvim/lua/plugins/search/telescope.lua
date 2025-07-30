return {
  "nvim-telescope/telescope.nvim",
  module = "telescope",
  name = "telescope",
  config = function()
    local actions = require('telescope.actions')
    local themes = require('telescope.themes')

    require('telescope').setup {
      defaults = {
        theme = "dropdown",
        layout_strategy = "center",
        layout_config = {
          center = { height = 0.8, width = 0.8 }
          -- other layout configuration here
        },
        mappings = {
          i = {
            ["<C-j>"] = {
              actions.move_selection_next, type = "action",
              opts = { nowait = true, silent = true }
            },
            ["<C-k>"] = {
              actions.move_selection_previous, type = "action",
              opts = { nowait = true, silent = true }
            },
            ["C-l"] = {
              actions.preview_scrolling_right, type = "action",
            }
          },
        },
      }
    }
  end,
}
