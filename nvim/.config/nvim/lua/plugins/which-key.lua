return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require "which-key"
    local keymap = vim.api.nvim_set_keymap

    wk.setup({
      win = {
        border = "single", -- none, single, double, shadow
        wo = {
          winblend = 10,
        }
      },
    })

    keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
    keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
    keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>",
      { noremap = true, silent = true })
    keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>",
      { noremap = true, silent = true })

    -- Normal mode with leader key

    local leader =
    {
      {
        "<leader>*",
        "<Cmd>nohl<CR>",
        desc = "Clear Highlight",
        nowait = false,
        remap = false
      },
      {
        "<leader>a",
        "<Cmd>AerialToggle<CR>",
        desc = "Aerial minimap",
        nowait = false,
        remap = false
      },
      {
        "<leader>co",
        "<Cmd>Telescope persisted<CR>",
        desc = "Switch Branch",
        nowait = false,
        remap = false
      },
      { "<leader>f",  group = "Find",  nowait = false, remap = false },
      {
        "<leader>fd",
        "<Cmd>FzfLua live_grep<CR>",
        desc = "Live grep",
        nowait = false,
        remap = false
      },
      {
        "<leader>fe",
        "<Cmd>Oil --float<CR>",
        desc = "File System (Oil.nvim)",
        nowait = false,
        remap = false
      },
      {
        "<leader>ff",
        "<Cmd>FzfLua git_files<CR>",
        desc = "Files",
        nowait = false,
        remap = false
      },
      {
        "<leader>fh",
        "<Cmd>FzfLua oldfiles<CR>",
        desc = "History",
        nowait = false,
        remap = false
      },
      {
        "<leader>fk",
        "<Cmd>FzfLua buffers<CR>",
        desc = "Buffers",
        nowait = false,
        remap = false
      },
      {
        "<leader>fl",
        "<Cmd>FzfLua files<CR>",
        desc = "All Files",
        nowait = false,
        remap = false
      },
      {
        "<leader>fp",
        "<Cmd>FzfLua commands<CR>",
        desc = "Commands",
        nowait = false,
        remap = false
      },
      {
        "<leader>fs",
        "<Cmd>Oil --float<CR>",
        desc = "File System (Oil.nvim)",
        nowait = false,
        remap = false
      },
      {
        "<leader>fw",
        "<Cmd>FzfLua grep_cword<CR>",
        desc = "Grep Current Word",
        nowait = false,
        remap = false
      },
      { "<leader>g",  group = "Git",   nowait = false, remap = false },
      { "<leader>gb", group = "Blame", nowait = false, remap = false },
      {
        "<leader>gbc",
        "<cmd>GitBlameCopySHA<CR>",
        desc = "Copy SHA",
        nowait = false,
        remap = false
      },
      {
        "<leader>gbt",
        "<cmd>GitBlameToggle<CR>",
        desc = "Toggle",
        nowait = false,
        remap = false
      },
      {
        "<leader>gc",
        "<Cmd>FzfLua git_commits<CR>",
        desc = "Commits",
        nowait = false,
        remap = false
      },
      { "<leader>gh", group = "GitHub", nowait = false, remap = false },
      {
        "<leader>ghh",
        "<cmd>Octo actions<CR>",
        desc = "List all Octo Actions",
        nowait = false,
        remap = false
      },
      {
        "<leader>ghl",
        "<cmd>Octo pr list<CR>",
        desc = "List PRs",
        nowait = false,
        remap = false
      },
      {
        "<leader>ghn",
        "<cmd>Octo pr create<CR>",
        desc = "Create PR from current branch",
        nowait = false,
        remap = false
      },
      {
        "<leader>gho",
        "<cmd>Octo pr checkout<CR>",
        desc = "Checkout PR",
        nowait = false,
        remap = false
      },
      {
        "<leader>ghs",
        "<cmd>Octo pr search<CR>",
        desc = "Search PRs",
        nowait = false,
        remap = false
      },
      {
        "<leader>gr",
        "<Cmd>FzfLua git_branches<CR>",
        desc = "Branches",
        nowait = false,
        remap = false
      },
      {
        "<leader>gs",
        "<Cmd>FzfLua git_status<CR>",
        desc = "Status",
        nowait = false,
        remap = false
      },
      {
        "<leader>gt",
        "<Cmd>FzfLua git_stash<CR>",
        desc = "Stash",
        nowait = false,
        remap = false
      },
      {
        '<leader>m', '<cmd>TSJToggle<CR>', { desc = "Split/Join", noremap = true }
      },
      { "<leader>l",  group = "Code",   nowait = false, remap = false },
      {
        "<leader>lR",
        "<cmd>Trouble lsp_references<cr>",
        desc = "Trouble References",
        nowait = false,
        remap = false
      },
      {
        "<leader>la",
        "<cmd>Telescope lsp_code_actions<CR>",
        desc = "Code Action",
        nowait = false,
        remap = false
      },
      {
        "<leader>lc",
        "<cmd>Telescope lsp_references<CR>",
        desc = "Diagnostics",
        nowait = false,
        remap = false
      },
      {
        "<leader>ld",
        "<cmd>Telescope diagnostics<CR>",
        desc = "Diagnostics",
        nowait = false,
        remap = false
      },
      {
        "<leader>li",
        "<cmd>LspInfo<CR>",
        desc = "Lsp Info",
        nowait = false,
        remap = false
      },
      {
        "<leader>ln",
        "<cmd>Lspsaga rename<CR>",
        desc = "Rename",
        nowait = false,
        remap = false
      },
      {
        "<leader>lr",
        "<Cmd>lua vim.lsp.buf.rename()<CR>",
        desc = "Rename (LSP)",
        nowait = false,
        remap = false
      },
      {
        "<leader>lt",
        "<cmd>TroubleToggle<CR>",
        desc = "Trouble",
        nowait = false,
        remap = false
      },
      { "<leader>n", group = "Notes",   nowait = false, remap = false },
      {
        "<leader>nb",
        "<Cmd>ZkBackLinks<CR>",
        desc = "List Backlinks",
        nowait = false,
        remap = false
      },
      {
        "<leader>nd",
        "<Cmd>ZkNew { dir = 'daily' }<CR>",
        desc = "Edit the daily note",
        nowait = false,
        remap = false
      },
      {
        "<leader>nf",
        "<Cmd>ZkLinks<CR>",
        desc = "List Outbound links",
        nowait = false,
        remap = false
      },
      {
        "<leader>ni",
        "<Cmd>ZkIndex<CR>",
        desc = "Index the notebook",
        nowait = false,
        remap = false
      },
      {
        "<leader>nl",
        "<Cmd>ZkInsertLink<CR>",
        desc = "Insert Link",
        nowait = false,
        remap = false
      },
      {
        "<leader>nn",
        "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
        desc = "New with Title",
        nowait = false,
        remap = false
      },
      {
        "<leader>no",
        "<Cmd>ZkNotes { sort = { 'modified' } }<CR>",
        desc = "List notes",
        nowait = false,
        remap = false
      },
      {
        "<leader>nt",
        "<Cmd>ZkNew { dir = 'daily', date = 'tomorrow' }<CR>",
        desc = "Edit tomorrow's daily note",
        nowait = false,
        remap = false
      },
      {
        "<leader>ny",
        "<Cmd>ZkNew { dir = 'daily', date = 'yesterday' }<CR>",
        desc = "Edit yesterday's daily note",
        nowait = false,
        remap = false
      },
      {
        "<leader>qP",
        "<Cmd>BufferCloseAllButCurrentOrPinned<CR>",
        desc = "All but Pinned and Current",
        nowait = false,
        remap = false
      },
      {
        "<leader>qc",
        "<Cmd>BufferCloseAllButCurrent<CR>",
        desc = "All but Current",
        nowait = false,
        remap = false
      },
      {
        "<leader>ql",
        "<Cmd>BufferCloseBuffersLeft<CR>",
        desc = "All on the Left",
        nowait = false,
        remap = false
      },
      {
        "<leader>qp",
        "<Cmd>BufferCloseAllButPinned<CR>",
        desc = "All but Pinned",
        nowait = false,
        remap = false
      },
      {
        "<leader>qr",
        "<Cmd>BufferCloseBuffersRight<CR>",
        desc = "All on the Right",
        nowait = false,
        remap = false
      },
      {
        "<leader>qs",
        "<Cmd>SessionDelete<CR>",
        desc = "Delete Session",
        nowait = false,
        remap = false
      },
      {
        "<leader>qw",
        "<Cmd>BufferWipeout<CR>",
        desc = "Wipeout buffer",
        nowait = false,
        remap = false
      },
      { "<leader>s", group = "Session", nowait = false, remap = false },
      {
        "<leader>sd",
        "<Cmd>SessionDelete<CR>",
        desc = "Delete",
        nowait = false,
        remap = false
      },
      {
        "<leader>sl",
        "<Cmd>Telescope persisted<CR>",
        desc = "List",
        nowait = false,
        remap = false
      },
      {
        "<leader>ss",
        "<Cmd>SessionSave<CR>",
        desc = "Save",
        nowait = false,
        remap = false
      },
      {
        "<leader>w",
        "<Cmd>update!<CR>",
        desc = "Save",
        nowait = false,
        remap = false
      },
      {
        "<leader>x",
        "<Cmd>bd!<Cr>",
        desc = "Close current buffer",
        nowait = false,
        remap = false
      },
      {
        "<leader>z",
        "<Cmd>Lazy<CR>",
        desc = "Lazy",
        nowait = false,
        remap = false
      },
    }

    -- Normal Mode

    wk.add(leader)

    -- vim.api.nvim_set_keymap('n', '<C-k>', '<C-u>', { noremap = true })
    -- vim.api.nvim_set_keymap('n', '<C-j>', '<C-d>', { noremap = true })
    -- vim.keymap.set({ 'n', 'x' }, '<C-k>', "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>")
    -- vim.keymap.set({ 'n', 'x' }, '<C-j>', "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>")
    local normal = {
      mode = { "n" },
      { "<C-<>", "<Cmd>BufferMovePrevious<CR>",                     desc = "Move Buffer Left" },
      { "<C->>", "<Cmd>BufferMoveNext<CR>",                         desc = "Move Buffer Right" },
      { "<C-b>", "<Cmd>FzfLua buffers<CR>",                         desc = "Buffer List" },
      { "<C-i>", "<Cmd>BufferNext<CR>",                             desc = "Next Buffer" },
      { "<C-p>", "<Cmd>FzfLua commands<CR>",                        desc = "Command Pallete " },
      { "<C-u>", "<Cmd>BufferPrevious<CR>",                         desc = "Previous Buffer" },
      { "<C-x>", "<Cmd>bd!<Cr>",                                    desc = "Close current buffer" },
      { "g",     group = "Goto" },
      { "gD",    "<Cmd>lua vim.lsp.buf.declaration()<CR>",          desc = "Declaration" },
      { "gI",    "<cmd>Telescope lsp_implementations<CR>",          desc = "Goto Implementation" },
      { "gd",    "<Cmd>lua vim.lsp.buf.definition()<CR>",           desc = "Definition" },
      { "gs",    "<cmd>lua vim.lsp.buf.signature_help()<CR>",       desc = "Signature Help" },
      { "gt",    "<cmd>lua vim.lsp.buf.type_definition()<CR>",      desc = "Goto Type Definition" },
      { "gx",    desc = "<Cmd>lua require('open').open_cword()<CR>" },
    }

    wk.add(normal)

    local visual =
    {
      mode = { "v" },
      {
        "f",
        "<Cmd>FzfLua grep_visual<CR>",
        desc = "Grep Visual Selection",
        nowait = false,
        remap = false
      },
      { "n", group = "New Note with", nowait = false, remap = false },
      {
        "nc",
        "<Cmd>'<,'>ZkNewFromContentSelection<CR>",
        desc = "Content from selection",
        nowait = false,
        remap = false
      },
      {
        "ns",
        "<Cmd>'<,'>ZkMatch<CR>",
        desc = "Search",
        nowait = false,
        remap = false
      },
      {
        "nt",
        "<Cmd>'<,'>ZkNewFromTitleSelection<CR>",
        desc = "Title from selection",
        nowait = false,
        remap = false
      },
    }

    wk.add(visual)
  end,
}
