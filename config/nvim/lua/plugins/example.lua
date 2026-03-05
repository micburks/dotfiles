-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    -- # toggleterm
    ---terminal - \t            - open first terminal
    ---terminal - X\t           - open numbered terminal
    "akinsho/toggleterm.nvim",
    lazy = false,
    cmd = "ToggleTerm",
    opts = {
      open_mapping = "\\t",
      direction = "float",
    },
    keys = {
      ---terminal - \e            - enter normal mode in toggleterm
      { "<leader>e", "<C-\\><C-n>", desc = "Enter normal mode in terminal", mode = "t" },
      ---terminal - \g            - lazygit terminal (arrow keys, enter, space, q)
      {
        "<leader>g",
        --lazygit_toggle
        function()
          local Terminal = require("akinsho/toggleterm.nvim").Terminal
          local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, count = 5 })
          lazygit:toggle()
        end,
        desc = "Open lazygit terminal (arrow keys, enter, space, q)",
      },
      ---terminal - \q            - show filtered git history for current file
      {
        "<leader>q",
        -- lazygit_filtercurrentfile
        function()
          local Terminal = require("akinsho/toggleterm.nvim").Terminal
          local current_file = vim.fn.expand("%:p"):sub(vim.g.root:len() + 2)
          local lazygit_filter = Terminal:new({ cmd = "lazygit " .. "-f " .. current_file, hidden = true, count = 5 })
          lazygit_filter:toggle()
        end,
        desc = "Show filtered git history for current file",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
      options = {
        max_name_length = 50,
        --tab_size = 18,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      -- enable_git_status = false, -- this causes the UI to block when changing files
      enable_diagnostics = false,
      -- Ensure bind_to_cwd is set to true to have Neo-tree follow the current working directory changes
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          "node_modules",
          "out",
          ".git",
          ".cache",
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true, -- Only follow when tree is open
        },
      },
      use_libuv_file_watcher = true, -- Much faster
    },

    keys = {
      {
        "<leader>e",
        function()
          local parent_dir = vim.fn.expand("%:p:h")
          require("neo-tree.command").execute({
            action = "focus",
            -- 'toggle = true' makes the same key close the panel if it's open
            toggle = true,
            dir = parent_dir,
            reveal = true,
          })
        end,
        desc = "Explorer NeoTree (Adjacent Files Only)",
      },
    },
  },
}
