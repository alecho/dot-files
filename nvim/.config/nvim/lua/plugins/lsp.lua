return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = true, -- Automatically enable installed servers
      })
    end,
  },
  -- Note: Main LSP configuration is now in lsp-config.lua
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = "BufReadPre",
  --   config = function()
  --     -- Old reference to config.lsp removed
  --   end,
  -- },
  { "onsails/lspkind.nvim" },
}
