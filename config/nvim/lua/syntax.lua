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

--- \go           - (g)(o) to definition
--- \gp           - previous usage
--- \gn           - next usage
--- \gd           - list definitions
--- \gr           - smart rename
--- \gg           - Re-indent file
vim.api.nvim_set_keymap('n', '<leader>gg', 'mnggVG=<escape>`n', {noremap = true})

-- - \gh           - show hover details
-- - \gf           - use ale to auto-fix lint
-- - \gm           - show lint/type issues with current line

require('treesitter-context.config').setup {
  enable = true,
}
