
" Custom help
" ### :Help          - print this help
command! -nargs=? -bar -bang Help echo system("awk -F'\" ###' '/^\" ###/ { print $2 }' ~/.nvimrc")


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
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set foldlevelstart=20

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
--  require('numb').setup{}
require('compe').setup{}
require('hop').setup{}
vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require'hop'.hint_words()<cr>", {})
-- require('nvim_comment').setup{}
require('shade').setup({
  overlay_opacity = 70,
})
require('telescope').setup{}
require("toggleterm").setup{
  open_mapping = "\\t",
  direction = 'float',
}
require("trouble").setup{}

vim.api.nvim_set_keymap('n', '<leader>gf', '<cmd>vim.lsp.buf.code_action()<cr>', {expr = true, noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>gf', 'vim.lsp.buf.range_code_action()', {expr = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)

--  treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  ignore_install = { "haskell" }, -- haskell broken?
  highlight = {
    enable = {enabled = true, use_languagetree = true},
    additional_vim_regex_highlighting = true,
  },
  autotag = {enable = true},
  indent = {enable = true},
  refactor = {
    highlight_definitions = { enable = true },
    -- highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<leader>gr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "<leader>go",
        list_definitions = "<leader>gd",
        goto_next_usage = "<leader>gn",
        goto_previous_usage = "<leader>gp",
      },
    },
  },
}
-- ### \go           - (g)(o) to definition
-- ### \gp           - previous usage
-- ### \gn           - next usage
-- ### \gg           - Re-indent file

-- ### \gh           - show hover details
-- ### \gf           - use ale to auto-fix lint
-- ### \gm           - show lint/type issues with current line

require('treesitter-context.config').setup {
  enable = true,
}

-- nvim_tree
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_auto_open = 1

