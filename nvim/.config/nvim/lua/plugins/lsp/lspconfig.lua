return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

    -- LspAttach autocmd replaces on_attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        if client and client.server_capabilities.documentFormattingProvider then
          vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, opts)
        vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, opts)
      end,
    })

    -- Helper function to determine ruby-lsp command based on project structure
    local function get_ruby_lsp_cmd(root_dir)
      local ruby_lsp_binstub = root_dir .. "/bin/ruby-lsp"
      local bundle_binstub = root_dir .. "/bin/bundle"
      if vim.fn.executable(ruby_lsp_binstub) == 1 then
        return { ruby_lsp_binstub }
      end
      local has_gemfile = vim.fn.filereadable(root_dir .. "/Gemfile") == 1
      local gemfile_includes_ruby_lsp = false
      if has_gemfile then
        local ok, lines = pcall(vim.fn.readfile, root_dir .. "/Gemfile")
        if ok and type(lines) == "table" then
          for _, line in ipairs(lines) do
            if line:match("ruby%-lsp") then
              gemfile_includes_ruby_lsp = true
              break
            end
          end
        end
      end
      if gemfile_includes_ruby_lsp then
        if vim.fn.executable(bundle_binstub) == 1 then
          return { bundle_binstub, "exec", "ruby-lsp" }
        end
        return { "/opt/homebrew/bin/mise", "-C", root_dir, "exec", "--", "ruby", "-S", "bundle", "exec", "ruby-lsp" }
      end
      return { "/opt/homebrew/bin/mise", "-C", root_dir, "exec", "--", "ruby-lsp" }
    end

    -- Use vim.lsp.config for Neovim 0.11+ native LSP configuration
    vim.lsp.config("ruby_lsp", {
      cmd = function(dispatchers)
        local root_dir = vim.fn.getcwd()
        return vim.lsp.rpc.start(get_ruby_lsp_cmd(root_dir), dispatchers, {
          cwd = root_dir,
        })
      end,
      root_markers = { "Gemfile", "Gemfile.lock", ".ruby-version", ".git", ".tool-versions", "mise.toml", ".mise.toml" },
      filetypes = { "ruby", "eruby" },
      single_file_support = false,
      capabilities = capabilities,
    })

    vim.lsp.enable("ruby_lsp")
  end,
}
