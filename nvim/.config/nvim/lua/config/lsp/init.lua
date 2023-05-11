local M = {}

local servers = {
  html = {},
  jsonls = {},
  lua_ls = {},
  tsserver = {},
  vimls = {},
}

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Format files on write with the LSP
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format { async = false }]]
  end

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

function M.setup()
  require 'lspconfig'.elixirls.setup {
    cmd = { "/Users/andrewlechowicz/.elixir-ls/release/language_server.sh" };
    on_attach = on_attach
  }

  require("config.lsp.installer").setup(servers, opts)
end

return M
