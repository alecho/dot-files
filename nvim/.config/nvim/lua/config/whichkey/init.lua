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
    ["*"] = { "<Cmd>nohl<CR>", "Clear Highlight" },
    ["w"] = { "<Cmd>update!<CR>", "Save" },
    ["x"] = { "<Cmd>bd!<Cr>", "Close current buffer" },
    ["a"] = { "<Cmd>AerialToggle<CR>", "Aerial minimap" },
    ["co"] = { "<Cmd>Telescope persisted<CR>", "Switch Branch" },

    f = {
      name = "Find",
      f = { "<Cmd>FzfLua git_files<CR>", "Files" },
      a = { "<Cmd>FzfLua files<CR>", "All Files" },
      b = { "<Cmd>FzfLua buffers<CR>", "Buffers" },
      h = { "<Cmd>FzfLua oldfiles<CR>", "History" },
      g = { "<Cmd>FzfLua live_grep<CR>", "Live grep" },
      c = { "<Cmd>FzfLua commands<CR>", "Commands" },
      e = { "<Cmd>NvimTreeToggle<CR>", "Explorer" },
      s = { "<Cmd>Oil --float<CR>", "File System (Oil.nvim)" },
      w = { "<Cmd>FzfLua grep_cword<CR>", "Grep Current Word" },
    },

    g = {
      name = "Git",
      c = { "<Cmd>FzfLua git_commits<CR>", "Commits" },
      s = { "<Cmd>FzfLua git_status<CR>", "Status" },
      r = { "<Cmd>FzfLua git_branches<CR>", "Branches" },
      t = { "<Cmd>FzfLua git_stash<CR>", "Stash" },
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

    rn = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename (LSP)" },

    s = {
      name = "Session",
      l = { "<Cmd>Telescope persisted<CR>", "List" },
      s = { "<Cmd>SessionSave<CR>", "Save" },
      d = { "<Cmd>SessionDelete<CR>", "Delete" },
    },

    z = { "<Cmd>Lazy<CR>", "Lazy" },
  }

  -- Normal Mode

  whichkey.register(leader, opts.leader)

  -- vim.api.nvim_set_keymap('n', '<C-k>', '<C-u>', { noremap = true })
  -- vim.api.nvim_set_keymap('n', '<C-j>', '<C-d>', { noremap = true })
  vim.keymap.set({ 'n', 'x' }, '<C-k>', "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>")
  vim.keymap.set({ 'n', 'x' }, '<C-j>', "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>")
  local normal = {
    ["gx"] = { "<Cmd>lua require('open').open_cword()<CR>", "Open" },
    -- ["<C-b>"] = { "<Cmd>FzfLua buffers<CR>", "Buffer List" },
    ["<C-b>"] = { "<Cmd>BufferPick<CR>", "Buffer List" },
    ["<C-p>"] = { "<Cmd>FzfLua git_files<CR>", "Find files" },
    ["<C-x>"] = { "<Cmd>bd!<Cr>", "Close current buffer" },
    ["<C-u>"] = { '<Cmd>BufferPrevious<CR>', "Previous Buffer" },
    ["<C-i>"] = { '<Cmd>BufferNext<CR>', "Next Buffer" },
    ["<C-<>"] = { '<Cmd>BufferMovePrevious<CR>', "Move Buffer Left" },
    ["<C->>"] = { '<Cmd>BufferMoveNext<CR>', "Move Buffer Right" },
  }

  whichkey.register(normal, opts.nomal)

  local visual = {
    ['<leader>fv'] = { "<Cmd>FzfLua grep_visual<CR>", "Grep Visual Selection" },
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
