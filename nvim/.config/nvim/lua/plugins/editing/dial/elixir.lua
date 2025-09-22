local augend = require("dial.augend")

return {
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
}
