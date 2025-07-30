-- Text case conversion
return {
  'johmsalas/text-case.nvim',
  event = "BufRead",
  config = function()
    require('textcase').setup {}
    require('telescope').load_extension('textcase')
    vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Change case" })
    vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Change case" })
  end
}
