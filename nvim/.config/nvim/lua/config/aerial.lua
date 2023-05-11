local M = {}

function M.setup()
  require("aerial").setup {
    backends = { "treesitter", "lsp", "markdown", "man" },
  }
end

return M
