return {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason-lspconfig").setup({
      automatic_enable = true, -- Automatically enable installed servers
    })
  end,
}
