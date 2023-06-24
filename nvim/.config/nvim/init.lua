require("plugins").setup()

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"


vim.cmd([[

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
