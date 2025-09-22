local augend = require("dial.augend")

-- Additional Cypress-specific augends beyond what's in javascript.lua
return {
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
  -- Chainable getters
  augend.constant.new {
    elements = {
      "to",
      "be",
      "been",
      "is",
      "that",
      "which",
      "and",
      "has",
      "have",
      "with",
      "at",
      "of",
      "same"
    },
    word = true,
    cyclic = true,
  },
}
