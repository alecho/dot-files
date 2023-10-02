local inc_keymap = "<C-=>"
local dec_keymap = "<C-->"

return {
  "monaqa/dial.nvim",
  lazy = false,
  config = function()
    local augend = require("dial.augend")
    local config = require("dial.config")

    vim.keymap.set("n", inc_keymap, require("dial.map").inc_normal(), { noremap = true })
    vim.keymap.set("n", dec_keymap, require("dial.map").dec_normal(), { noremap = true })


    config.augends:register_group {
      default = {
        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex,
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d/%Y"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        -- English week day name
        augend.constant.new {
          elements = {
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
          },
          word = true,
          cyclic = true,
        },
        -- English week day abbreviation
        augend.constant.new {
          elements = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" },
          word = true,
          cyclic = true,
        },
        -- English month
        augend.constant.new {
          elements = {
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
          },
          word = true,
          cyclic = true,
        },
      },
    }
    -- Loaded automatically on filetype
    config.augends:on_filetype {
      ruby = {
        augend.integer.alias.decimal,
        augend.constant.new {
          elements = { "debug", "info", "warning", "error" },
          word = true,
          cyclic = true
        },
      },
      markdown = {
        augend.integer.alias.decimal,
        augend.misc.markdown_header,
      },
      elixir = {
        augend.constant.new {
          elements = { "def", "defp" },
          word = true,
          cyclic = false,
        },
        augend.constant.new {
          elements = { "{:ok, ", "{:error, " },
          word = true,
          cyclic = false,
        },
      },
      gitrebase = {
        augend.constant.new {
          elements = {
            "pick",
            "squash",
            "edit",
            "reword",
            "fixup",
            "exec",
            "drop",
          },
          word = true,
          cyclic = false,
        },
      },
      javascript = {
        augend.constant.new {
          elements = {
            "let",
            "const",
          },
          word = true,
          cyclic = false,
        },
      },
      vue = {
        augend.constant.new {
          elements = {
            "let",
            "const",
          },
          word = true,
          cyclic = false,
        },
      },
    }
  end,
  keys = { inc_keymap, dec_keymap },
}
