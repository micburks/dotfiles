
" Custom help
" ### :Help          - print this help
command! -nargs=? -bar -bang Help echo system("awk -F'\" ###' '/^\" ###/ { print $2 }' ~/.vimrc")


" ----------------------------------------------------------------------------

" ###
" ### --- General ---
"
" ----------------------------------------------------------------------------
" ### ,             - leader
" Remap leader
let mapleader = ","

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

set completeopt=menu,menuone,preview,noselect,noinsert



" ----------------------------------------------------------------------------
"
" Tabs
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
" ###
" ### --- Search ---
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

" ### //            - Search for currently selected text (all characters)
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" ----------------------------------------------------------------------------
"
" ###
" ### --- Buffers ---
"
" ----------------------------------------------------------------------------
" ### :e            - edit file
" ### :new          - new buffer
" ### :w NAME       - save buffer as NAME
" ### :ls           - list buffers

" One handed vim exit - particularly for use in ranger
nnoremap ;; :q<Enter>



" ----------------------------------------------------------------------------
"
" ###
" ### --- Copy/Paste ---
"
" ----------------------------------------------------------------------------
" ### ,c            - Copy mode (remove number settings)
nnoremap <leader>c :setlocal number! relativenumber!<cr>

" ### ,y            - Copy entire file
nnoremap <leader>y :!cat "%" \| pbcopy<cr>q

" `set paste` ruins everything
" it disables a bunch of things including insert mapping and command line modes
" ### ,v            - Toggle 'paste' mode
set pastetoggle=<leader>v

" Set copy buffer to 1000 lines
set viminfo='20,<1000

" Quick way to add empty lines
" ### ,O            - New line above without entering insert
nnoremap <leader>O O<ESC>
" ### ,o            - New line below without entering insert
nnoremap <leader>o o<ESC>

" Then <leader>s commented line to add long lines above and below for marking
" ### ,s            - Add same length '---' lines before/after current line
nnoremap <leader>s yyPVr-yyjp



" ----------------------------------------------------------------------------
"
" --- Convenience ---
"
" ----------------------------------------------------------------------------
" Clear highlighting
nnoremap <leader><space> :noh<cr>

nnoremap <tab> %
vnoremap <tab> %

" So we don't have to press shift when we want to get into command mode
nnoremap ; :
vnoremap ; :

" So we don't have to reach for escape to leave insert mode
" qwerty
imap jk <Esc>
imap Jk <Esc>
imap JK <Esc>

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
noremap j gj
noremap k gk



" ----------------------------------------------------------------------------
"
" ###
" ### --- vim-plug ---
"
" ----------------------------------------------------------------------------
" ### :PlugInstall  - Install plugins from ~/.vimrc
" ### :PlugUpdate   - Update plugins from ~/.vimrc

" Begin vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'kamwitsta/nordisk'
Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'

" utils
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'andrewradev/splitjoin.vim'

" terminal integration
" Plug 'kassio/neoterm'
" git clone https://github.com/kassio/neoterm
" commented out - tmux works fine for this

" js
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }

" html/jsx
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript.jsx', 'typescriptreact'] }
Plug 'andrewradev/tagalong.vim', { 'for': ['html', 'javascript.jsx', 'typescriptreact'] }

" typescript
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescriptreact'] }

" reason
Plug 'reasonml-editor/vim-reason', { 'for': ['reason'] }

" graphql
Plug 'jparise/vim-graphql'

" syntax and lsp support
Plug 'dense-analysis/ale'

" auto-complete
"Plug 'shougo/deoplete.nvim'
" deps
"pip3 install --user pynvim # ?
"git clone https://github.com/roxma/nvim-yarp
"git clone https://github.com/roxma/vim-hug-neovim-rpc

" manage universal ctags
" git clone https://github.com/universal-ctags/ctags
" cd ctags && ./autogen.sh && ./configure && make && sudo make install
" cd ~/.vim/bundle/
" git clone https://github.com/ludovicchabant/vim-gutentags.git
" commented out - i think this was all broken

" js imports
" 
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

" markdown
Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'text'] }
Plug 'junegunn/limelight.vim', { 'for': ['markdown', 'text'] }

" spell checking
Plug 'kamykn/spelunker.vim', { 'on': 'Spelling' }

" End of plugins
call plug#end()



" ----------------------------------------------------------------------------
"
" ###
" ### --- goyo/limelight ---
"
" ----------------------------------------------------------------------------
" ### :Goyo         - Toggle goyo
" TODO: Figure out what is wrong with TERM in alacritty
" ### :Limelight    - Toggle limelight



