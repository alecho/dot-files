syntax on

set nocompatible
set number
set ruler

" Disabled arrow keys N00b!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>

" Tabs, indentation and whitespace
set expandtab
set tabstop=2
"set softtabstop=2
set shiftwidth=2
"set list
"set listchars=tab:->

set completeopt=longest,menu,preview
set selectmode=mouse
set hidden
set clipboard=unnamed

set backspace=indent,eol,start " backspace over everything in insert mode

" File name at bottom of VIM
set ls=2

vnoremap p "_dP

" ===== Vundle Setup - the vim plugin bundler =====
" This will install Vundle if not installed
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" My bundles
Plugin 'https://github.com/kien/ctrlp.vim'
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'https://github.com/rking/ag.vim'
Plugin 'https://github.com/editorconfig/editorconfig-vim'
Plugin 'https://github.com/gerw/vim-HiLinkTrace'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/mattn/emmet-vim.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'https://github.com/vadimr/bclose.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'rizzatti/dash.vim'
Plugin 'fatih/vim-go'

" === Install Bundles ===
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

colorscheme Afterglow

" CtrlP
map <C-b> :CtrlPBuffer<cr>

" Configure CtrlP to use The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -li --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore "puphpet"
      \ --ignore "tmp"
      \ -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" NERD tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Show hidden files
let NERDTreeShowHidden=1
" Ignore swap files
let NERDTreeIgnore = ['^\.DS_Store$', '\.swp$', '^\.git$', '^\.sass-cache$']
" Toggle with <kbd>\</kbd>
map <silent> <leader>\ :NERDTreeToggle<cr>

" Handlebars syntax
au BufRead,BufNewFile *.handlebars,*.hbs set ft=html syntax=handlebars

augroup css
	autocmd!
	autocmd BufNewFile,BufRead *.scss,*.sass setlocal et ai sw=2 st=2 sts=2
augroup END

" Git Gutter Signcolumn color
highlight clear SignColumn

" Syntaxes
au BufReadPost *.hbs set syntax=html
au BufReadPost *.ctp set syntax=php
