return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require "luasnip"

      luasnip.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
      }

      luasnip.filetype_extend("all", { "_" })
      luasnip.filetype_extend("ruby", { "rails" })

      require("luasnip.loaders.from_snipmate").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load()

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
      vim.keymap.set('n', '<leader>rs', '<Cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<CR>', { remap = true })
    end,
  }
}
