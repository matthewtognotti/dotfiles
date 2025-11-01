" ============================================================================
" VIM CONFIGURATION
" ============================================================================

" ----------------------------------------------------------------------------
" PLUGIN MANAGEMENT (vim-plug)
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Language support and syntax
Plug 'sheerun/vim-polyglot'           " Syntax for 100+ languages

" Code completion and LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Intellisense engine

" File navigation
Plug 'preservim/nerdtree'             " File tree explorer
Plug 'ctrlpvim/ctrlp.vim'            " Fuzzy file finder

" Git integration
Plug 'tpope/vim-fugitive'            " Git commands in vim
Plug 'airblade/vim-gitgutter'        " Show git diff in gutter

" Code quality and linting
Plug 'dense-analysis/ale'            " Asynchronous linting
Plug 'jiangmiao/auto-pairs'          " Auto-close brackets/quotes

" UI improvements
Plug 'vim-airline/vim-airline'       " Enhanced status line
Plug 'vim-airline/vim-airline-themes'

" HTML/CSS/JS workflow
Plug 'mattn/emmet-vim'               " Fast HTML/CSS expansion

" Color schemes
Plug 'morhetz/gruvbox'               " Gruvbox colorscheme
Plug 'joshdick/onedark.vim'          " OneDark colorscheme

" Comments
Plug 'tpope/vim-commentary'          " Easy commenting (gcc)

call plug#end()

" ----------------------------------------------------------------------------
" BASIC SETTINGS
" ----------------------------------------------------------------------------

" Syntax and filetype
syntax on
filetype plugin indent on

" Visual settings
set number                    " Show line numbers
set relativenumber           " Show relative line numbers
set cursorline              " Highlight current line
set showmatch               " Highlight matching brackets
set colorcolumn=80          " Show column guide at 80 chars
set ruler                   " Show cursor position
set showcmd                 " Show partial commands

" Color scheme
set background=dark
set termguicolors           " Enable true color support
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italic = 1
colorscheme gruvbox

" Indentation
set autoindent
set smartindent
set expandtab               " Use spaces instead of tabs
set shiftwidth=4           " Indent by 4 spaces
set tabstop=4              " Tab = 4 spaces
set softtabstop=4

" Search
set hlsearch               " Highlight search results
set incsearch              " Incremental search
set ignorecase             " Case insensitive search
set smartcase              " Case sensitive if uppercase present

" Usability
set mouse=a                " Enable mouse support
set clipboard=unnamed      " Use system clipboard
set backspace=indent,eol,start  " Backspace behavior
set wildmenu               " Better command-line completion
set wildmode=longest:full,full
set hidden                 " Allow hidden buffers
set encoding=utf-8         " UTF-8 encoding

" Performance
set lazyredraw            " Don't redraw during macros
set ttyfast               " Faster scrolling
set updatetime=300        " Faster completion

" Backup and swap
set nobackup
set nowritebackup
set noswapfile

" Splits
set splitbelow            " Horizontal splits below
set splitright            " Vertical splits to right

" Visual bell instead of beeping
set visualbell

" Better display for messages
set cmdheight=2

" Always show status line
set laststatus=2

" ----------------------------------------------------------------------------
" FILE-SPECIFIC SETTINGS
" ----------------------------------------------------------------------------

" HTML, CSS, JavaScript, TypeScript, JSON
autocmd FileType html,css,javascript,typescript,json,yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Python
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

" Go
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

" Markdown
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 wrap

" Ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2

" ----------------------------------------------------------------------------
" KEY MAPPINGS
" ----------------------------------------------------------------------------

" Set leader key
let mapleader = ","

" NERDTree toggle
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Tab navigation
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>

" ----------------------------------------------------------------------------
" PLUGIN SETTINGS
" ----------------------------------------------------------------------------

" NERDTree settings
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.DS_Store$', 'node_modules']

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" CtrlP settings
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|dist|build)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ }

" ALE settings
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8', 'pylint'],
\   'html': ['htmlhint'],
\   'css': ['stylelint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'python': ['black', 'isort'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_fix_on_save = 0  " Set to 1 to auto-fix on save

" Emmet settings
let g:user_emmet_leader_key='<C-Z>'
let g:user_emmet_settings = {
\  'html' : {
\    'indentation' : '  '
\  }
\}

" GitGutter settings
set signcolumn=yes

" ----------------------------------------------------------------------------
" COC.NVIM SETTINGS
" ----------------------------------------------------------------------------

" Use tab for trigger completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <CR> to confirm completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" ----------------------------------------------------------------------------
" CUSTOM FUNCTIONS
" ----------------------------------------------------------------------------

" Highlight matching HTML tags
runtime macros/matchit.vim

" Auto-close HTML tags on </
autocmd FileType html,xml inoremap </ </<C-X><C-O>

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" ----------------------------------------------------------------------------
" NOTES
" ----------------------------------------------------------------------------
" After saving this file, run:
"   :PlugInstall
"
" Key mappings:
"   ,n - Toggle NERDTree
"   ,f - Find current file in NERDTree
"   ,<space> - Clear search highlighting
"   ,w - Quick save
"   ,q - Quick quit
"   Ctrl+h/j/k/l - Navigate splits
"   gd - Go to definition (with CoC)
"   K - Show documentation (with CoC)
"   gcc - Comment/uncomment line (with vim-commentary)
"   Ctrl+Z, - Trigger Emmet expansion
"
" To install language servers for CoC:
"   :CocInstall coc-json coc-tsserver coc-html coc-css coc-python
" ============================================================================
