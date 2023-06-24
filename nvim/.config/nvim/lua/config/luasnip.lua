local M = {}

function M.setup()
  local luasnip = require "LuaSnip"

  luasnip.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
  }

  require("luasnip/loaders/from_vscode").load()
end

return M
