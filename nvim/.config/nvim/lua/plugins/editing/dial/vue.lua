local augend = require("dial.augend")

return {
  augend.constant.new {
    elements = {
      "let",
      "const",
    },
    word = true,
    cyclic = false,
  },
}
