
" Custom help
" ### help      - print this help
nnoremap help :echo system("awk -F'\" ###' '/^\" ###/ { print $2 }' ~/.vimrc")<CR>

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
" neoterm
let &runtimepath.=',~/.vim/bundle/neoterm'
filetype plugin indent on

" Not compatible with vi
set nocompatible
" Don't look for modelines
set modelines=0

" -------------------

" General help info
"
" -------------------
" ###
" ### ,         - leader
" Remap leader
let mapleader = ","

" Buffers
" ###
" ### :e        - edit file
" ### :new      - new buffer
" ### :w NAME   - save buffer as NAME
" ### :ls       - list buffers

" One handed vim exit - particularly for use in ranger
nnoremap ;; :q<Enter>

" Copying
" ###
" ### ,c        - Copy mode (remove number settings)
nnoremap <leader>c :setlocal number! relativenumber!<cr>
" ### ,y        - Copy entire file
nnoremap <leader>y :!cat "%" \| pbcopy<cr>q
" ### ,v        - Toggle 'paste' mode
set pastetoggle=<leader>v

" Set copy buffer to 1000 lines
set viminfo='20,<1000

" Quick way to add empty lines
" ### ,O        - New line above without entering insert
nnoremap <leader>O O<ESC>
" ### ,o        - New line below without entering insert
nnoremap <leader>o o<ESC>

" Then <leader>s commented line to add long lines above and below for marking
" ### ,s        - Add long '---' lines before/after current line
nnoremap <leader>s yyPVr-yyjp

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

" What were these for?
"nnoremap / /\v
"vnoremap / /\v

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

" Use "//" to search for currently selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

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
set listchars=tab:▸\ ,eol:¬

" So we don't have to press shift when we want to get into command mode
nnoremap ; :
vnoremap ; :

" So we don't have to reach for escape to leave insert mode
" qwerty
imap jk <Esc>
imap Jk <Esc>
imap JK <Esc>

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the wrapped portion. This fixes that.
noremap j gj
noremap k gk

" Pathogen
execute pathogen#infect()

" Open NERD tree
" map <C-n> :NERDTreeToggle<CR>
map <Tab> :NERDTreeToggle<CR>
map <Leader><Tab>l  <C-w>l
map <Leader><Tab>h  <C-w>h
map <Leader><Tab>k  <C-w>k
map <Leader><Tab>j  <C-w>j

" Open NERD tree automatically with `vim`
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeShowHidden=1

" Indent guides
" let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray   ctermbg=0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=8
" autocmd VimEnter * IndentGuidesEnable

" For aquameta-sync files
au BufRead,BufNewFile js setfiletype javascript
au BufRead,BufNewFile css setfiletype css
au BufRead,BufNewFile html setfiletype html
au BufRead,BufNewFile markdown setfiletype markdown
au BufRead,BufNewFile md setfiletype markdown

" Associate *.[m|c|t]js with js filetype
au BufRead,BufNewFile *.mjs setfiletype javascript
au BufRead,BufNewFile *.cjs setfiletype javascript
au BufRead,BufNewFile *.ts setfiletype javascript

" Associate *.less with css filetype
au BufRead,BufNewFile *.less setfiletype css

" visual bells off - important for nordisk theme
set belloff=all

" Reason language server
let g:LanguageClient_serverCommands = {
\ 'reason': ['/home/MICKEY/bin/reason-language-server.exe']
\ }
autocmd BufEnter *.re colorscheme dracula

" gutentags
call pathogen#helptags()

" JSX highlighting in JS files
let g:jsx_ext_required = 0

" Ale completion is no good
let g:ale_completion_enabled = 1
set completeopt=menu,menuone,preview,noselect,noinsert
" ###
" ### go        - go to definition
nnoremap go :ALEGoToDefinition<CR>
" ### gb        - (g)o (b)ack
nnoremap gb :pop<CR>
" ### fix       - use ale to auto-fix lint
nnoremap fix :ALEFix<CR>
" ### more      - show lint/type issues with current line
nnoremap more :ALEDetail<CR>
let g:ale_set_highlights = 0
" let g:ale_fix_on_save = 1
let g:ale_linters = {
\ 'javascript': ['eslint', 'flow-language-server'],
\ 'typescript': ['tsserver', 'tslint'],
\ 'typescript.tsx': ['tsserver', 'tslint'],
\}
let g:ale_fixers = {
\ 'javascript': ['prettier', 'eslint'],
\ 'scss': ['prettier'],
\ 'css': ['prettier'],
\ 'typescript': ['prettier', 'tslint'],
\}
" Use deoplete instead
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option({
" \ 'auto_complete_delay': 200,
" \ 'smart_case': v:true,
" \ })
" Use ALE and also some plugin 'foobar' as completion sources for all code.
" call deoplete#custom#option('sources', {
" \ '_': ['ale'],
" \})
" vim-js-file-import
let g:js_file_import_strip_file_extension = 0

" neoterm
let g:neoterm_autoinsert = 0 " default
let g:neoterm_default_mod = 'rightbelow'
" ###
" ### ,t        - Start neoterm command
nnoremap <leader>t :T 

" Colors
" colorscheme dracula
colorscheme nordisk
" colorscheme iceberg
colorscheme gruvbox

" Put these lines at the very end of your vimrc file.
packloadall
silent! helptags ALL
