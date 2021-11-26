require('compe').setup{}

require('hop').setup{}
---
--- \\            - hop
vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require'hop'.hint_words()<cr>", {})

-- some issue with not being able to close the last window
require('shade').setup({
  overlay_opacity = 70,
})

require('telescope').setup{}
require('telescope').load_extension('fzf')

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

---
--- \go           - (g)(o) to definition
--- \gp           - previous usage
--- \gn           - next usage
--- \gd           - list definitions
--- \gr           - smart rename
-- - \gg           - Re-indent file

-- - \gh           - show hover details
-- - \gf           - use ale to auto-fix lint
-- - \gm           - show lint/type issues with current line

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
---
--- nvim-tree navigation
--- o           - open file/toggle directory
--- <TAB>       - preview file
--- <C-v>       - open in vertical split
--- <C-x>       - open in horizontal split
--- <C-t>       - open in new tab
--- <BS>        - close directory
--- -           - nav to parent directory
-- --- O           - set directory as root
---
--- nvim-tree edit tree
--- a           - add file (use trailing slash to create directory)
--- r           - rename file
--- <C-r>       - rename file omitting current name
--- d           - delete file
--- x           - add file to cut clipboard
--- c           - add file to copy clipboard
--- p           - paste file from clipboard
---
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

local buffer_not_empty = function()
  if fn.empty(fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

local is_in_short_list = function()
  for _, v in ipairs(gl.short_line_list) do
    if v == vim.bo.filetype then
      return true
    end
  end
  return false
end

local function parent_pathname(path)
  local i = path:find("[\\/:][^\\/:]*$")
  if not i then return end
  return path:sub(1, i-1)
end

section.left[1] = {
  FirstElement = {
    provider = function() return " " end,
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
      vim.cmd("hi GalaxyViMode guifg=" .. mode_color[fn.mode()])
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
      local vcs = require('galaxyline.provider_vcs')
      local fileinfo = require('galaxyline.provider_fileinfo')
      local git_dir = parent_pathname(vcs.get_git_dir())
      return fn.expand("%:p"):gsub(git_dir .. '/', '')
    end,
    condition = buffer_not_empty,
    separator = " ",
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.purple, colors.line_bg, "bold"}
  }
}
section.left[5] = {
  TotalLine = {
    provider = function()
      local total_line = vim.fn.line('$')
      return total_line
    end,
    condition = buffer_not_empty,
    separator = " ",
    separator_highlight = {colors.blue, colors.bg},
    highlight = {colors.blue, colors.line_bg, "bold"}
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
    provider = function()
      local fileinfo = require('galaxyline.provider_fileinfo')
      local fileicon = fileinfo.get_file_icon()
      if is_in_short_list() then
        return ""
      end
      return fileicon
    end,
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
      if is_in_short_list() then
        return ""
        -- return vim.bo.filetype
      end
      return fname
    end,
    condition = buffer_not_empty,
    highlight = {colors.white, colors.lbg, "bold"}
  }
}
section.short_line_right[1] = {
  BufferIcon = {
    provider = function()
      local buffer = require('galaxyline.provider_buffer')
      local buffericon = buffer.get_buffer_type_icon()
      if is_in_short_list() then
        return ""
      end
      return buffericon
    end,
    highlight = {colors.fg, colors.lbg}
  }
}
