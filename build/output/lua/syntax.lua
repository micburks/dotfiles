-- # treesitter

require('packer').startup(function()
  use 'RRethy/nvim-treesitter-textsubjects'
end)

---editing - <space>g      - Re-indent file (treesitter)
vim.api.nvim_set_keymap('n', '<space>g', 'mnggVG=<escape>`n', {noremap = true})
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
    --
    -- renaming through lsp works across entire workspace
    -- -- use <space>rn instead
    -- smart_rename = {
    --   enable = true,
    --   keymaps = {
    -- ---treesitter - \gr           - smart rename
    --     smart_rename = "<leader>gr",
    --   },
    -- },
    navigation = {
      enable = true,
      keymaps = {
-- doesn't work as well as lsp
        goto_definition = "<Nop>", -- "<leader>go",
        list_definitions_toc = "<Nop>", -- "gO",
-- ---movement - gd            - goto_definition_lsp_fallback, lsp.buf.definition fallback (treesitter)
        goto_definition_lsp_fallback = "gd",
---diagnostics - \d            - list definitions (treesitter)
        list_definitions = "<leader>d",
---movement - gn            - next usage (treesitter)
        goto_next_usage = "gn",
---movement - gp            - previous usage (treesitter)
        goto_previous_usage = "gp",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
-- ## textobjects
---textobjects - f             - function (treesitter)
---textobjects - c             - class (treesitter)
---textobjects - b             - block (treesitter)
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
--
-- ## swap
---editing - <space>a      - move parameter to right (treesitter)
---editing - <space>A      - move parameter to left (treesitter)
    swap = {
      enable = true,
      swap_next = {
        ["<space>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<space>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
-- unnecessary
--       goto_next_start = {
--         ["]m"] = "@function.outer",
--         ["]]"] = "@class.outer",
--       },
--       goto_next_end = {
--         ["]M"] = "@function.outer",
--         ["]["] = "@class.outer",
--       },
--       goto_previous_start = {
--         ["[m"] = "@function.outer",
--         ["[["] = "@class.outer",
--       },
--       goto_previous_end = {
--         ["[M"] = "@function.outer",
--         ["[]"] = "@class.outer",
--       },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
---diagnostics - \b            - peek function outer definition (treesitter)
        ["<leader>b"] = "@function.outer",
---diagnostics - \c            - peek class outer definition (treesitter)
        ["<leader>c"] = "@class.outer",
      },
    },
  },
  textsubjects = {
    enable = true,
---textobjects - ,             - textsubject previous selection (treesitter)
    prev_selection = ',',
    keymaps = {
---textobjects - .             - textsubject-smart (treesitter)
      ['.'] = 'textsubjects-smart',
    },
  },
}

require('treesitter-context.config').setup {
  enable = true,
}
