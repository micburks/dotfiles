
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

" ### \ff           - Telescope find_files
nnoremap <leader>ff <cmd>Telescope find_files<cr>
" ### \fg           - Telescope live_grep
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" ### \fb           - Telescope buffers
nnoremap <leader>fb <cmd>Telescope buffers<cr>
" ### \fh           - Telescope help_tags
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



" ----------------------------------------------------------------------------
"
" ###
" ### --- Folds ---
"
" ----------------------------------------------------------------------------
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=20

" ### :set fdm      - set fold method [manual, syntax, indent]
" ### zo            - (o)pen fold
" ### zr            - open all folds one level (R for all levels)
" ### zc            - (c)lose fold
" ### zm            - close all folds one level (M for all levels)


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

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
noremap j gj
noremap k gk



" ----------------------------------------------------------------------------
"
" ###
" ### --- Plugin configuration ---
"
" ----------------------------------------------------------------------------
lua <<EOF
-- numb
--  require('numb').setup{}

--  treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = "all",
  ignore_install = { "haskell" },
  rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 1000 -- Do not enable for files with more than 1000 lines, int
  },
  refactor = {
      highlight_definitions = {enable = true},
      highlight_current_scope = {enable = true},
      smart_rename = {
          enable = true,
          keymaps = {smart_rename = "grr"},
          navigation = {
              enable = true,
              keymaps = {
                  goto_definition = "gnd",
                  list_definitions = "gnD",
                  list_definitions_toc = "gO",
                  goto_next_usage = "<a-*>",
                  goto_previous_usage = "<a-#>"
              }
          }
      }
  },
  highlight = {enable = {enabled = true, use_languagetree = true}},
  autotag = {enable = true},
  indent = {enable = true},
}

-- nvim-telescope
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "top",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

-- trouble
require("trouble").setup {}

-- nvim-comment
-- require('nvim_comment').setup{}

-- nvim_tree
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_width_allow_resize = 1
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_lsp_diagnostics = 1

-- nvimux
-- local nvimux = require('nvimux')
-- 
-- -- Nvimux configuration
-- nvimux.config.set_all{
--   prefix = '<C-z>',
--   new_window = 'enew', -- Use 'term' if you want to open a new term for every new window
--   new_tab = nil, -- Defaults to new_window. Set to 'term' if you want a new term for every new tab
--   new_window_buffer = 'single',
--   quickterm_direction = 'botright',
--   quickterm_orientation = 'vertical',
--   quickterm_scope = 't', -- Use 'g' for global quickterm
--   quickterm_size = '80',
-- }
-- 
-- -- Nvimux custom bindings
-- nvimux.bindings.bind_all{
--   {'s', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
--   {'v', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
-- }
-- 
-- -- Required so nvimux sets the mappings correctly
-- nvimux.bootstrap()

-- shade
require'shade'.setup({
  overlay_opacity = 70,
})

-- toggleterm
require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  open_mapping = "\\t",
  hide_numbers = true, -- hide the number column in toggleterm buffers
  start_in_insert = true,
  persist_size = true,
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
}

-- nvim-lspconfig
require'lspconfig'.bashls.setup{}
require('lspconfig').cssls.setup{}
require'lspconfig'.flow.setup{}
require('lspconfig').graphql.setup{}
require'lspconfig'.html.setup{}
require('lspconfig').jsonls.setup{}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').tsserver.setup{}
require'lspconfig'.vimls.setup{}

-- npm i -g bash-language-server graphql-language-service-cli flow-bin typescript-language-server vscode-langservers-extracted vim-language-server
-- 

EOF

" nvim-compe
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" nvim_tree
" ### <TAB>         - Open file tree
nnoremap <tab> :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" ### \<TAB>[hjkl]  - Move to corresponding split
nnoremap <silent> <leader><tab>h <C-w>h
nnoremap <silent> <leader><tab>j <C-w>j
nnoremap <silent> <leader><tab>k <C-w>k
nnoremap <silent> <leader><tab>l <C-w>l

" ### arrow keys    - Move to corresponding split
nnoremap <silent> <left> <C-w><left><CR>
nnoremap <silent> <down> <C-w><down><CR>
nnoremap <silent> <up> <C-w><up><CR>
nnoremap <silent> <right> <C-w><right><CR>

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
" ### colo ARG      - colorscheme [gruvbox,iceberg,nordisk,pulumi,zenburn]

colorscheme gruvbox
" colorscheme iceberg
" colorscheme nordisk
" colorscheme pulumi
" colorscheme zenburn

" colorizer
" lua <<EOF
" require'colorizer'.setup({'html', 'css', 'javascript'}, {
"     RGB = true,
"     RRGGBB = true,
"     RRGGBBAA = true,
"     names = true,
"     rgb_fn = true,
"     hsl_fn = true,
"     css = true,
"     css_fn = true,
"     mode = 'foreground',
" })
" EOF


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


"" ### \gt           - toggle ale
"" ### \go           - (g)(o) to definition
"" ### \gb           - (g)o (b)ack
"" ### \gp           - previous error
"" ### \gn           - next error
"" ### \gh           - show hover details
"" ### \gg           - Re-indent file
"" ### \gf           - use ale to auto-fix lint
"" ### \gm           - show lint/type issues with current line



" ----------------------------------------------------------------------------
"
" --- Help ---
"
" ----------------------------------------------------------------------------
silent! helptags ALL
