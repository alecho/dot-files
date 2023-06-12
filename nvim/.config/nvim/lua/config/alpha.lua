local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

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
    dashboard.button("f", "  Find file", ":lua require('utils.finder').find_files()<cr>"),
    dashboard.button("h", "  Recent files", ":FzfLua oldfiles<cr>"),
    dashboard.button("n", "  Notes", ":ZkNotes"),
    dashboard.button("N", "  New Note", ":ZkNew"),
    dashboard.button("p", "  Plugins", ":e ~/.config/nvim/lua/plugins.lua<CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    -- Number of plugins
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y  %H:%M:%S"
    local plugins_text = "\t" .. total_plugins .. " plugins  " .. datetime

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

  alpha.setup(dashboard.opts)
end

return M
