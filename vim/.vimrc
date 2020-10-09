syntax on

let g:ruby_path = system('asdf where ruby')

let g:rspec_runner = "os_x_iterm2"

let g:python3_host_prog = '/Users/andrewlechowicz/.asdf/installs/python/3.7.2/bin/python3'

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

set nocompatible
set nobackup
set nowritebackup
set number
set ruler
set timeoutlen=1000
set ttyfast
set lazyredraw
set showcmd
" Give more space for displaying messages.
set cmdheight=2
set colorcolumn=80
set clipboard=unnamedplus
" Use Vim 7.3 Regex engine
set regexpengine=1
" set relativenumber
" :au FocusLost * :set norelativenumber
" :au FocusGained * :set relativenumber
" autocmd InsertEnter * :set norelativenumber
" autocmd InsertLeave * :set relativenumber
"set cursorline

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

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

filetype plugin indent on

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

" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Editor-like plugins
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/vadimr/bclose.vim'
Plug 'ntpeters/vim-better-whitespace'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
Plug 'elmcast/elm-vim'
Plug 'tpope/vim-endwise'

" Syntax and highlighing
Plug 'scrooloose/syntastic'

" vim-polyglot
let g:polyglot_disabled = ['elm']
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-html',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'neoclide/coc-json',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'neoclide/coc-snippets',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

" Snippets
Plug 'honza/vim-snippets'

" Tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'mhinz/vim-mix-format'

" Ruby
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'
Plug 'ngmy/vim-rubocop'

" Colors
Plug 'joshdick/onedark.vim'

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

" Enable prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1

augroup css
	autocmd!
	autocmd BufNewFile,BufRead *.scss,*.sass setlocal et ai sw=2 st=2 sts=2
augroup END

" Markdown folding
let g:vim_markdown_folding_disabled=1

" Markdown 80 characeter limit
au BufRead,BufNewFile *.md setlocal textwidth=80

" Spell checking
" Markdown
autocmd BufRead,BufNewFile *.md setlocal spell
" Git Commit messages
autocmd FileType gitcommit setlocal spell

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

if has('nvim')
  " Vim Airline
  set noshowmode " Disable the default mode indicator
  let g:airline_powerline_fonts = 1
  let g:airline_theme='onedark'
  set laststatus=2
endif

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

