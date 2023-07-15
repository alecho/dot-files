return {
  -- Movement
  {
    'smoka7/hop.nvim',
    lazy = false,
    version = '*',
    config = function()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      hop.setup { create_hl_autocmd = false }
      vim.keymap.set('', 'f', function()
        hop.hint_char1({
          direction = directions.AFTER_CURSOR,
          current_line_only = true
        })
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({
          direction = directions.BEFORE_CURSOR,
          current_line_only = true
        })
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1({
          direction = directions.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1
        })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.int_char1({
          direction = directions.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = 1
        })
      end, { remap = true })
      vim.keymap.set('', 'gw', hop.hint_words, { remap = true })
      vim.keymap.set('', '<leader>h', hop.hint_words, { remap = true, desc = "Hop to a word" })
      vim.keymap.set('', '\\', hop.hint_patterns, { remap = true })
      vim.keymap.set('', '<leader>p', hop.hint_patterns, { remap = true, desc = "Hop to a pattern" })
    end
  },

  -- Smooth scrolling
  {
    'declancm/cinnamon.nvim',
    event = 'BufRead',
    opts = {
      extra_keymaps = true,
      max_length = 400,
      scroll_limit = 3000,
    },
  },

}