-- nvim-lspconfig
-- npm i -g bash-language-server graphql-language-service-cli flow-bin typescript-language-server vscode-langservers-extracted vim-language-server eslint_d
-- brew install efm-langserver
require('lspconfig').bashls.setup{}
require('lspconfig').cssls.setup{}
-- local eslint = {
--   lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"},
--   lintIgnoreExitCode = true,
--   formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
--   formatStdin = true,
--   rootPatterns = { '.git' },
--   parseJson = {
--     errorsRoot = '[0].messages',
--     line = 'line',
--     column = 'column',
--     endLine = 'endLine',
--     endColumn = 'endColumn',
--     message = '[eslint] ${message} [${ruleId}]',
--     security = 'severity'
-- },
-- }
-- local function eslint_config_exists()
--   local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)
--   if not vim.tbl_isempty(eslintrc) then
--     return true
--   end
--   if vim.fn.filereadable("package.json") then
--     if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
--       return true
--     end
--   end
--   return false
-- end
-- require('lspconfig').efm.setup {
--   -- on_attach = function(client)
--   --   client.resolved_capabilities.document_formatting = true
--   --   client.resolved_capabilities.goto_definition = false
--   --   -- set_lsp_config(client)
--   -- end,
--   -- root_dir = function()
--   --   if not eslint_config_exists() then
--   --     return nil
--   --   end
--   --   return vim.fn.getcwd()
--   -- end,
--   linters = { eslint },
--   formatters = { eslint },
--   settings = {
--     languages = {
--       javascript = {eslint},
--       javascriptreact = {eslint},
--       ["javascript.jsx"] = {eslint},
--       typescript = {eslint},
--       ["typescript.tsx"] = {eslint},
--       typescriptreact = {eslint}
--     }
--   },
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescript.tsx",
--     "typescriptreact"
--   },
-- }
-- function _lsp_definitions(opts)
--   return list_or_jump('textDocument/definition', 'LSP Definitions', opts)
-- end
-- function _lsp_on_attach(client, bufnr)
--   local function buf_map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
-- 
--   -- Set up keymaps
--   local opts = {noremap = true, silent = true}
--   buf_map('n', '<c-]>', [[<cmd>lua _lsp_definitions()<cr>]], opts)
--   buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
--   buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
--   buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
--   buf_map('n', 'gr', [[<cmd>lua require'telescope.builtin'.lsp_references()<cr>]], opts)
-- 
--   buf_map('n', 'K', [[<cmd>lua vim.lsp.buf.hover()<cr>]], opts)
--   buf_map('n', '<space>rn', [[<cmd>lua vim.lsp.buf.rename()<CR>]], opts)
--   buf_map('n', '<leader>ca', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], opts)
-- 
--   -- Navigate diagnostics
--   buf_map('n', '[g', [[<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>]], opts)
--   buf_map('n', ']g', [[<cmd>lua vim.lsp.diagnostic.goto_next()<cr>]], opts)
--   -- Show diagnostics popup with <leader>d
--   buf_map('n', '<leader>d', [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'single' })<cr>]], opts)
-- 
--   if client.resolved_capabilities.document_formatting then
--     vim.cmd [[augroup LspFormatting]]
--     vim.cmd [[autocmd! * <buffer>]]
--     vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
--     vim.cmd [[augroup END]]
--   end
-- end
-- 
-- local eslint_lint = {
--   lintCommand = 'eslint_d -f ~/eslint-formatter-vim.js --stdin --stdin-filename ${INPUT}',
--   lintIgnoreExitCode = true,
--   lintStdin = true,
--   lintFormats = {'%f:%l:%c:%t: %m'},
-- }
-- 
-- local eslint_format = {
--   formatCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT} --fix-to-stdout',
--   formatStdin = true,
--   FormatStdin = true,
--   ["format-stdin"] = true
-- }
-- 
-- local prettier = {
--   formatCommand = './node_modules/.bin/prettier --stdin-filepath ${INPUT}',
--   formatStdin = true,
-- }
-- 
-- local stylelint = {
--   lintCommand = './node_modules/.bin/stylelint --cache --formatter unix --stdin-filename ${INPUT}',
--   lintIgnoreExitCode = true,
--   lintStdin = true,
--   lintFormats = {'%f:%l:%c: %m [%trror]'}
-- }
-- 
-- local function file_exists(name)
--   local f = io.open(name, 'r')
--   if f ~= nil then
--     io.close(f)
--     return true
--   else
--     return false
--   end
-- end
-- 
-- local eslint_or_prettier_format = file_exists('.eslintrc.js')
--   and eslint_format
--   or prettier
-- 
-- require('lspconfig').efm.setup {
--   on_attach = _lsp_on_attach,
--   root_dir = require('lspconfig').util.root_pattern('package.json'),
--   filetypes = {'typescript', 'typescriptreact', 'vue', 'javascript', 'javascriptreact'},
--   init_options = {
--     documentFormatting = true,
--   },
--   settings = {
--     rootMarkers = {'package.json'},
--     languages = {
--       typescript = {eslint_lint, eslint_or_prettier_format},
--       typescriptreact = {eslint_lint, eslint_or_prettier_format},
--       javascript = {eslint_lint, eslint_or_prettier_format},
--       vue = {eslint_lint, stylelint, prettier},
--       scss = {stylelint, prettier},
--     },
--   },
-- }
require('lspconfig').flow.setup{
--   on_attach = function(client)
--     if client.config.flags then
--       client.config.flags.allow_incremental_sync = true
--     end
--     client.resolved_capabilities.document_formatting = false
--     -- set_lsp_config(client)
--   end,
}
require('lspconfig').graphql.setup{}
require('lspconfig').html.setup{}
require('lspconfig').jsonls.setup{}
require('lspconfig').rust_analyzer.setup{}
-- require('lspconfig').tsserver.setup{
--   on_attach = function(client)
--     if client.config.flags then
--       client.config.flags.allow_incremental_sync = true
--     end
--     client.resolved_capabilities.document_formatting = false
--     -- set_lsp_config(client)
--   end,
--   -- default
--   -- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
--   filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
-- }
require('lspconfig').vimls.setup{}


-- statusline attempt
local cmd = vim.cmd
local fn = vim.fn
local gl = require("galaxyline")
local section = gl.section
gl.short_line_list = {"LuaTree", "packager", "Floaterm", "coc-explorer"}

local nord_colors = {
  bg = "NONE",
  -- bg = "#2E3440",
  fg = "#81A1C1",
  line_bg = "NONE",
  lbg = "NONE",
  -- lbg = "#3B4252",
  fg_green = "#8FBCBB",
  yellow = "#EBCB8B",
  cyan = "#A3BE8C",
  darkblue = "#81A1C1",
  green = "#8FBCBB",
  orange = "#D08770",
  purple = "#B48EAD",
  magenta = "#BF616A",
  gray = "#616E88",
  blue = "#5E81AC",
  red = "#BF616A"
}

