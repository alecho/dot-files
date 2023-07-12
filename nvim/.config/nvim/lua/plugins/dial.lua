return {
  "monaqa/dial.nvim",
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group {
      -- default augends used when no group name is specified
      default = {
        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex,
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d/%Y"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        -- todays date
        "06/10/2732",
        -- For git interactive rebase, filetype: git-rebase-todo
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
          cyclic = true,
        },
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
      -- For Elixir filetype: elixir, eelixir, heex
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
    }
  end,
  keys = {
    { "<C-=>" },
    { "<C-->" },
  },
}
