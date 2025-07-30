return {
  {
    'ellisonleao/glow.nvim',
    cmd = "Glow",
    opts = {},
  },
  {
    'jakewvincent/mkdnflow.nvim',
    cmd = "MkdnTableFormat",
    opts = {
      modules = {
        bib = false,
        buffers = false,
        conceal = false,
        cursor = false,
        folds = false,
        links = false,
        lists = false,
        maps = false,
        paths = false,
        tables = true,
        yaml = false,
        cmp = false
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
