return {
  "elentok/open-link.nvim",
  -- Use a simple mapping to open the thing under the cursor
  keys = {
    { "gx", "<cmd>OpenLink<CR>", desc = "Open link/ticket under cursor" },
  },
  -- Lazy-load on command too
  cmd = { "OpenLink", "PasteImage" },

  -- Configure expanders for Linear (SPHY-1234), GitHub repos, and GitHub issues/PRs
  init = function()
    require("open-link").setup({
      expanders = {
        -- 1) Linear ticket IDs: SPHY-1234 / sphy-1234 -> https://linear.app/simpliphy/issue/SPHY-1234
        function(text)
          local num = text:match("[sS][pP][hH][yY]%-([0-9]+)")
          if num then
            return ("https://linear.app/simpliphy/issue/SPHY-%s"):format(num)
          end
        end,

        -- 2) GitHub repos: owner/repo -> https://github.com/owner/repo
        function(text)
          local owner, repo = text:match("^([%w-_.]+)/([%w-_.]+)$")
          if owner and repo then
            return ("https://github.com/%s/%s"):format(owner, repo)
          end
        end,

        -- 3) GitHub issues/PRs: owner/repo#123 -> https://github.com/owner/repo/issues/123
        function(text)
          local owner, repo, num = text:match("^([%w-_.]+)/([%w-_.]+)#(%d+)$")
          if owner and repo and num then
            return ("https://github.com/%s/%s/issues/%s"):format(owner, repo, num)
          end
        end,

        -- You can add more expanders here as needed
      },
    })
  end,
}
