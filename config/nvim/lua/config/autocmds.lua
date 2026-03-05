-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")


-- Define the auto-update behavior using a Neovim Autocmd
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NeoTreeAutoParent", { clear = true }),
  callback = function()
    -- Only proceed if the current buffer is a normal file
    if vim.bo.buftype == "" and vim.bo.filetype ~= "neo-tree" then
      local manager = require("neo-tree.sources.manager")
      local state = manager.get_state("filesystem")

      -- Only update if the Neo-tree window is actually open
      if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
        require("neo-tree.command").execute({
          action = "show",
          dir = vim.fn.expand("%:p:h"),
          reveal = true,
        })
      end
    end
  end
})
