local augend = require("dial.augend")

return {
  augend.integer.alias.decimal,

  -- Log levels
  augend.constant.new {
    elements = { "debug", "info", "warning", "error" },
    word = true,
    cyclic = true
  },

  -- Method visibility
  augend.constant.new {
    elements = { "public", "protected", "private" },
    word = true,
    cyclic = true
  },

  -- Method definition
  augend.constant.new {
    elements = { "def", "def self." },
    word = false,
    cyclic = true
  },

  -- Boolean operators
  augend.constant.new {
    elements = { "&&", "||" },
    word = false,
    cyclic = true
  },

  -- Comparison operators
  augend.constant.new {
    elements = { "==", "!=", "===", "!==", "=~", "!~" },
    word = false,
    cyclic = true
  },

  -- Hash styles
  augend.constant.new {
    elements = { " => ", ": " },
    word = false,
    cyclic = true
  },

  -- String styles
  augend.constant.new {
    elements = { "'", '"', "`" },
    word = false,
    cyclic = true
  },

  -- Rails validations
  augend.constant.new {
    elements = {
      "validates",
      "validates_presence_of",
      "validates_uniqueness_of",
      "validates_format_of",
      "validates_length_of",
      "validates_numericality_of"
    },
    word = true,
    cyclic = true
  },

  -- Collection methods
  augend.constant.new {
    elements = { "map", "select", "reject", "filter", "detect", "find", "collect" },
    word = true,
    cyclic = true
  },

  -- Test methods
  augend.constant.new {
    elements = { "describe", "context", "it", "specify", "before", "after" },
    word = true,
    cyclic = true
  },
  
  -- Rails associations
  augend.constant.new {
    elements = { "has_one", "has_many", "belongs_to", "has_and_belongs_to_many" },
    word = true,
    cyclic = true
  },
  
  -- Rails callbacks
  augend.constant.new {
    elements = { 
      "before_save", "after_save", 
      "before_create", "after_create", 
      "before_update", "after_update", 
      "before_destroy", "after_destroy" 
    },
    word = true,
    cyclic = true
  },
  
  -- Rails HTTP methods
  augend.constant.new {
    elements = { "get", "post", "put", "patch", "delete" },
    word = true,
    cyclic = true
  },
  
  -- Ruby conditional statements
  augend.constant.new {
    elements = { "if", "unless", "case" },
    word = true,
    cyclic = true
  },
  
  -- Ruby iteration
  augend.constant.new {
    elements = { "each", "each_with_index", "each_with_object", "with_index", "with_object" },
    word = true,
    cyclic = true
  },
  
  -- Ruby modifiers
  augend.constant.new {
    elements = { "if", "unless", "while", "until" },
    word = true,
    cyclic = true
  },
  
  -- RSpec expectations
  augend.constant.new {
    elements = { 
      "to", "not_to", "to_not"
    },
    word = true,
    cyclic = true
  },
  
  -- RSpec matchers
  augend.constant.new {
    elements = { 
      "eq", "match", "include", "be_truthy", "be_falsey", "be_nil", "be_present", "be_blank"
    },
    word = true,
    cyclic = true
  },
  
  -- ActiveRecord query methods
  augend.constant.new {
    elements = { 
      "where", "find_by", "find", "first", "last", "limit", "order", "group"
    },
    word = true,
    cyclic = true
  },
  
  -- Rails controller filters
  augend.constant.new {
    elements = { 
      "before_action", "after_action", "around_action",
      "before_filter", "after_filter", "around_filter"
    },
    word = true,
    cyclic = true
  },
  
  -- Ruby Error Handling
  augend.constant.new {
    elements = { "begin", "rescue", "ensure" },
    word = true,
    cyclic = true
  },
  
  augend.constant.new {
    elements = { "raise", "fail", "throw", "catch" },
    word = true,
    cyclic = true
  },
  
  -- Ruby Attribute Accessors
  augend.constant.new {
    elements = { "attr_reader", "attr_writer", "attr_accessor" },
    word = true,
    cyclic = true
  },
  
  -- Rails Form Helpers
  augend.constant.new {
    elements = { "form_for", "form_with", "form_tag" },
    word = true,
    cyclic = true
  },
  
  -- Rails Response Types
  augend.constant.new {
    elements = { "render", "redirect_to", "head" },
    word = true,
    cyclic = true
  },
  
  -- ActiveJob Methods
  augend.constant.new {
    elements = { "perform_later", "perform_now" },
    word = true,
    cyclic = true
  },
  
  -- Rails Scope/Class Methods
  augend.constant.new {
    elements = { "scope", "class_method", "class << self" },
    word = true,
    cyclic = true
  },
  
  -- Rails Route Methods
  augend.constant.new {
    elements = { "resources", "resource", "member", "collection", "namespace" },
    word = true,
    cyclic = true
  },
  
  -- ActiveStorage Methods
  augend.constant.new {
    elements = { "has_one_attached", "has_many_attached" },
    word = true,
    cyclic = true
  },
  
  -- Ruby Class Inheritance
  augend.constant.new {
    elements = { "<", "prepend", "include", "extend" },
    word = false,
    cyclic = true
  },
  
  -- Ruby Module Functions
  augend.constant.new {
    elements = { "module_function", "extend self" },
    word = true,
    cyclic = true
  },
}
