--  require('numb').setup{}
require('compe').setup{}
require('hop').setup{}
vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require'hop'.hint_words()<cr>", {})
-- require('nvim_comment').setup{}
-- some issue with not being able to close the last window
-- require('shade').setup({
--   overlay_opacity = 70,
-- })
require('telescope').setup{}
require("toggleterm").setup{
  open_mapping = "\\t",
  direction = 'float',
}
require("trouble").setup{}

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
--- nvim-tree visibility
--- <leader>e   - open tree
--- I           - toggle git hidden files
--- H           - toggle dotfiles
--- R           - refresh tree
--- nvim-tree navigation
--- o           - open file/toggle directory
--- <TAB>       - preview file
--- <C-v>       - open in vertical split
--- <C-x>       - open in horizontal split
--- <C-t>       - open in new tab
--- <BS>        - close directory
--- -           - nav to parent directory
-- --- O           - set directory as root
--- nvim-tree edit tree
--- a           - add file (use trailing slash to create directory)
--- r           - rename file
--- <C-r>       - rename file omitting current name
--- d           - delete file
--- x           - add file to cut clipboard
--- c           - add file to copy clipboard
--- p           - paste file from clipboard
--- nvim-tree yanking
--- y           - add name to copy clipboard
--- Y           - add relative path to copy clipboard
--- gy          - add absolute path to copy clipboard

-- nvim-lspconfig
-- npm i -g bash-language-server graphql-language-service-cli flow-bin typescript-language-server vscode-langservers-extracted vim-language-server eslint_d
-- brew install efm-langserver
require('lspconfig').bashls.setup{}
require('lspconfig').cssls.setup{}
require('lspconfig').flow.setup{}
require('lspconfig').graphql.setup{}
require('lspconfig').html.setup{}
require('lspconfig').jsonls.setup{}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').tsserver.setup{
  -- default
  -- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
}
require('lspconfig').vimls.setup{}


-- set short list for terminal
-- function _changeTerminalFileType()
-- 	vim.api.nvim_command('setlocal filetype=term ')
-- end
-- vim.api.nvim_command("autocmd TermOpen * :lua _changeTerminalFileType()")

local cmd = vim.cmd
local fn = vim.fn
local gl = require("galaxyline")
local section = gl.section
gl.short_line_list = { 'packer', 'NvimTree', "packager", "toggleterm"}
local colors = {
  bg = "NONE",
  fg = "#81A1C1",
  line_bg = "NONE",
  lbg = "NONE",
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
-- " fill it with absolute colors
-- let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
-- let s:gb.dark0       = ['#282828', 235]     " 40-40-40
-- let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
-- let s:gb.dark1       = ['#3c3836', 237]     " 60-56-54
-- let s:gb.dark2       = ['#504945', 239]     " 80-73-69
-- let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
-- let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
-- let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100
-- 
-- let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
-- let s:gb.gray_244    = ['#928374', 244]     " 146-131-116
-- 
-- let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
-- let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
-- let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
-- let s:gb.light1      = ['#ebdbb2', 223]     " 235-219-178
-- let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
-- let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
-- let s:gb.light4      = ['#a89984', 246]     " 168-153-132
-- let s:gb.ligh_256  = ['#a89984', 246]     " 168-153-132
-- 
-- let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
-- let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
-- let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
-- let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
-- let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
-- let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
-- let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25
-- 
-- let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
-- let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
-- let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
-- let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
-- let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
-- let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
-- let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14
-- 
-- let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
-- let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
-- let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
-- let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
-- let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
-- let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
-- let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

local buffer_not_empty = function()
  if fn.empty(fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end
section.left[1] = {
  FirstElement = {
    provider = function() return "  " end,
    highlight = {colors.blue, colors.line_bg}
  }
}
section.left[2] = {
  ViMode = {
    provider = function()
      local mode_color = {
        n = colors.magenta,
        i = colors.green,
        v = colors.blue,
        [""] = colors.blue,
        V = colors.blue,
        c = colors.red,
        no = colors.magenta,
        s = colors.orange,
        S = colors.orange,
        [""] = colors.orange,
        ic = colors.yellow,
        R = colors.purple,
        Rv = colors.purple,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.red,
        t = colors.red
      }
      local alias = {n = 'NORMAL',i = 'INSERT',c= 'COMMAND',v= 'VISUAL',V= 'VISUAL LINE', [''] = 'VISUAL BLOCK',t='TERMINAL'}
      cmd("hi GalaxyViMode guifg=" .. mode_color[fn.mode()])
      return alias[fn.mode()]
    end,
    separator = " ",
    highlight = {colors.red, colors.line_bg, "bold"}
  }
}
section.left[3] = {
  FileIcon = {
    provider = "FileIcon",
    condition = buffer_not_empty,
    highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.line_bg}
  }
}
section.left[4] = {
  FileName = {
    provider = function()
      return fn.expand("%:F")
    end,
    condition = buffer_not_empty,
    separator = " ",
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.purple, colors.line_bg, "bold"}
  }
}
section.right[1] = {
  GitBranch = {
    provider = "GitBranch",
    condition = require("galaxyline.provider_vcs").check_git_workspace,
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.orange, colors.line_bg, "bold"}
  }
}
section.right[2] = {
  LineInfo = {
    provider = "LineColumn",
    separator = " ",
    separator_highlight = {colors.blue, colors.line_bg},
    highlight = {colors.gray, colors.line_bg}
  }
}
section.right[3] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    separator = " ",
    icon = " ",
    highlight = {colors.red, colors.line_bg},
    separator_highlight = {colors.bg, colors.bg}
  }
}
section.right[4] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = " ",
    highlight = {colors.yellow, colors.line_bg},
    separator_highlight = {colors.bg, colors.bg}
  }
}
section.right[5] = {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = " ",
    highlight = {colors.green, colors.line_bg},
    separator_highlight = {colors.bg, colors.bg}
  }
}
section.right[6] = {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = " ",
    highlight = {colors.blue, colors.line_bg},
    separator_highlight = {colors.bg, colors.bg}
  }
}
section.short_line_left[1] = {
  BufferType = {
    provider = "FileIcon",
    separator = " ",
    separator_highlight = {"NONE", colors.lbg},
    highlight = {colors.blue, colors.lbg, "bold"}
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
    highlight = {colors.white, colors.lbg, "bold"}
  }
}
section.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    highlight = {colors.fg, colors.lbg}
  }
}
