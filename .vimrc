set number
set paste
syntax on
colorscheme delek

set tabstop=4
set shiftwidth=4
set expandtab       " Use spaces instead of tabs

" Not sure
set softtabstop=4
set smarttab        " Lets tab key insert 'tab stops', and bksp deletes tabs
set shiftround      " Tab / Shifting moves to closest tabstop
set autoindent      " Match indents on new lines
set smartindent     " Intelligently dedent / indent new lines based on rules

set ignorecase      " Case insensitive search
set incsearch       " Live incremental searching
set smartcase       " If there are uppercase letters, become case-sensitive

" Not sure
"set showmatch       " Live match highlighting
"set hlsearch        " Highlight matches

" So we don't have to press shift when we want to get into command mode
nnoremap ; :
vnoremap ; :

" So we don't have to reach for escape to leave insert mode
inoremap jk <esc>

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
"noremap j gj
"noremap k gk

" Associate *.less with css filetype
au BufRead,BufNewFile *.less setfiletype css
