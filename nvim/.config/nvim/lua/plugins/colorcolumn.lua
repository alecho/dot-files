return {
  'Bekaboo/deadcolumn.nvim',
  event = 'BufRead',
  opts = {
    scope = 'visible',
    modes = { 'i', 'ic', 'ix', 'R', 'Rc', 'Rx', 'Rv', 'Rvc', 'Rvx' },
    warning = {
      alpha = 0.6,
      colorcode = '#ff5555',
    },
  }
}
