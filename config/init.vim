
" Custom help
""" :Help          - print this help
command! -nargs=? -bar -bang Help echo system("awk -F'[\"-]{3}' '/^[\"-]{3}/ { print $2 }' ~/.config/nvim/{,lua/}init.*")


" TODO - better scheme for nmap
" <leaderfX for general things
" <leader>gX for syntax things
" idk

" ----------------------------------------------------------------------------

""" ... General ...
"
" ----------------------------------------------------------------------------
""" \             - leader

" show current line number
set number
" changes Vim’s line number column to display how far away each line is from the current one
set relativenumber

" syntax highlighting
syntax on

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
set wrap
set textwidth=79
set formatoptions=qrn1

" Color characters starting here
set colorcolumn=85

" set list
set listchars=tab:▸\ ,eol:¬

" visual bells off - important for nordisk theme
set belloff=all

" nvim-compe
set completeopt=menuone,noselect


" ----------------------------------------------------------------------------
"
""" Tabs
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
""" ... Search ...
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

""" //            - Search for currently selected text (all characters)
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

""" \ff           - Telescope find_files
nnoremap <leader>ff <cmd>Telescope find_files<cr>
""" \fg           - Telescope live_grep
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
""" \fb           - Telescope buffers
nnoremap <leader>fb <cmd>Telescope buffers<cr>
""" \fh           - Telescope help_tags
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



" ----------------------------------------------------------------------------
"
""" ... Folds ...
"
" ----------------------------------------------------------------------------
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set foldlevelstart=20

""" :set fdm      - set fold method [manual, syntax, indent]
""" zo            - (o)pen fold
""" zr            - open all folds one level (R for all levels)
""" zc            - (c)lose fold
""" zm            - close all folds one level (M for all levels)


" ----------------------------------------------------------------------------
"
""" ... Buffers ...
"
" ----------------------------------------------------------------------------
""" :e            - edit file
""" :new          - new buffer
""" :w NAME       - save buffer as NAME
""" :ls           - list buffers

" One handed vim exit - particularly for use in ranger
" nnoremap ;; :q<Enter>



" ----------------------------------------------------------------------------
"
""" ... Registers ...
"
" ----------------------------------------------------------------------------
""" :reg          - see all registers
""" :let @a=@b    - write to a register
""" ".            - last entered text register (read-only)
""" ":            - last executed command register (read-only)
""" "%            - current file name register (read-only)
""" "+            - clipboard register
""" "=            - last expression register
""" "/            - last search register
""" "0            - last yanked text register
""" "1-9          - last deleted text registers
""" "ry           - (normal) copy selected text into register 'r'
""" "rp           - (normal) paste text from register 'r'
""" <ctrl-r> r    - (insert/command) paste register 'r'
""" :let @+=@%    - copy current file path to clipboard
""" :let @R=''    - append text to register 'r' (uppercase makes it append)
""" @:            - execute last command
""" @+            - execute clipboard as command
""" @r            - execute register 'r' as macro
""" qr            - record macro into register 'r'



" ----------------------------------------------------------------------------
"
""" ... Marks ...
"
" ----------------------------------------------------------------------------
""" TODO



" ----------------------------------------------------------------------------
"
""" ... Copy/Paste ...
"
" ----------------------------------------------------------------------------
""" \vc           - Copy mode (remove number settings)
nnoremap <leader>vc :setlocal number! relativenumber!<cr>

""" \vy           - Copy entire file
nnoremap <leader>vy :!cat "%" \| pbcopy<cr>

" `set paste` ruins everything
" it disables a bunch of things including insert mapping and command line modes
""" \vv           - Toggle 'paste' mode
set pastetoggle=<leader>vv

" Set copy buffer to 1000 lines
set viminfo='20,<1000

" Quick way to add empty lines
""" \vO           - New line above without entering insert
nnoremap <leader>vO O<ESC>
""" \vo           - New line below without entering insert
nnoremap <leader>vo o<ESC>

" Then <leader>s commented line to add long lines above and below for marking
""" \vs           - Add same length '---' lines before/after current line
nnoremap <leader>vs yyPVr-yyjp



" ----------------------------------------------------------------------------
"
" --- Convenience ---
"
" ----------------------------------------------------------------------------
" Clear highlighting
nnoremap <leader><space> :noh<cr>

nnoremap <tab> %
vnoremap <tab> %

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
noremap j gj
noremap k gk



" ----------------------------------------------------------------------------
"
""" ... Plugin configuration ...
"
" ----------------------------------------------------------------------------
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" nvim_tree
""" \e            - Open file tree
nnoremap <silent> <leader>e :NvimTreeToggle<CR>
nnoremap <silent> <leader>e :NvimTreeToggle<CR>

""" arrow keys    - Move to corresponding split
nnoremap <silent> <left> <C-w><left><CR>
nnoremap <silent> <down> <C-w><down><CR>
nnoremap <silent> <up> <C-w><up><CR>
nnoremap <silent> <right> <C-w><right><CR>

""" <leader>arrow - Resize split
nnoremap <silent> <leader><left> :vertical resize -5<CR>
nnoremap <silent> <leader><down> :resize -5<CR>
nnoremap <silent> <leader><up> :resize +5<CR>
nnoremap <silent> <leader><right> :vertical resize +5<CR>

" sensible splits
set splitbelow
set splitright

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '-',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "ᛥ",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "ᛰ",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'default': "ᗒ",
    \   'open': "ᗐ",
    \   'empty': "ᗌ",
    \   'empty_open': "ᗊ",
    \   'symlink': "ᗘ",
    \   'symlink_open': "ᗖ",
    \   },
    \   'lsp': {
    \     'hint': "h ",
    \     'info': "i ",
    \     'warning': "w ",
    \     'error': "e ",
    \   }
    \ }

" ----------------------------------------------------------------------------
"
" --- Colors ---
"
" ----------------------------------------------------------------------------
" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"set background=dark
""" colo ARG      - colorscheme [gruvbox,iceberg,nordisk,pulumi,zenburn]

colorscheme gruvbox
" colorscheme iceberg
" colorscheme nordisk
" colorscheme pulumi
" colorscheme zenburn


" ----------------------------------------------------------------------------
"
""" ... movement ...
"
" ----------------------------------------------------------------------------
" Switch 0 and ^
" Go to the first non-blank character of a line
noremap 0 ^
" Just in case you need to go to the very beginning of a line
noremap ^ 0

""" \\            - hop: jump words



" ----------------------------------------------------------------------------
"
""" ... splitjoin ...
"
" ----------------------------------------------------------------------------
""" gS            - splitjoin: 1 -> many lines
""" gJ            - splitjoin: many -> 1 line



" ----------------------------------------------------------------------------
"
" --- Help ---
"
" ----------------------------------------------------------------------------
silent! helptags ALL
