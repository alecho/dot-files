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
  {
    "BufRead,BufNewFile",
    "*.prompt",
    "setlocal wrap",
    "setlocal wrapmargin=80",
    "setlocal syntax=off",
  },
  -- Default to 80 character limit
  { "FileType", "*", "setlocal colorcolumn=81" },

  -- Markdown 80 character limit, conceal, spellchecking
  {
    "FileType",
    "*.md",
    "setlocal textwidth=80",
    "setlocal conceallevel=2",
    "setlocal spell",
  },

  -- Git commit messages: spell checking and 51 character limit
  {
    "FileType",
    "gitcommit",
    "setlocal spell",
    "setlocal colorcolumn=51",
  },

  -- Startup screen
  {
    "FileType",
    "alpha",
    "setlocal colorcolumn=0",
    "setlocal laststatus=0",
  },
}

-- Register autocmds
for _, cmd_group in pairs(autocmds) do
  for i = 3, #cmd_group do
    vim.api.nvim_create_autocmd({ cmd_group[1] }, {
      pattern = cmd_group[2],
      command = cmd_group[i],
    })
  end
end
