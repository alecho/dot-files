syntax on

let g:ruby_path = system('asdf where ruby')
let g:python3_host_prog = '/Users/andrewlechowicz/.asdf/shims/python'

let g:rspec_runner = "os_x_iterm2"

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
set regexpengine=0
" set relativenumber
" :au FocusLost * :set norelativenumber
" :au FocusGained * :set relativenumber
" autocmd InsertEnter * :set norelativenumber
" autocmd InsertLeave * :set relativenumber
"set cursorline

set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

let g:cssColorVimDoNotMessMyUpdatetime = 1

" Maintain undo history between sessions
set undodir=$HOME/.vim/undodir
set undofile

" Tmux is setup to use <C-a> as it's prefix and white mutiple <C-a>s in vim will
" increment the current or next number on a line I find it's easier to user
" Alt + a and Alt + x to increment and decrement numbers to avoid having to
" double press Ctrl + a from within tmux.
" nnoremap <C-k> <C-a>
" nnoremap <C-j> <C-x>

nnoremap <C-x> :Bclose<CR>
nnoremap <C-X> :Bclose!<CR>

" Toogle paste mode with ctrl + g
" 2021-02-16 This is conflicting with Coc completion
" set pastetoggle=<C-g>

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

" Remap the p command in visual mode so that it first deletes to the black hole
" register. This prevents pasting over visually selected text from overwriting
" the paste board.
vnoremap p "_dP

" Set Ag as the ack program
let g:ackprg = 'ag --vimgrep'

" bind K to grep word under cursor
nnoremap K :Ag "<C-R><C-W>"<CR>:cw<CR>

" Insert a pipe operator with ctrl-\ in insert mode
imap <c-\> \|><space>

" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Editor-like plugins
" Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" ctrl-p opens fzf window
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles! --exclude-standard --others --cached')."\<cr>"
Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/vadimr/bclose.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Easier vim session management
Plug 'tpope/vim-obsession'
" `ysiw;` Map/keyword atom view value
let g:surround_59 = "\r: "
" Is this needed?
let g:surround_61 = "<%= \r %>"


Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'html'] }
Plug 'elmcast/elm-vim'
" Plug 'tpope/vim-endwise'

" Syntax and highlighing
" Plug 'scrooloose/syntastic'

" Tyescript and JSX
Plug 'HerringtonDarkholme/yats'

" vim-polyglot
let g:polyglot_disabled = ['elm']
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-html',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'neoclide/coc-json',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'neoclide/coc-snippets',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'neoclide/coc-solargraph'
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-eslint'
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'pantharshit00/vim-prisma'
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() :
        \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

Plug 'itchyny/lightline.vim'
" Snippets
Plug 'honza/vim-snippets'

" Tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'

" Elixir
Plug 'elixir-lang/vim-elixir'

" Plug 'slashmili/alchemist.vim'
Plug 'mhinz/vim-mix-format'

" Ruby
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'
Plug 'ngmy/vim-rubocop'

" Colors
Plug 'joshdick/onedark.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'drewtempelmeyer/palenight.vim'

" Filetype Icons
" keep this last
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Neovim Lanuage Server
lua <<EOF
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require'lspconfig'.elixirls.setup{
    cmd = { "/Users/andrewlechowicz/.elixir-ls/release/language_server.sh" };
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help", "elixir", "eex", "heex" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}
EOF

" Set the colorscheme
colorscheme dracula
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'filename': '%f'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Coc Popup Menu colors

hi! Pmenu guifg=#f8f8f2 guibg=#44475a
hi! CocPumMenu guifg=#f8f8f2 guibg=#44475a
hi! PmenuSel guifg=#282a36 guibg=#bd93f9
hi! CocMenuSel guifg=#282a36 guibg=#bd93f9
hi! CocPumSearch guifg=#50fa7b ctermbg=NONE cterm=underline

" fzf buffer
map <C-b> :Buffer<cr>

" NERD tree
autocmd StdinReadPre * let s:std_in=1

" Show hidden files
let NERDTreeShowHidden=1
" Ignore swap files
let NERDTreeIgnore = ['^\.DS_Store$', '\.swp$', '^\.git$', '^\.sass-cache$']
" Toggle with <kbd>\</kbd>
map <silent> \ :NERDTreeToggle<cr>
" Sort files and folders together
let NERDTreeSortOrder = ['*', '\.swp$',  '\.bak$', '\~$']
" Numbers are sorted as numbers not strings
let NERDTreeNaturalSort = 1

" Enable prettier
let g:prettier#autoformat = 0
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

let g:syntastic_html_checkers=['']
let g:syntastic_hbs_checkers=['']

" Auto format with `mix format` on save
let g:mix_format_on_save = 1

" Git Gutter Signcolumn color
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_set_sign_backgrounds = 1
" highlight clear SignColumn
" highlight SignColumn ctermbg=NONE   " terminal Vim
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

