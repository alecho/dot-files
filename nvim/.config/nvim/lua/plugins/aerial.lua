return {
  -- Aerial
  {
    'stevearc/aerial.nvim',
    cmd = 'AerialToggle',
    opts = {
      backends = { "treesitter", "lsp", "markdown", "man" },
    }
  }
}
