local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["a"] = { "<Cmd>AerialToggle<CR>", "Aerial minimap" },
    ["fml"] = { "<cmd>CellularAutomaton make_it_rain<CR>", "Make it Rain"},
    ["gol"] = { "<cmd>CellularAutomaton game_of_life<CR>", "Conway's Game of Life"},

    b = {
      name = "Buffer",
      -- Move to previous/next
      j = {"<Cmd>BufferPrevious<CR>", "Left"},
      k = {"<Cmd>BufferNext<CR>", "Right"},
      -- Re-order to previous/next
      J = {"<Cmd>BufferMovePrevious<CR>", "Move Left"},
      K = {"<Cmd>BufferMoveNext<CR>", "Move Right"},
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      f = { "<cmd>FzfLua buffers<cr>", "List" },
    },

    f = {
      name = "Find",
      f = { "<Cmd>lua require('utils.finder').find_files()<CR>", "Files" },
      b = { "<Cmd>FzfLua buffers<CR>", "Buffers" },
      h = { "<Cmd>FzfLua oldfiles<CR>", "History" },
      g = { "<Cmd>FzfLua live_grep<CR>", "Live grep" },
      c = { "<Cmd>FzfLua commands<CR>", "Commands" },
      e = { "<Cmd>NvimTreeToggle<CR>", "Explorer" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
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
      d = { "<Cmd>ZkNew { dir = 'daily' }<Cr>", "Edit the daily note" },
      n = { "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "Create a new note with title" },
      o = { "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "List notes"},
      y = { "<Cmd>ZkNew { dir = 'daily', date = 'yesterday' }<Cr>", "Edit yesterdays daily note" },
    },

    q = {
      name = "Shutdown",
      q = {
        name = "Are you sure you want to Quit?",
        q = { "<Cmd>q!<CR>", "Quit" },
      },
      b = {
        name = "Close which buffers?",
        w = { "<Cmd>BufferWipeout<CR>", "Wipeout buffer"},
        c = { "<Cmd>BufferCloseAllButCurrent<CR>", "All but Current"},
        p = { "<Cmd>BufferCloseAllButPinned<CR>", "All but Pinned"},
        P = { "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", "All but Pinned and Current"},
        l = { "<Cmd>BufferCloseBuffersLeft<CR>", "All on the Left"},
        r = { "<Cmd>BufferCloseBuffersRight<CR>", "All on the Right"},
      },
      s = { "<Cmd>SessionDelete<CR>", "Delete Session"},
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

  whichkey.setup(conf)
  whichkey.register(mappings, opts)

  local control_opts = {
    mode = "n", -- Normal mode
    prefix = nil,
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }
  local control_mappings = {
    ["<C-b>"] = { "<Cmd>FzfLua buffers<CR>", "Buffer List" },
    ["<C-p>"] = { "<Cmd>lua require('utils.finder').find_files()<CR>", "Find files" },
    ["<C-x>"] = { "<Cmd>bd!<Cr>", "Close current buffer" },
    ["<C-j"] = {'<Cmd>BufferPrevious<CR>', "Previous Buffer"},
    ["<C-k"] = {'<Cmd>BufferNext<CR>', "Next Buffer"},
  }
  whichkey.register(control_mappings, control_opts)

  local insert_opts = {
    mode = "i", -- Insert mode
    prefix = nil,
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  }
  local insert_mappings = {
    ["<C-g>"] = { "<Cmd>call codeium#Accept()<CR>", "Accept Codium completion" },
    ["<C-;>"] = { "<Cmd>call codeium#CycleCompletions(1)<CR>", "Next Codium completion" },
    ["<C-'>"] = { "<Cmd>call codeium#CycleCompletions(-1)<Cr>", "Previous Codium completion" },
    ["<C-x>"] = { "<Cmd>call codeium#Clear()<Cr>", "Clear Codium completion" },
  }

  whichkey.register(insert_mappings, insert_opts)
end

return M
