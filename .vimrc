" show current line number
set number
" changes Vim’s line number column to display how far away each line is from the current one
set relativenumber

" This ruins everything
" set paste will disable a bunch of things including:
" mapping on insert and command line modes
" set paste
syntax on

" Indenting
" set autoindent      " Match indents on new lines
" Filetype based indenting
filetype off
filetype plugin indent on

" Not compatible with vi
set nocompatible
" Don't look for modelines
set modelines=0


" Remap leader
let mapleader = ","


" One handed vim exit - particularly for use in ranger
nnoremap ;; :q

" Quick way to add empty lines
nnoremap <leader>O O<ESC>
nnoremap <leader>o o<ESC>

" For most filetypes
" <leader>d comment single line
" <leader>f comment multiple selected lines

" Then <leader>s commented line to add long lines above and below for marking
nnoremap <leader>s yyPVr-yyjp

set tabstop=4
set shiftwidth=4
" Use spaces instead of tabs
set expandtab

" Not sure
set softtabstop=4

" Lets tab key insert 'tab stops', and bksp deletes tabs
set smarttab

" Tab / Shifting moves to closest tabstop
set shiftround

" Intelligently dedent / indent new lines based on rules
set smartindent

" Begin - not sure what all these do
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

"tells Vim to create <FILENAME>.un~ 'undo' files whenever you edit a file
" set undofile
"   End 


nnoremap / /\v
vnoremap / /\v

" Case insensitive search
set ignorecase
" If there are uppercase letters, become case-sensitive
set smartcase
" Always use global replace
"set gdefault
" Live incremental searching
set incsearch
" Live match highlighting
set showmatch
" Highlight matches
set hlsearch

" Clear highlighting
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Long line handling
set wrap
set textwidth=79
set formatoptions=qrn1
" Color characters starting here
set colorcolumn=85

" set list
" set listchars=tab:▸\ ,eol:¬


" So we don't have to press shift when we want to get into command mode
nnoremap ; :
vnoremap ; :

" So we don't have to reach for escape to leave insert mode
imap jk <Esc>

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the wrapped portion. This fixes that.
noremap j gj
noremap k gk

" Associate *.less with css filetype
au BufRead,BufNewFile *.less setfiletype css


" Pathogen
execute pathogen#infect()

" Nerd Tree Tabs Plugin
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Vim-Less (Vim syntax for LESS)
nnoremap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>


" Color
" colorscheme delek

" JellyBeans
colorscheme jellybeans

" Solarized
" syntax enable
" set background=light
" set background=dark
" colorscheme solarized
" call togglebg#map("<F5>")




