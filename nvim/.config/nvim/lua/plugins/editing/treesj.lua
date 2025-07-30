-- Code toggle (split and join)
return {
  'Wansmer/treesj',
  event = 'BufRead',
  dependencies = { 'nvim-treesitter' },
  opts = {
    use_default_keymaps = false
  },
}
