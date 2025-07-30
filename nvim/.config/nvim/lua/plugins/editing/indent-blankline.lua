-- Indentation
return {
  "lukas-reineke/indent-blankline.nvim",
  module = "ibl",
  event = "BufRead",
  config = function()
    local highlight = {
      "Operator",    -- fg purple
      "Keyword",     -- fg cyan
      "Conditional", -- fg pink
      "Float",       -- fg orange
      "Character",   -- fg green
      "Constant",    -- fg yellow
      "DiffDelete",  -- fg red
    }

    require("ibl").setup { scope = { highlight = highlight } }
  end,
}
