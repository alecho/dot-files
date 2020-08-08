syntax on

if has('nvim')
    let s:editor_root=expand("~/.nvim")
else
    let s:editor_root=expand("~/.vim")
endif

if (has("termguicolors"))
  set termguicolors
else
  " 256 colors
  set t_Co=256
endif

set clipboard=unnamed

set nocompatible
set nobackup
set nowritebackup
set number
set ruler
set timeoutlen=1000
set ttyfast
set lazyredraw
set showcmd
" Use Vim 7.3 Regex engine
set regexpengine=1
" set relativenumber
" :au FocusLost * :set norelativenumber
" :au FocusGained * :set relativenumber
" autocmd InsertEnter * :set norelativenumber
" autocmd InsertLeave * :set relativenumber
"set cursorline

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" This does't see to work
" Tmux is setup to use <C-a> as it's prefix and mutiple <C-a>s in vim will
" increment the current or next number on a line. This rebinds to <C-l> which
" is mapped to redraw in vim by default.
nnoremap <C-a> <C-l>

nnoremap <C-x> :Bclose<CR>

" Toogle paste mode with ctrl + g
set pastetoggle=<C-g>

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

" Remap some vim keys for convenience
:command Wq wq
:command W w
nnoremap ; :
let mapleader = ","

" New Commands
" Reverse order of lines under cursor
:command! -bar -range=% Reverse <line1>,<line2>global/^/m<line1>-1

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

" bind K to grep word under cursor
nnoremap K :ag! "\b<C-R><C-W>\b"<CR>:cw<CR>

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
Plugin 'https://github.com/tpope/vim-rails'
Plugin 'https://github.com/tpope/vim-endwise'
Plugin 'https://github.com/rking/ag.vim'
Plugin 'https://github.com/editorconfig/editorconfig-vim'
" Plugin 'mustache/vim-mustache-handlebars'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'https://github.com/mattn/emmet-vim.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'https://github.com/vadimr/bclose.vim'
Plugin 'ntpeters/vim-better-whitespace'
" Plugin 'fatih/vim-go'
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'plasticboy/vim-markdown'
Plugin 'elixir-lang/vim-elixir'
Plugin 'slashmili/alchemist.vim'
Plugin 'Shougo/neocomplete'
Plugin 'scrooloose/syntastic'
Plugin 'sheerun/vim-polyglot'
Plugin 'ap/vim-css-color'
Plugin 'thoughtbot/vim-rspec'
Plugin 'ngmy/vim-rubocop'
Plugin 'mhinz/vim-mix-format'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Colors
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'crusoexia/vim-monokai'
Plugin 'joshdick/onedark.vim'


" === Install Bundles ===
if vundle_installed == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
Plug 'elmcast/elm-vim'

call plug#end()

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
      \ --ignore "node_modules"
      \ --ignore "bower"
      \ --ignore "deps"
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

" Enable prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1

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

" NeoComplete
source $HOME/.vimrc_neocomplete
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" UltiShips
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

function! FindConfig(prefix, what, where)
  let cfg = findfile(a:what, escape(a:where, ' ') . ';')
  return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
"autocmd FileType scss let b:syntastic_javascript_eslint_args =
"      \ get(g:, 'syntastic_javascript_eslint_args', '') .
"      \ FindConfig('-c', '.eslintrc', expand('<afile>:p:h', 1))


let g:syntastic_html_checkers=['']
let g:syntastic_hbs_checkers=['']

" vim-polyglot
let g:polyglot_disabled = ['elm']

" Auto format with `mix format` on save
let g:mix_format_on_save = 1

" Set the colorscheme
colorscheme onedark

" Git Gutter Signcolumn color
set signcolumn=yes
let g:gitgutter_override_sign_column_highlight = 0
" highlight clear SignColumn
" highlight SignColumn ctermbg=NONE    " terminal Vim
" highlight SignColumn guibg=NONE      " gVim/MacVim

" Vim Airline
set noshowmode " Disable the default mode indicator
" let g:airline_powerline_fonts = 1
" let g:airline_theme='alecho'
" set laststatus=2
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2

let g:ruby_path = system('asdf where ruby')

let g:rspec_runner = "os_x_iterm2"

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

