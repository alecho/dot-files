local M = {}

function M.setup()
  local luasnip = require "LuaSnip"

  luasnip.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
  }

  luasnip.filetype_extend("all", { "_" })

  require("luasnip.loaders.from_snipmate").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })

  vim.keymap.set('n', '<leader>es', function()
    require("luasnip.loaders").edit_snippet_files {
      extend = function(ft)
        return {
          { "$CONFIG/" .. ft .. ".snippets",
            string.format("%s/%s.snippets", "~/.config/nvim/snippets", ft) }
        }
      end
    }
  end, { remap = true })
end

return M
