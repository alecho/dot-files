return {
  'declancm/cinnamon.nvim',
  event = "BufRead",
  config = {
    keymaps = {
      basic = true,
      extra = true,
    },
    options = {
      max_delta = {
        line = 3000,
        column = false,
        time = 800,
      },
    }
  },
}
