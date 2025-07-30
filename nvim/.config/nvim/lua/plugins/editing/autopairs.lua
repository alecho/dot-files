-- Auto pairs
return {
  "windwp/nvim-autopairs",
  module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
  event = "InsertEnter",
  config = function()
    local np = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    np.setup({
      check_ts = true
    })

    np.add_rules({
      Rule("*", "*", { "markdown" }):with_pair(cond.not_before_regex("\n")),
      Rule("_", "_", { "markdown" }):with_pair(cond.before_regex("%s")),
    })
    np.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
    np.add_rules(require('nvim-autopairs.rules.endwise-lua'))
    np.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
  end,
}
