syntax on

if has('nvim')
    let s:editor_root=expand("~/.nvim")
else
    let s:editor_root=expand("~/.vim")
endif

set nocompatible
set number
set ruler
set timeoutlen=50
set ttyfast
"set cursorline

" 256 colors
set t_Co=256

filetype off

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

" Highlight search results
set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" File name at bottom of VIM
set ls=2

" Explorer Mode
map <C-E> :Explore<cr>
let g:netrw_liststyle=3

vnoremap p "_dP

" Set Ag as the ack program
let g:ackprg = 'ag --vimgrep'

" ===== Vundle Setup - the vim plugin bundler =====
" This will install Vundle if not installed
let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/vundle/README.md'
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    " silent execute "! mkdir -p ~/." . s:editor_path_name . "/bundle"
    silent call mkdir(s:editor_root . '/bundle', "p")
    silent execute "!git clone https://github.com/gmarik/vundle " . s:editor_root . "/bundle/vundle"
    let vundle_installed=0
endif
let &rtp = &rtp . ',' . s:editor_root . '/bundle/vundle/'
call vundle#rc(s:editor_root . '/bundle')
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
Plugin 'kchmck/vim-coffee-script'
Plugin 'plasticboy/vim-markdown'
Plugin 'elixir-lang/vim-elixir'
Plugin 'Shougo/neocomplete'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'crusoexia/vim-monokai'


" === Install Bundles ===
if vundle_installed == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

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
map <silent> \ :NERDTreeToggle<cr>

syntax enable
filetype plugin indent on

" Handlebars syntax
au BufRead,BufNewFile *.handlebars,*.hbs set ft=html syntax=mustache

" Handlebars abbreviations
let g:mustache_abbreviations = 1

augroup css
	autocmd!
	autocmd BufNewFile,BufRead *.scss,*.sass setlocal et ai sw=2 st=2 sts=2
augroup END

" Markdown folding
let g:vim_markdown_folding_disabled=1

" Syntaxes
au BufReadPost *.ctp set syntax=php

" NeoComplete
source $HOME/.vimrc_neocomplete

" NeoSnippit
source $HOME/.vimrc_neosnippit

" Set the colorscheme
colorscheme monokai

" Git Gutter Signcolumn color
let g:gitgutter_sign_column_always = 1
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
" highlight SignColumn ctermbg=0    " terminal Vim
" highlight SignColumn guibg=#272727      " gVim/MacVim

" Vim Airline
set noshowmode " Disable the default mode indicator
" let g:airline_powerline_fonts = 1
" let g:airline_theme='alecho'
" set laststatus=2
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2

