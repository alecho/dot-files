return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    italic_comment = true,
    overrides = function(colors)
      return {
        IndentBlanklineChar = { fg = colors.nontext },

        -- Hop
        HopNextKey          = { fg = colors.orange, bold = true },
        HopNextKey1         = { fg = colors.purple, bold = true },
        HopNextKey2         = { fg = colors.bright_blue },

        -- Notify
        NotifyDEBUGBorder   = { fg = colors.yellow },
        NotifyDEBUGIcon     = { fg = colors.yellow },
        NotifyDEBUGTitle    = { fg = colors.yellow },
        NotifyERRORBorder   = { fg = colors.red },
        NotifyERRORIcon     = { fg = colors.red },
        NotifyERRORTitle    = { fg = colors.red },
        NotifyINFOBorder    = { fg = colors.purple },
        NotifyINFOIcon      = { fg = colors.purple },
        NotifyINFOTitle     = { fg = colors.purple },
        NotifyTRACEBorder   = { fg = colors.white },
        NotifyTRACEIcon     = { fg = colors.white },
        NotifyTRACETitle    = { fg = colors.white },
        NotifyWARNBorder    = { fg = colors.orange },
        NotifyWARNIcon      = { fg = colors.orange },
        NotifyWARNTitle     = { fg = colors.orange },

        -- Treesitter Context
        TreesitterContext = { bg = colors.menu },
        TreesitterContextLineNumber = { bg = colors.menu },
      }
    end,
  }
}
