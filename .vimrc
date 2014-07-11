syntax on

set nocompatible
set number
set ruler

" Tabs, indentation and whitespace
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noexpandtab
"set list
"set listchars=tab:->

set completeopt=longest,menu,preview
set selectmode=mouse
set hidden

" File name at bottom of VIM
set ls=2

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
Bundle 'https://github.com/kien/ctrlp.vim'
Bundle 'https://github.com/tpope/vim-fugitive'
Bundle 'https://github.com/rking/ag.vim'
Bundle 'https://github.com/editorconfig/editorconfig-vim'
Bundle 'https://github.com/gerw/vim-HiLinkTrace'

" === Install Bundles ===
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

colorscheme Afterglow

" CtrlP
map <C-b> :CtrlPBuffer<cr>

