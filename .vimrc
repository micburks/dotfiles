"set nocompatible              " be iMproved, required
"filetype off                  " required
"
"" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"" alternatively, pass a path where Vundle should install plugins
""call vundle#begin('~/some/path/here')
"
"" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
"
"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" plugin on GitHub repo
"" Plugin 'tpope/vim-fugitive'
"
"" plugin from http://vim-scripts.org/vim/scripts.html
"" Plugin 'L9'
"
"" Git plugin not hosted on GitHub
"" Plugin 'git://git.wincent.com/command-t.git'
"
"" git repos on your local machine (i.e. when working on your own plugin)
"" Plugin 'file:///home/gmarik/path/to/plugin'
"
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"
"" Avoid a name conflict with L9
"" Plugin 'user/L9', {'name': 'newL9'}
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
"" To ignore plugin indent changes, instead use:
""filetype plugin on
""
"" Brief help
"" :PluginList       - lists configured plugins
"" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"" :PluginSearch foo - searches for foo; append `!` to refresh local cache
"" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
""
"" see :h vundle for more details or wiki for FAQ
"" Put your non-Plugin stuff after this line










" Non-plugin settings

set number
set paste
syntax on

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
" call togglebg#map("<F5")