" ----------------------------------------------------------------------------
"
" ###
" ### --- easymotion ---
"
" ----------------------------------------------------------------------------
" ### ,,<MOVE>      - easymotion: jump for any movement



" ----------------------------------------------------------------------------
"
" ###
" ### --- splitjoin ---
"
" ----------------------------------------------------------------------------
" ### gS            - splitjoin: 1 -> many lines
" ### gJ            - splitjoin: many -> 1 line



" ----------------------------------------------------------------------------
"
" ###
" ### --- surround ---
" - Text object selection
" ### '"`[({<wWsbBpt
"
" ----------------------------------------------------------------------------
" ### ys<1><2>      - (y)ou (s)urround - add surround
" ### cs<1><2>      - (c)hange (s)urround
" ### ds<1>         - (d)elete (s)urround



" ----------------------------------------------------------------------------
"
" ###
" ### --- spelunker ---
"
" ----------------------------------------------------------------------------
set nospell

" ### Zl            - Suggest correction for current word
" ### ZL            - Suggest correction for all occurrences of current word
" ### ZN            - (N)ext misspelled word
" ### ZP            - (P)revious misspelled word
" ### ZC            - (C)orrect all occurrences of current misspelled word
" ### ZT            - (T)oggle spelunker



" ----------------------------------------------------------------------------
"
" --- Indent guides ---
"
" ----------------------------------------------------------------------------
" let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray   ctermbg=0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=8
" autocmd VimEnter * IndentGuidesEnable



" ----------------------------------------------------------------------------
"
" --- File types ---
"
" ----------------------------------------------------------------------------
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

" Reason language server
let g:LanguageClient_serverCommands = {
\ 'reason': ['/home/MICKEY/bin/reason-language-server.exe']
\ }
autocmd BufEnter *.re colorscheme dracula

" JSX highlighting in JS files
let g:jsx_ext_required = 0



" ----------------------------------------------------------------------------
"
" ###
" ### --- ale ---
"
" ----------------------------------------------------------------------------
" Ale completion is no good
let g:ale_completion_enabled = 1

let g:ale_set_highlights = 0

let g:js_file_import_strip_file_extension = 0

" ### go            - go to definition
nnoremap go :ALEGoToDefinition<CR>

" ### gb            - (g)o (b)ack
nnoremap gb :pop<CR>

" ### ,p            - previous error
nmap <leader>p <Plug>(ale_previous_wrap)

" ### ,n            - next error
nmap <leader>n <Plug>(ale_next_wrap)

" ### ,<Enter>      - show hover details
nmap <leader><Enter> <Plug>(ale_hover)

" ### :Fix          - use ale to auto-fix lint
" Copied from ale source code - called Fix rather than ALEFix
command! -bar -nargs=* -complete=customlist,ale#fix#registry#CompleteFixers Fix :call ale#fix#Fix(bufnr(''), '', <f-args>)

" ### :More         - show lint/type issues with current line
" Copied from ale source code - called More rather than ALEDetail
command! -bar More :call ale#cursor#ShowCursorDetail()

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



" ----------------------------------------------------------------------------
"
" ###
" ### --- neoterm ---
"
" ----------------------------------------------------------------------------
let g:neoterm_autoinsert = 0 " default

let g:neoterm_default_mod = 'rightbelow'

" ### ,t            - Start neoterm command
nnoremap <leader>t :T 



" ----------------------------------------------------------------------------
"
" ###
" ### --- NERD tree ---
"
" ----------------------------------------------------------------------------
" ### <TAB>         - Open NERD tree
map <Tab> :NERDTreeToggle<CR>

" ### ,<TAB>[hjkl]  - Move to corresponding split
map <leader><Tab>l  <C-w>l
map <leader><Tab>h  <C-w>h
map <leader><Tab>k  <C-w>k
map <leader><Tab>j  <C-w>j

" Open NERD tree automatically with `vim`
autocmd StdinReadPre * let s:std_in=1

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeShowHidden=1



" ----------------------------------------------------------------------------
"
" --- Colors ---
"
" ----------------------------------------------------------------------------
" colorscheme dracula
colorscheme nordisk
" colorscheme iceberg
" colorscheme gruvbox



" ----------------------------------------------------------------------------
"
" --- Help ---
"
" ----------------------------------------------------------------------------
silent! helptags ALL



" Put these lines at the very end of your vimrc file.
" packloadall " -- ?
