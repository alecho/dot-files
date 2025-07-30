local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Register autocmds
for _, group in pairs(autocmds) do
  for _, cmd in pairs(group.commands) do
    vim.api.nvim_exec('augroup MyAutocmds', true)
    vim.api.nvim_exec('autocmd! *', true)

    for _, event in pairs(group.events) do -- allow multiple events with same settings
      vim.api.nvim_exec('autocmd ' .. event .. ' ' .. group.glob .. ' ' .. cmd, true)
    end

    vim.api.nvim_exec('augroup END', true)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function() vim.b.cinnamon_disable = true end,
})
