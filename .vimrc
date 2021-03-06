
" Custom help
" ### :Help          - print this help
command! -nargs=? -bar -bang Help echo system("awk -F'\" ###' '/^\" ###/ { print $2 }' ~/.vimrc")


" TODO - better scheme for nmap
" <leaderfX for general things
" <leader>gX for syntax things
" idk

" ----------------------------------------------------------------------------

" ###
" ### --- General ---
"
" ----------------------------------------------------------------------------
" ### \             - leader
" Remap leader
" let mapleader = ","

" ### \q            - open vimrc in tab
nnoremap <leader>q :tabf ~/.vimrc<Enter>

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
" ### --- Folds ---
"
" ----------------------------------------------------------------------------
set fdm=syntax
" ### :set fdm      - set fold method [manual, syntax, indent]
" ### zo            - (o)pen fold
" ### zr            - open all folds one level (R for all levels)
" ### zc            - (c)lose fold
" ### zm            - close all folds one level (M for all levels)

" Start with 1 level unfolded
" autocmd Syntax json normal zr
autocmd Syntax * normal zr

" Start with 1 level unfolded
autocmd Syntax conf setlocal fdm=indent



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
" nnoremap ;; :q<Enter>



" ----------------------------------------------------------------------------
"
" ###
" ### --- Registers ---
"
" ----------------------------------------------------------------------------
" ### :reg          - see all registers
" ### :let @a=@b    - write to a register
" ### ".            - last entered text register (read-only)
" ### ":            - last executed command register (read-only)
" ### "%            - current file name register (read-only)
" ### "+            - clipboard register
" ### "=            - last expression register
" ### "/            - last search register
" ### "0            - last yanked text register
" ### "1-9          - last deleted text registers
" ### "ry           - (normal) copy selected text into register 'r'
" ### "rp           - (normal) paste text from register 'r'
" ### <ctrl-r> r    - (insert/command) paste register 'r'
" ### :let @+=@%    - copy current file path to clipboard
" ### :let @R=''    - append text to register 'r' (uppercase makes it append)
" ### @:            - execute last command
" ### @+            - execute clipboard as command
" ### @r            - execute register 'r' as macro
" ### qr            - record macro into register 'r'



" ----------------------------------------------------------------------------
"
" ###
" ### --- Marks ---
"
" ----------------------------------------------------------------------------
" ### TODO



" ----------------------------------------------------------------------------
"
" ###
" ### --- Copy/Paste ---
"
" ----------------------------------------------------------------------------
" ### \vc           - Copy mode (remove number settings)
nnoremap <leader>vc :setlocal number! relativenumber!<cr>

" ### \vy           - Copy entire file
nnoremap <leader>vy :!cat "%" \| pbcopy<cr>

" `set paste` ruins everything
" it disables a bunch of things including insert mapping and command line modes
" ### \vv           - Toggle 'paste' mode
set pastetoggle=<leader>vv

" Set copy buffer to 1000 lines
set viminfo='20,<1000

" Quick way to add empty lines
" ### \vO           - New line above without entering insert
nnoremap <leader>vO O<ESC>
" ### \vo           - New line below without entering insert
nnoremap <leader>vo o<ESC>

" Then <leader>s commented line to add long lines above and below for marking
" ### \vs           - Add same length '---' lines before/after current line
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

" So we don't have to press shift when we want to get into command mode
" nnoremap ; :
" vnoremap ; :

" So we don't have to reach for escape to leave insert mode
" qwerty
" imap jk <Esc>
" imap Jk <Esc>
" imap JK <Esc>

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
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'pgavlin/pulumi.vim'
Plug 'jnurmine/Zenburn'

" highlights
Plug 'RRethy/vim-illuminate' " highlight word occurrences
Plug 'airblade/vim-gitgutter' " git
Plug 'kamykn/spelunker.vim' " spell checking

" utilities
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'andrewradev/splitjoin.vim'

" movement
Plug 'easymotion/vim-easymotion'
Plug 'unblevable/quick-scope'

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

" go
Plug 'fatih/vim-go'

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
Plug 'SidOfc/mkdx', { 'for': ['markdown'] }

" End of plugins
call plug#end()




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

