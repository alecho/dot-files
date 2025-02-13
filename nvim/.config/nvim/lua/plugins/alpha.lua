local function datetime()
  return os.date "\n %d-%m-%Y  %H:%M:%S"
end

return {
  'goolord/alpha-nvim',
  event = "VimEnter",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local elixir = {
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣳⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠠⣽⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⡐⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⣐⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⣔⣎⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣭⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⣘⢶⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣻⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⣰⡏⣎⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡗⢄⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⢰⣯⣟⢣⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⡢⣠⡀⠀⠀⠀⠀⠀⠀]],
      [[⠀⢀⣿⣳⣿⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣮⡺⢄⠀⠀⠀⠀⠀]],
      [[⠀⣼⣿⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⡀⠀⠀⠀]],
      [[⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⠀⠀⠀]],
      [[⣸⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀]],
      [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀]],
      [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇]],
      [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗]],
      [[⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇]],
      [[⢸⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀]],
      [[⠀⢿⣿⣽⣻⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣟⡿⣽⢻⣞⡷⡏⠀]],
      [[⠀⠈⢿⣟⣯⣿⣳⣯⢿⡽⣞⡷⣏⣾⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣜⣳⢯⡟⡾⡝⠀⠀]],
      [[⠀⠀⠀⠻⣯⣷⣟⣾⣯⢟⡽⣺⢵⣫⢗⡮⣽⢻⣿⡿⣿⣻⣿⢿⡽⣯⣟⣯⢿⠏⠀⠀⠀]],
      [[⠀⠀⠀⠀⠘⠿⣞⣿⣾⢯⣳⢏⣾⡱⣏⢾⡱⣏⢾⣹⣿⣿⢯⣛⢾⡳⣞⠍⠁⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠈⠛⠾⣟⣧⡛⠒⠻⠜⣧⢻⣼⣳⡿⠋⢀⠢⣉⠫⠑⠁⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠓⠒⠒⠛⠛⠃⠁⠀⠐⠂⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    }

    local dashboard = require "alpha.themes.dashboard"
    local function header()
      return {
        [[                    1111111    333333333333333                    ]],
        [[                   1::::::1   3:::::::::::::::33                  ]],
        [[                  1:::::::1   3::::::33333::::::3                 ]],
        [[                  111:::::1   3333333     3:::::3                 ]],
        [[  aaaaaaaaaaaaa      1::::1               3:::::3zzzzzzzzzzzzzzzzz]],
        [[  a::::::::::::a     1::::1               3:::::3z:::::::::::::::z]],
        [[  aaaaaaaaa:::::a    1::::1       33333333:::::3 z::::::::::::::z ]],
        [[           a::::a    1::::l       3:::::::::::3  zzzzzzzz::::::z  ]],
        [[    aaaaaaa:::::a    1::::l       33333333:::::3       z::::::z   ]],
        [[  aa::::::::::::a    1::::l               3:::::3     z::::::z    ]],
        [[ a::::aaaa::::::a    1::::l               3:::::3    z::::::z     ]],
        [[a::::a    a:::::a    1::::l               3:::::3   z::::::z      ]],
        [[a::::a    a:::::a 111::::::1113333333     3:::::3  z::::::zzzzzzzz]],
        [[a:::::aaaa::::::a 1::::::::::13::::::33333::::::3 z::::::::::::::z]],
        [[ a::::::::::aa:::a1::::::::::13:::::::::::::::33 z:::::::::::::::z]],
        [[  aaaaaaaaaa  aaaa111111111111 333333333333333   zzzzzzzzzzzzzzzzz]],
      }
    end

    dashboard.section.header.val = header()

    dashboard.section.buttons.val = {
      dashboard.button("s", "󰍉  Sessions", ":Telescope persisted<CR>"),
      dashboard.button("f", "󰍉  Find file", ":lua require('utils.finder').find_files()<CR>"),
      dashboard.button("g", "󰱼  Find in files", ":FzfLua live_grep<CR>"),
      dashboard.button("h", "󰋚  Recent files", ":FzfLua oldfiles<CR>"),
      dashboard.button("n", "  Notes", ":ZkNotes"),
      dashboard.button("N", "  New Note", ":ZkNew"),
      dashboard.button("p", "  Plugins", ":Oil ~/.config/nvim/lua/plugins<CR>"),
      dashboard.button("q", "󰐥  Quit Neovim", ":qa<CR>"),
    }

    local function footer()
      -- Number of plugins
      local stats = require("lazy").stats()
      local plugins_text = "\t" .. stats.count .. " plugins " .. datetime()

      -- Quote
      local fortune = require "alpha.fortune"
      local quote = table.concat(fortune(), "\n")

      return plugins_text .. "\n" .. quote
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Constant"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Function"
    dashboard.section.buttons.opts.hl_shortcut = "Type"
    dashboard.opts.opts.noautocmd = true

    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms" .. datetime()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
