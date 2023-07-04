local M = {}

function M.setup()
  local whichkey = require "which-key"
  local opts = require "config.whichkey.opts"

  whichkey.setup({
    window = {
      border = "single",   -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  })

  -- Normal mode with leader key

  local leader = {
    [" "] = { "<Cmd>Legendary<CR>", "Legendary" },
    ["w"] = { "<Cmd>update!<CR>", "Save" },
    ["a"] = { "<Cmd>AerialToggle<CR>", "Aerial minimap" },
    ["fml"] = { "<cmd>CellularAutomaton make_it_rain<CR>", "Make it Rain" },
    ["gol"] = { "<cmd>CellularAutomaton game_of_life<CR>", "Conway's Game of Life" },

    f = {
      name = "Find",
      f = { "<Cmd>FzfLua git_files<CR>", "Files" },
      a = { "<Cmd>FzfLua files<CR>", "All Files" },
      b = { "<Cmd>FzfLua buffers<CR>", "Buffers" },
      h = { "<Cmd>FzfLua oldfiles<CR>", "History" },
      g = { "<Cmd>FzfLua live_grep<CR>", "Live grep" },
      c = { "<Cmd>FzfLua commands<CR>", "Commands" },
      p = { "<Cmd>lua require('utils.finder').find_files()<CR>", "Files (find_files())" },
      e = { "<Cmd>NvimTreeToggle<CR>", "Explorer" },
    },

    g = {
      name = "Git",
      c = { "<cmd>FzfLua git_commits<CR>", "Commits" },
      s = { "<cmd>FzfLua git_status<CR>", "Status" },
      r = { "<cmd>FzfLua git_branches<CR>", "Branches" },
      t = { "<cmd>FzfLua git_stash<CR>", "Stash" },
      b = {
        name = "Blame",
        t = { "<cmd>GitBlameToggle<CR>", "Toggle" },
        c = { "<cmd>GitBlameCopySHA<CR>", "Copy SHA" },
      },
      h = {
        name = "GitHub",
        s = { "<cmd>Octo pr search<CR>", "Search PRs" },
        l = { "<cmd>Octo pr list<CR>", "List PRs" },
        n = { "<cmd>Octo pr create<CR>", "Create PR from current branch" },
        o = { "<cmd>Octo pr checkout<CR>", "Checkout PR" },
        h = { "<cmd>Octo actions<CR>", "List all Octo Actions" },

      }
    },

    n = {
      name = "Notes",
      d = { "<Cmd>ZkNew { dir = 'daily' }<CR>", "Edit the daily note" },
      n = { "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "New with Title" },
      o = { "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "List notes" },
      y = { "<Cmd>ZkNew { dir = 'daily', date = 'yesterday' }<CR>", "Edit yesterday's daily note" },
      t = { "<Cmd>ZkNew { dir = 'daily', date = 'tomorrow' }<CR>", "Edit tomorrow's daily note" },
      l = { "<Cmd>ZkInsertLink<CR>", "Insert Link" },
    },

    q = {
      name = "Shutdown",
      q = {
        name = "Are you sure you want to Quit?",
        q = { "<Cmd>q!<CR>", "Quit" },
      },
      b = {
        name = "Close which buffers?",
        w = { "<Cmd>BufferWipeout<CR>", "Wipeout buffer" },
        c = { "<Cmd>BufferCloseAllButCurrent<CR>", "All but Current" },
        p = { "<Cmd>BufferCloseAllButPinned<CR>", "All but Pinned" },
        P = { "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", "All but Pinned and Current" },
        l = { "<Cmd>BufferCloseBuffersLeft<CR>", "All on the Left" },
        r = { "<Cmd>BufferCloseBuffersRight<CR>", "All on the Right" },
      },
      s = { "<Cmd>SessionDelete<CR>", "Delete Session" },
    },

    z = {
      name = "Packer",
      c = { "<Cmd>PackerCompile<cr>", "Compile" },
      i = { "<Cmd>PackerInstall<cr>", "Install" },
      p = { "<Cmd>PackerProfile<cr>", "Profile" },
      s = { "<Cmd>PackerSync<cr>", "Sync" },
      S = { "<Cmd>PackerStatus<cr>", "Status" },
      u = { "<Cmd>PackerUpdate<cr>", "Update" },
    },
  }

  -- Normal Mode

  whichkey.register(leader, opts.leader)

  local normal = {
    ["<C-b>"] = { "<Cmd>FzfLua buffers<CR>", "Buffer List" },
    ["<C-p>"] = { "<Cmd>FzfLua git_files<CR>", "Find files" },
    ["<C-x>"] = { "<Cmd>bd!<Cr>", "Close current buffer" },
    ["<C-,>"] = { '<Cmd>BufferPrevious<CR>', "Previous Buffer" },
    ["<C-.>"] = { '<Cmd>BufferNext<CR>', "Next Buffer" },
    ["<C-<>"] = { '<Cmd>BufferMovePrevious<CR>', "Previous Buffer" },
    ["<C->>"] = { '<Cmd>BufferMoveNext<CR>', "Next Buffer" },
  }

  whichkey.register(normal, opts.nomal)

  local visual = {
    n = {
      name = "New Note with",
      t = { "<Cmd>'<,'>ZkNewFromTitleSelection<CR>", "Title from selection" },
      c = { "<Cmd>'<,'>ZkNewFromContentSelection<CR>", "Content from selection" },
      s = { "<Cmd>'<,'>ZkMatch<CR>", "Search" },
    },
  }

  whichkey.register(visual, opts.visual)
end

return M
