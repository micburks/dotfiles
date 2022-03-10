local M = {}

M.focus = function()
  require('focus').focus_max_or_equal()
  local key = nvim_replace_termcodes("<C-w>=", v:true, v:false, v:true)
  nvim_feedkeys(key, 'n', v:true)
end

return M
