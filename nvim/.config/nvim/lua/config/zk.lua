local M = {}

function M.setup()
  require("zk").setup({
    -- can be "telescope"", "fzf" or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope" or "fzf"
    picker = "telescope",
  })
end

return M
