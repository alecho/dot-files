return {
  {
    'codota/tabnine-nvim',
    event = 'BufRead',
    build = "./dl_binaries.sh",
    cond = not vim.g.started_by_firenvim,
    config = function()
      require('tabnine').setup({
        disable_auto_comment = true,
        accept_keymap = false,
        dismiss_keymap = false,
        debounce_ms = 500,
        suggestion_color = { gui = "#6272A4" },
        exclude_filetypes = {
          "TelescopePrompt",
          "NvimTree",
          "Alpha",
          "Ariel",
        },
        log_file_path = nil, -- absolute path to Tabnine log file
      })
    end,
  },
}
