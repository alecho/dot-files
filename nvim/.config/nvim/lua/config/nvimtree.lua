local M = {}

function M.setup()
  require("nvim-tree").setup {
    disable_netrw = true,
    hijack_netrw = true,
    sort_by = "name",
    view = {
      number = true,
      relativenumber = true,
    },
    filters = {
      custom = { ".git" },
    },
  }
end

return M
