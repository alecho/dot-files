return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

    local function on_attach(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
        vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format { async = false }]]
      end
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR}) end, opts)
      vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}) end, opts)
    end

    lspconfig.ruby_lsp.setup({
      cmd = { "/opt/homebrew/bin/mise", "-C", vim.loop.cwd(), "exec", "--", "ruby-lsp" },
      root_dir = util.root_pattern("Gemfile", "Gemfile.lock", ".ruby-version", ".git", ".tool-versions", "mise.toml", ".mise.toml"),
      single_file_support = false,
      on_attach = on_attach,
      capabilities = capabilities,
      on_new_config = function(new_config, new_root_dir)
        new_config.cmd_cwd = new_root_dir
        local ruby_lsp_binstub = new_root_dir .. "/bin/ruby-lsp"
        local bundle_binstub = new_root_dir .. "/bin/bundle"
        if vim.fn.executable(ruby_lsp_binstub) == 1 then
          new_config.cmd = { ruby_lsp_binstub }
          return
        end
        local has_gemfile = vim.fn.filereadable(new_root_dir .. "/Gemfile") == 1
        local gemfile_includes_ruby_lsp = false
        if has_gemfile then
          local ok, lines = pcall(vim.fn.readfile, new_root_dir .. "/Gemfile")
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
            new_config.cmd = { bundle_binstub, "exec", "ruby-lsp" }
            return
          end
          new_config.cmd = { "/opt/homebrew/bin/mise", "-C", new_root_dir, "exec", "--", "ruby", "-S", "bundle", "exec", "ruby-lsp" }
          return
        end
        new_config.cmd = { "/opt/homebrew/bin/mise", "-C", new_root_dir, "exec", "--", "ruby-lsp" }
      end,
    })
  end,
}
