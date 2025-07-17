local M = {}

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.server_capabilities.documentFormattingProvider then
    -- Use LSP as the handler for formatexpr.
    -- See `:help formatexpr` for more information.
    vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    -- Format files on write with the LSP
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format { async = false }]]
  end

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Tell language servers that we understand folding
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    eslint = {
      autoFixOnSave = true,
      format = { enable = true },
    },
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

function M.setup()
  -- Configure LSP servers
  local servers = require("mason-lspconfig").get_installed_servers()
  for _, server_name in ipairs(servers) do
    require("lspconfig")[server_name].setup(opts)
  end
end

return M
