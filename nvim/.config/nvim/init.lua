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

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.cmd([[
colorscheme dracula

" Default to 80 character limit
autocmd FileType * setlocal colorcolumn=81

" Markdown 80 character limit
au BufRead,BufNewFile *.md setlocal textwidth=80

" Spell checking
" Markdown
autocmd BufRead,BufNewFile *.md setlocal spell
" Git Commit messages
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal colorcolumn=51

" Startup screen
autocmd FileType alpha setlocal colorcolumn=0
]])
