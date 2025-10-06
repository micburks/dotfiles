return {
  {
    "shaunsingh/nord.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme nord]])
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      }
  },
  {
-- # nvim-tree
-- TODO: remove nvim-tree help since you can find it via nvim-tree g? ??
---nvim-tree - g?            - open help
--
-- ## visibility
---nvim-tree.visibility - <leader>e     - open tree
---nvim-tree.visibility - <leader>w     - find current file in tree
---nvim-tree.visibility - q             - close tree
---nvim-tree.visibility - I             - toggle git hidden files
---nvim-tree.visibility - H             - toggle dotfiles
---nvim-tree.visibility - R             - refresh tree
--
--
-- ## navigation
---nvim-tree.navigation - o             - open file/toggle directory
---nvim-tree.navigation - <BS>          - close directory
---nvim-tree.navigation - P             - jump to parent directory
---nvim-tree.navigation - </>           - jump to prev/next sibling
---nvim-tree.navigation - -             - set parent directory as root
---nvim-tree.navigation - <C-]>         - set directory as root
---nvim-tree.navigation - <TAB>         - preview file
---nvim-tree.navigation - <C-v>         - open in vertical split
---nvim-tree.navigation - <C-x>         - open in horizontal split
---nvim-tree.navigation - <C-t>         - open in new tab
---nvim-tree.navigation - s             - open with system default application
--
--
-- ## edit tree
---nvim-tree.edit - a             - add file (use trailing slash to create directory)
---nvim-tree.edit - r             - rename file
---nvim-tree.edit - <C-r>         - rename file omitting current name
---nvim-tree.edit - d             - delete file
---nvim-tree.edit - x             - add file to cut clipboard
---nvim-tree.edit - c             - add file to copy clipboard
---nvim-tree.edit - p             - paste file from clipboard
--
--
-- ## yanking
---nvim-tree.yanking - y             - add name to copy clipboard
---nvim-tree.yanking - Y             - add relative path to copy clipboard
---nvim-tree.yanking - gy            - add absolute path to copy clipboard
    "nvim-tree/nvim-tree.lua",
    opts = {
      -- open_on_setup = true,
      view = {
        width = 40,
      },
      git = {
        enable = false,
      },
    },
    keys = {
      {"<leader>w", "<cmd>NvimTreeFindFile<cr>", desc = "Open tree for this file"},
      {"<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle tree"},
      {"<leader>y", "<cmd>NvimTreeClose<cr><C-w>r<cmd>NvimTreeOpen<cr><C-w><right>", desc = "Swap splits"},
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
}
