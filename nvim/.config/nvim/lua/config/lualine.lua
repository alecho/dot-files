local M = {}

function M.setup()
  require('lualine').setup {
  options = {
      theme = "dracula-nvim",
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
    }
  }
end

return M
