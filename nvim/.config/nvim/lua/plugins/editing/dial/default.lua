local augend = require("dial.augend")

return {
  augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
  augend.integer.alias.hex,
  augend.date.alias["%Y-%m-%d"],
  augend.date.alias["%m/%d/%Y"],
  augend.date.alias["%m/%d"],
  augend.date.alias["%H:%M"],
  augend.constant.alias.bool,
  -- Directional words
  augend.constant.new {
    elements = { "left", "right" },
    word = true,
    cyclic = true,
  },
  augend.constant.new {
    elements = { "up", "down" },
    word = true,
    cyclic = true,
  },
  augend.constant.new {
    elements = { "top", "bottom" },
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
}