local buffer_not_empty = function()
  if fn.empty(fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

section.left[1] = {
  FirstElement = {
    -- provider = function() return '▊ ' end,
    provider = function()
      return "  "
    end,
    highlight = {nord_colors.blue, nord_colors.line_bg}
  }
}
section.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
        n = nord_colors.magenta,
        i = nord_colors.green,
        v = nord_colors.blue,
        [""] = nord_colors.blue,
        V = nord_colors.blue,
        c = nord_colors.red,
        no = nord_colors.magenta,
        s = nord_colors.orange,
        S = nord_colors.orange,
        [""] = nord_colors.orange,
        ic = nord_colors.yellow,
        R = nord_colors.purple,
        Rv = nord_colors.purple,
        cv = nord_colors.red,
        ce = nord_colors.red,
        r = nord_colors.cyan,
        rm = nord_colors.cyan,
        ["r?"] = nord_colors.cyan,
        ["!"] = nord_colors.red,
        t = nord_colors.red
      }
      cmd("hi GalaxyViMode guifg=" .. mode_color[fn.mode()])
      return "     "
    end,
    highlight = {nord_colors.red, nord_colors.line_bg, "bold"}
  }
}
section.left[3] = {
  FileIcon = {
    provider = "FileIcon",
    condition = buffer_not_empty,
    highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, nord_colors.line_bg}
  }
}
section.left[4] = {
  FileName = {
    -- provider = "FileName",
    provider = function()
      return fn.expand("%:F")
    end,
    condition = buffer_not_empty,
    separator = " ",
    separator_highlight = {nord_colors.purple, nord_colors.bg},
    highlight = {nord_colors.purple, nord_colors.line_bg, "bold"}
  }
}

section.right[1] = {
  GitIcon = {
    provider = function()
      return " "
    end,
    condition = require("galaxyline.provider_vcs").check_git_workspace,
    highlight = {nord_colors.orange, nord_colors.line_bg}
  }
}
section.right[2] = {
  GitBranch = {
    provider = "GitBranch",
    condition = require("galaxyline.provider_vcs").check_git_workspace,
    separator = "",
    separator_highlight = {nord_colors.purple, nord_colors.bg},
    highlight = {nord_colors.orange, nord_colors.line_bg, "bold"}
  }
}

local checkwidth = function()
  local squeeze_width = fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

section.right[3] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = " ",
    highlight = {nord_colors.green, nord_colors.line_bg}
  }
}
section.right[4] = {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = "柳",
    highlight = {nord_colors.yellow, nord_colors.line_bg}
  }
}
section.right[5] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = " ",
    highlight = {nord_colors.red, nord_colors.line_bg}
  }
}

section.right[6] = {
  LineInfo = {
    provider = "LineColumn",
    separator = "",
    separator_highlight = {nord_colors.blue, nord_colors.line_bg},
    highlight = {nord_colors.gray, nord_colors.line_bg}
  }
}
-- section.right[7] = {
--   FileSize = {
--     provider = "FileSize",
--     separator = " ",
--     condition = buffer_not_empty,
--     separator_highlight = {nord_colors.blue, nord_colors.line_bg},
--     highlight = {nord_colors.fg, nord_colors.line_bg}
--   }
-- }

section.right[8] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    separator = " ",
    icon = " ",
    highlight = {nord_colors.red, nord_colors.line_bg},
    separator_highlight = {nord_colors.bg, nord_colors.bg}
  }
}
section.right[9] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    -- separator = " ",
    icon = " ",
    highlight = {nord_colors.yellow, nord_colors.line_bg},
    separator_highlight = {nord_colors.bg, nord_colors.bg}
  }
}

section.right[10] = {
  DiagnosticInfo = {
    -- separator = " ",
    provider = "DiagnosticInfo",
    icon = " ",
    highlight = {nord_colors.green, nord_colors.line_bg},
    separator_highlight = {nord_colors.bg, nord_colors.bg}
  }
}

section.right[11] = {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    -- separator = " ",
    icon = " ",
    highlight = {nord_colors.blue, nord_colors.line_bg},
    separator_highlight = {nord_colors.bg, nord_colors.bg}
  }
}

section.short_line_left[1] = {
  BufferType = {
    provider = "FileIcon",
    separator = " ",
    separator_highlight = {"NONE", nord_colors.lbg},
    highlight = {nord_colors.blue, nord_colors.lbg, "bold"}
  }
}

section.short_line_left[2] = {
  SFileName = {
    provider = function()
      local fileinfo = require("galaxyline.provider_fileinfo")
      local fname = fileinfo.get_current_file_name()
      for _, v in ipairs(gl.short_line_list) do
        if v == vim.bo.filetype then
          return ""
        end
      end
      return fname
    end,
    condition = buffer_not_empty,
    highlight = {nord_colors.white, nord_colors.lbg, "bold"}
  }
}

section.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    highlight = {nord_colors.fg, nord_colors.lbg}
  }
}

EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" nvim_tree
" ### \e            - Open file tree
nnoremap <leader>e :NvimTreeToggle<CR>

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

" ### \\            - hop: jump words



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
" --- Help ---
"
" ----------------------------------------------------------------------------
silent! helptags ALL
