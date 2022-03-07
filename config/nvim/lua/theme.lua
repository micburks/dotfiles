local fn = vim.fn
local gl = require("galaxyline")
local providers = {
  fileinfo = require("galaxyline.provider_fileinfo"),
  vcs = require("galaxyline.provider_vcs"),
  buffer = require("galaxyline.provider_buffer")
}

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
    highlight = {providers.fileinfo.get_file_icon_color, colors.line_bg}
  }
}
section.left[4] = {
  FileName = {
    provider = function()
      local vcs = providers.vcs
      local git_dir = vcs.get_git_dir()
      if git_dir == nil then
        return fn.expand("%:p")
      else 
        return fn.expand('%:p'):sub(git_dir:len() - 3)
      end
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
    condition = providers.vcs.check_git_workspace,
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
      local fileinfo = providers.fileinfo
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
      local fileinfo = providers.fileinfo
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
      local buffer = providers.buffer
      local buffericon = buffer.get_buffer_type_icon()
      if is_in_short_list() then
        return ""
      end
      return buffericon
    end,
    highlight = {colors.fg, colors.lbg}
  }
}
