local augend = require("dial.augend")

return {
  -- let/const toggle
  augend.constant.new {
    elements = {
      "let",
      "const",
    },
    word = true,
    cyclic = false,
  },
  -- Cypress test constructs
  augend.constant.new {
    elements = {
      "describe",
      "context",
      "it",
      "specify"
    },
    word = true,
    cyclic = false,
  },
  -- Cypress hooks
  augend.constant.new {
    elements = {
      "before",
      "after",
      "beforeEach",
      "afterEach"
    },
    word = true,
    cyclic = false,
  },
  -- Cypress assertion patterns
  augend.constant.new {
    elements = {
      "should",
      "expect",
      "assert"
    },
    word = true,
    cyclic = false,
  },
  -- Cypress focus/skip toggles
  augend.constant.new {
    elements = {
      "it",
      "it.only",
      "it.skip",
    },
    word = true,
    cyclic = true,
  },
  augend.constant.new {
    elements = {
      "describe",
      "describe.only",
      "describe.skip",
    },
    word = true,
    cyclic = true,
  },
  augend.constant.new {
    elements = {
      "context",
      "context.only",
      "context.skip",
    },
    word = true,
    cyclic = true,
  },
}
