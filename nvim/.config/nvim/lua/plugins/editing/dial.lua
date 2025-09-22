local inc_keymap = "<C-=>"
local dec_keymap = "<C-->"

return {
  "monaqa/dial.nvim",
  lazy = false,
  config = function()
    local config = require("dial.config")

    vim.keymap.set("n", inc_keymap, require("dial.map").inc_normal(), { noremap = true })
    vim.keymap.set("n", dec_keymap, require("dial.map").dec_normal(), { noremap = true })

    -- Register default augend group
    config.augends:register_group {
      default = require("plugins.editing.dial.default")
    }

    -- Load filetype-specific augends
    local filetype_augends = {
      ruby = require("plugins.editing.dial.ruby"),
      markdown = require("plugins.editing.dial.markdown"),
      elixir = require("plugins.editing.dial.elixir"),
      gitrebase = require("plugins.editing.dial.gitrebase"),
      javascript = require("plugins.editing.dial.javascript"),
      vue = require("plugins.editing.dial.vue"),
    }

    -- Register filetype augends
    config.augends:on_filetype(filetype_augends)

    -- Custom file pattern augends
    local file_pattern_augends = {
      -- Cypress test files
      ["%.cy%.js$"] = { 
        base_filetype = "javascript", -- Inherit javascript augends
        additional = require("plugins.editing.dial.cypress")
      },
      -- Add more file patterns as needed
      -- Example: ["%.spec%.ts$"] = { base_filetype = "typescript", additional = require("plugins.editing.dial.jest") }
    }

    -- Function to apply augends based on filename patterns
    local function setup_filename_augends()
      local current_buf = vim.api.nvim_get_current_buf()
      local filename = vim.api.nvim_buf_get_name(current_buf)
      
      if filename == "" then
        return
      end
      
      -- Check if file matches any of our patterns
      for pattern, augend_config in pairs(file_pattern_augends) do
        if filename:match(pattern) then
          local augends_to_apply = {}
          
          -- Include base filetype augends if specified
          if augend_config.base_filetype and filetype_augends[augend_config.base_filetype] then
            for _, augend_item in ipairs(filetype_augends[augend_config.base_filetype]) do
              table.insert(augends_to_apply, augend_item)
            end
          end
          
          -- Add the additional augends
          if augend_config.additional then
            for _, augend_item in ipairs(augend_config.additional) do
              table.insert(augends_to_apply, augend_item)
            end
          end
          
          -- Apply the combined augends to this buffer explicitly
          vim.b.dial_config = {
            augends = augends_to_apply,
          }
          
          break
        end
      end
    end

    -- Set up autocmds to detect file patterns and apply custom augends
    local augroup = vim.api.nvim_create_augroup("DialFilePatterns", { clear = true })
    vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
      group = augroup,
      callback = setup_filename_augends
    })

    -- Apply to current buffer if it's already loaded
    setup_filename_augends()
  end,
  keys = { inc_keymap, dec_keymap },
}
