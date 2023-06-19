require("plugins").setup()

vim.opt.textwidth = 80
vim.opt.colorcolumn = "80"
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"


vim.cmd([[

" Markdown 80 character limit
au BufRead,BufNewFile *.md setlocal textwidth=80

" Spell checking
" Markdown
autocmd BufRead,BufNewFile *.md setlocal spell
" Git Commit messages
autocmd FileType gitcommit setlocal spell


]])
