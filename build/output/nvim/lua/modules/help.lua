local M = {}

M.help = function()
  local width = vim.o.columns - 4
  local height = vim.o.lines - 4
  if (vim.o.columns > 85) then
    width = 80
  end
  vim.api.nvim_open_win(
    vim.api.nvim_create_buf(false, true),
    true,
    {
        relative = 'editor',
        style = 'minimal',
        noautocmd = true,
        width = width,
        height = height,
        col = math.min((vim.o.columns - width) / 2),
        row = math.min((vim.o.lines - height) / 2 - 1),
    }
  )
  vim.fn.termopen("awk -f ~/.config/nvim/utils/helptree.awk ~/.config/nvim/{,lua/}*.(lua|vim) | bat -pp -l md")
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'f', '<C-f>', {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'b', '<C-b>', {noremap=true, silent=true})
end

return M
