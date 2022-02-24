---
--- ... hop ...
--- \\            - hop
require('hop').setup{}
vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require'hop'.hint_words()<cr>", {noremap=true})


---
--- closetag
vim.g.closetag_filetypes = 'html,xhtml,phtml,javascript,javascriptreact,javascript.jsx,typescript.tsx,typescriptreact'


-- not available on nix yet
require('packer').use {
  'lewis6991/spellsitter.nvim',
  config = function()
    require('spellsitter').setup()
  end
}



---
--- ... splitjoin ...
--- gS            - splitjoin: 1 -> many lines
--- gJ            - splitjoin: many -> 1 line



---
--- ... telescope
--- \ff           - fuzzy find find_files
--- \fg           - fuzzy find live_grep
--- \fb           - fuzzy find buffers
--- \fh           - fuzzy find help_tags
require('telescope').setup{}
require('telescope').load_extension('fzf')
vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>Telescope find_files<cr>", {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>Telescope buffers<cr>", {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>Telescope help_tags<cr>", {noremap=true})



---
--- ... toggleterm ...
--- \t            - open first terminal
--- X\t           - open numbered terminal
require("toggleterm").setup{
  open_mapping = "\\t",
  direction = 'float',
}

--- \rg           - lazygit terminal (arrow keys, enter, space, q)
-- custom terminal for lazygit
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, count = 5 })
function _lazygit_toggle()
  lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>rg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})


---
--- ... nvim-tree help ...
--- g?            - open help
---
--- ... nvim-tree visibility ...
--- <leader>e     - open tree
--- q             - close tree
--- I             - toggle git hidden files
--- H             - toggle dotfiles
--- R             - refresh tree
---
--- ... nvim-tree navigation ...
--- o             - open file/toggle directory
--- <BS>          - close directory
--- P             - jump to parent directory
--- </>           - jump to prev/next sibling
--- -             - set parent directory as root
--- <C-]>         - set directory as root
--- <TAB>         - preview file
--- <C-v>         - open in vertical split
--- <C-x>         - open in horizontal split
--- <C-t>         - open in new tab
--- s             - open with system default application
---
--- ... nvim-tree edit tree ...
--- a             - add file (use trailing slash to create directory)
--- r             - rename file
--- <C-r>         - rename file omitting current name
--- d             - delete file
--- x             - add file to cut clipboard
--- c             - add file to copy clipboard
--- p             - paste file from clipboard
---
--- ... nvim-tree yanking ...
--- y             - add name to copy clipboard
--- Y             - add relative path to copy clipboard
--- gy            - add absolute path to copy clipboard
require'nvim-tree'.setup {
  open_on_setup = 1
}
vim.api.nvim_set_keymap('n', '<leader>e', "<cmd>NvimTreeToggle<cr>", {noremap=true, silent=true})
vim.g.nvim_tree_width = 40

--  only way to configure nvim-tree bindings but require('nvim-tree') is nil
--  possible due to home-manager installing it as nvim-tree.lua?
-- local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- require('nvim-tree').setup {
--   view = {
--     mappings = {
--       custom_only = false,
--       list = {
--         { key = {"O"},    cb = tree_cb("cd") },
--       }
--     }
--   }
-- }
