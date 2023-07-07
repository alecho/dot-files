return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {},
  event = 'BufWinEnter',
  keys = {
    { "<C-x>",      "<Cmd>BufferClose<CR>",               desc = "Close Buffer" },
    { "<C-b>",      "<Cmd>BufferPick<CR>",                desc = "Pick Buffer" },
    { "<C-m>",      "<Cmd>BufferPin<CR>",                 desc = "Pin/Unpin Buffer" },
    { "<C-,>",      "<Cmd>BufferPrevious<CR>",            desc = "Previous Buffer" },
    { "<C-.>",      '<Cmd>BufferNext<CR>',                desc = "Next Buffer" },
    { "<C-<>",      '<Cmd>BufferMovePrevious<CR>',        desc = "Previous Buffer" },
    { "<C->>",      '<Cmd>BufferMoveNext<CR>',            desc = "Next Buffer" },
    -- Sort automatically by...
    { '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', desc = "Order Buffers by Number" },
    { '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>',    desc = "Order Buffers by Directory" },
    { '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>',     desc = "Order Buffers by Language" },
    { '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', desc = "Order Buffers by Window Number" },
  },
  version = '^1.0.0',
}