set background=dark
" ### colo ARG      - colorscheme [gruvbox,dracula,iceberg,nordisk,pulumi,zenburn]

" colorscheme gruvbox
" colorscheme dracula
colorscheme nordisk
" colorscheme iceberg
" colorscheme pulumi
" colorscheme zenburn

"
" --- Note --- All settings that change highlights must come after colorscheme settings
"
hi ALEError term=reverse cterm=underline ctermfg=0 ctermbg=3 guifg=#d18a75 guibg=bg
hi link SpelunkerSpellBad SpellBad
hi illuminatedWord cterm=underline gui=underline


" ----------------------------------------------------------------------------
"
" ###
" ### --- goyo/limelight ---
"
" ----------------------------------------------------------------------------
" TODO: Figure out what is wrong with TERM in alacritty

" ### :Goyo         - Toggle goyo
" ### :Limelight    - Toggle limelight

" Help limelight calculate color for dimming - color schemes break without this
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = '#777777'

" -----------------------------------------------
"
" Snippet to quit vim/goyo at the same time
" https://github.com/junegunn/goyo.vim/wiki/Customization#ensure-q-to-quit-even-when-goyo-is-active
"
" -----------------------------------------------
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  " Added Limelight call
  :Limelight
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
" -----------------------------------------------
"
" End snippet
"
" -----------------------------------------------



" ----------------------------------------------------------------------------
"
" ###
" ### --- movement ---
"
" ----------------------------------------------------------------------------
" Switch 0 and ^
" Go to the first non-blank character of a line
noremap 0 ^
" Just in case you need to go to the very beginning of a line
noremap ^ 0

" ### \\<MOVE>      - easymotion: jump for any movement



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
" --- mkdx ---
"
" ----------------------------------------------------------------------------
let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
      \ 'enter': { 'shift': 1 },
      \ 'links': { 'external': { 'enable': 1 } },
      \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
      \ 'fold': { 'enable': 1 } }
let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
" plugin which unfortunately interferes with mkdx list indentation.




" ----------------------------------------------------------------------------
"
" ###
" ### --- spelunker ---
"
" ----------------------------------------------------------------------------
set nospell

" Initially off
" spelunker drastically reduces performance when opening large files
let g:enable_spelunker_vim = 0


" ### Zl            - Suggest correction for current word
" ### ZL            - Suggest correction for all occurrences of current word
" ### ZN            - (N)ext misspelled word
" ### ZP            - (P)revious misspelled word
" ### ZC            - (C)orrect all occurrences of current misspelled word
" ### ZT            - (T)oggle spelunker



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

" Ale warning highlights
let g:ale_set_highlights = 1

let g:js_file_import_strip_file_extension = 0

" ### \gt           - toggle ale
nnoremap <leader>gt :ALEToggle<CR>

" ### \go           - (g)(o) to definition
nnoremap <leader>go :ALEGoToDefinition<CR>

" ### \gb           - (g)o (b)ack
nnoremap <leader>gb :pop<CR>

" ### \gp           - previous error
nnoremap <leader>gp :ALEPreviousWrap<CR>

" ### \gn           - next error
nnoremap <leader>gn :ALENextWrap<CR>

" ### \gh           - show hover details
nnoremap <leader>gh :ALEHover<CR>

" ### \gg           - Re-indent file
nnoremap <leader>gg mggg=G`g

" ### \gf           - use ale to auto-fix lint
" Copied from ale source code - called Fix rather than ALEFix
command! -bar -nargs=* -complete=customlist,ale#fix#registry#CompleteFixers Fix :call ale#fix#Fix(bufnr(''), '', <f-args>)
nmap <leader>gf :Fix<Enter>

" ### \gm           - show lint/type issues with current line
" Copied from ale source code - called More rather than ALEDetail
command! -bar More :call ale#cursor#ShowCursorDetail()
nmap <leader>gm :More<Enter>

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
" ### --- NERD tree ---
"
" ----------------------------------------------------------------------------
" ### <TAB>         - Open NERD tree
map <Tab> :NERDTreeToggle<CR>

" ### \<TAB>[hjkl]  - Move to corresponding split
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
" --- Help ---
"
" ----------------------------------------------------------------------------
silent! helptags ALL



" Put these lines at the very end of your vimrc file.
" packloadall " -- ?
