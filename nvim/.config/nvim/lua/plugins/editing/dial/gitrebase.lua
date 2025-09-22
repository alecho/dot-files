local augend = require("dial.augend")

return {
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
}
