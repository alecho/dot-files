-- Prepend mise shims to PATH so child processes (LSPs, formatters) see them
if vim.env and vim.env.HOME and vim.env.PATH then
  vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.filetype.add({ extension = { herb = "eruby.html" } })

-- Add keymapping for Lazy
vim.keymap.set("n", "<leader>z", ":Lazy<CR>", { noremap = true, silent = true })

require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
  },
  ui = {
    border = "rounded",
  },
})

vim.opt.spell = false
vim.opt.spelllang = "en_us"
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.diagnostic.config({
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
})

-- Set colorscheme
vim.cmd('colorscheme dracula')

-- Autocmd settings
local autocmds = {
  --
  -- filetypes related autocommands
  {
    events = { "BufRead", "BufNewFile" },
    glob = "*.prompt",
    commands = { 'setlocal wrap', 'setlocal wrapmargin=80', 'setlocal syntax=off' },
  },
  {
    events = { "FileType" },
    glob = "*",
    commands = { "setlocal colorcolumn=81" },
  },
}

-- Register all commands without clearing earlier entries.
local autocmd_group = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })
for _, group in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(group.events, {
    group = autocmd_group,
    pattern = group.glob,
    callback = function()
      for _, cmd in ipairs(group.commands) do vim.cmd(cmd) end
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function() vim.b.cinnamon_disable = true end,
})
