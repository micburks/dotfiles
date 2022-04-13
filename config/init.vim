" ----------------------------------------------------------------------------
"
" # general
"
" ----------------------------------------------------------------------------
"""general - \             - leader

" show current line number
set number
" changes Vim’s line number column to display how far away each line is from the current one
set relativenumber

" syntax highlighting
syntax on

" spellcheck
set spell spelllang=en_us

" Match indents on new lines
set autoindent

" filetype detection
filetype plugin indent on
au BufRead,BufNewFile *.nix		setfiletype nix

" Not compatible with vi
set nocompatible

" Don't look for modelines
set modelines=0

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

" Long line handling
set textwidth=79
set formatoptions=qrn1

" Color characters starting here
set colorcolumn=85

" set list
set listchars=tab:▸\ ,eol:¬

" visual bells off - important for nordisk theme
set belloff=all

" Switch 0 and ^
" Go to the first non-blank character of a line
noremap 0 ^
" Just in case you need to go to the very beginning of a line
noremap ^ 0



" ----------------------------------------------------------------------------
"
" tabs
"
" ----------------------------------------------------------------------------
set tabstop=2
set shiftwidth=2
  
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



" ----------------------------------------------------------------------------
"
" # search
"
" ----------------------------------------------------------------------------
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

"""search - //            - (visual) Search for currently selected text (all characters)
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>



" ----------------------------------------------------------------------------
"
" # folds
"
" ----------------------------------------------------------------------------
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=20

"""folds - :set fdm      - set fold method [manual, syntax, indent]
"""folds - zo            - (o)pen fold
"""folds - zr            - open all folds one level (R for all levels)
"""folds - zc            - (c)lose fold
"""folds - zm            - close all folds one level (M for all levels)


" ----------------------------------------------------------------------------
"
" # buffers
"
" ----------------------------------------------------------------------------
"""buffers - :e            - edit file
"""buffers - :new          - new buffer
"""buffers - :w NAME       - save buffer as NAME
"""buffers - :ls           - list buffers

" One handed vim exit - particularly for use in ranger
" nnoremap ;; :q<Enter>



" ----------------------------------------------------------------------------
"
" # registers
"
" ----------------------------------------------------------------------------
"""registers - :reg          - see all registers
"""registers - :let @a=@b    - write to a register
"""registers - ".            - last entered text register (read-only)
"""registers - ":            - last executed command register (read-only)
"""registers - "%            - current file name register (read-only)
"""registers - "+            - clipboard register
"""registers - "=            - last expression register
"""registers - "/            - last search register
"""registers - "0            - last yanked text register
"""registers - "1-9          - last deleted text registers
"""registers - "ry           - (normal) copy selected text into register 'r'
"""registers - "rp           - (normal) paste text from register 'r'
"""registers - <ctrl-r> r    - (insert/command) paste register 'r'
"""registers - :let @+=@%    - copy current file path to clipboard
"""registers - :let @R=''    - append text to register 'r' (uppercase makes it append)
"""registers - @:            - execute last command
"""registers - @+            - execute clipboard as command
"""registers - @r            - execute register 'r' as macro
"""registers - qr            - record macro into register 'r'



" ----------------------------------------------------------------------------
"
" # marks - [Using marks](https://vim.fandom.com/wiki/Using_marks)
"
" ----------------------------------------------------------------------------
"""marks [Using marks](https://vim.fandom.com/wiki/Using_marks)
"""marks
"""marks - ma            - mark "a"
"""marks - 'a            - jump to line of mark "a"
"""marks - `a            - jump to position of mark "a"
"""marks - ``            - jump to position before last jump



" ----------------------------------------------------------------------------
"
" # copy/paste
"
" ----------------------------------------------------------------------------
"""copy-paste - \vc           - Copy mode (remove number settings)
nnoremap <leader>vc :setlocal number! relativenumber!<cr><space><enter>

"""copy-paste - \vy           - Copy entire file contents
nnoremap <leader>vy :!cat "%" \| pbcopy<cr>

" `set paste` ruins everything
" it disables a bunch of things including insert mapping and command line modes
"""copy-paste - \vv           - Toggle 'paste' mode
set pastetoggle=<leader>vv

" Set copy buffer to 1000 lines
set viminfo='20,<1000

" Quick way to add empty lines
"""editing - <space>O      - New line above without entering insert
nnoremap <space>O O<ESC>
"""editing - <space>o      - New line below without entering insert
nnoremap <space>o o<ESC>

" Then <leader>s commented line to add long lines above and below for marking
"""editing - <space>z      - Add same length '---' lines before/after current line
nnoremap <space>z yyPVr-yyjp



" ----------------------------------------------------------------------------
"
" --- convenience ---
"
" ----------------------------------------------------------------------------
" Clear highlighting
"""general - \<space>      - clear highlighting
nnoremap <leader><space> :noh<cr>

"""movement - g<tab>        - %
nnoremap g<tab> %
vnoremap g<tab> %

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
" Edit: these interfere with basic vim motions when `wrap` is set, such as `d<down>`
" noremap j gj
" noremap k gk



" ----------------------------------------------------------------------------
"
" # splits
"
" ----------------------------------------------------------------------------
set nowrap
"""splits - arrow keys    - Move to corresponding split
nnoremap <silent> <left> :set nowrap<CR><C-w><left><C-w>=:set wrap<CR>
nnoremap <silent> <down> :set nowrap<CR><C-w><down><C-w>=:set wrap<CR>
nnoremap <silent> <up> :set nowrap<CR><C-w><up><C-w>=:set wrap<CR>
nnoremap <silent> <right> :set nowrap<CR><C-w><right><C-w>=:set wrap<CR>


"""splits - <C-hjkl>      - Resize split
nnoremap <silent> <C-l> :vertical resize -5<CR>
nnoremap <silent> <C-j> :resize -5<CR>
nnoremap <silent> <C-k> :resize +5<CR>
nnoremap <silent> <C-h> :vertical resize +5<CR>

" sensible splits
set splitbelow
set splitright

" TODO make these easier
"""splits - <C-w> _       - Max out the height of the current split
"""splits - <C-w> |       - Max out the width of the current split
"""splits - <C-w> =       - Normalize all split sizes, useful when resizing terminal
"""splits - <C-w> R       - Swap top/bottom or left/right split
"""splits - <C-w> T       - Break out current window into a new tabview
"""splits - <C-w> o       - Close every window in the current tabview but the current one

   

" ----------------------------------------------------------------------------
"
" # colors
"
" ----------------------------------------------------------------------------
" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"set background=dark
"""general - colo ARG      - colorscheme [gruvbox,iceberg,nordisk,pulumi,zenburn]

colorscheme gruvbox
" colorscheme iceberg
" colorscheme nordisk
" colorscheme pulumi
" colorscheme zenburn



" ----------------------------------------------------------------------------
"
" ... help ...
"
" ----------------------------------------------------------------------------
silent! helptags ALL
