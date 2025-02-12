local ls = require("luasnip")
local s = ls.snippet                          -- snippet
local i = ls.insert_node                      -- insert node
local t = ls.text_node                        -- text node
local c = ls.choice_node                      -- choice node
local fmt = require("luasnip.extras.fmt").fmt -- formatter

-- Conventional commit types for choice nodes
local commit_types = {
  t("feat"),
  t("fix"),
  t("docs"),
  t("style"),
  t("refactor"),
  t("perf"),
  t("test"),
  t("chore"),
}

-- Add snippets for the 'gitcommit' filetype
ls.add_snippets("gitcommit", {
  -- A concise commit header snippet with a choice for commit type.
  s("cc", fmt("{}({}): {}", {
    c(1, commit_types), -- commit type (choice)
    i(2, "scope"),      -- scope (you can leave this empty)
    i(3, "subject"),    -- subject/description
  })),

  -- Alternatively, individual snippets for each type (optional)
  s("feat", fmt("feat({}): {}", { i(1, "scope"), i(2, "subject") })),
  s("fix", fmt("fix({}): {}", { i(1, "scope"), i(2, "subject") })),
  s("docs", fmt("docs({}): {}", { i(1, "scope"), i(2, "subject") })),
  s("style", fmt("style({}): {}", { i(1, "scope"), i(2, "subject") })),
  s("refactor", fmt("refactor({}): {}", { i(1, "scope"), i(2, "subject") })),
  s("perf", fmt("perf({}): {}", { i(1, "scope"), i(2, "subject") })),
  s("test", fmt("test({}): {}", { i(1, "scope"), i(2, "subject") })),
  s("chore", fmt("chore({}): {}", { i(1, "scope"), i(2, "subject") })),

  -- A full commit snippet with subject, body and breaking changes footer.
  s("ccfull", fmt([[
    {}({}): {}

    {}

    BREAKING CHANGE: {}
  ]], {
    c(1, commit_types), -- commit type (choice)
    i(2, "scope"),      -- scope
    i(3, "subject"),    -- subject/description
    i(4, "body"),       -- body text
    i(5, "footer"),     -- footer (e.g. breaking change explanation)
  })),
})
