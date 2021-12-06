---
--- ... hop ...
--- \\            - hop
require('hop').setup{}
vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require'hop'.hint_words()<cr>", {noremap=true})



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



---
--- ... nvim-tree visibility ...
--- <leader>e     - open tree
--- I             - toggle git hidden files
--- H             - toggle dotfiles
--- R             - refresh tree
---
--- ... nvim-tree navigation ...
--- o             - open file/toggle directory
--- <TAB>         - preview file
--- <C-v>         - open in vertical split
--- <C-x>         - open in horizontal split
--- <C-t>         - open in new tab
--- <BS>          - close directory
--- -             - nav to parent directory
--- O             - set directory as root
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
vim.api.nvim_set_keymap('n', '<leader>e', "<cmd>NvimTreeToggle<cr>", {noremap=true, silent=true})
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_auto_open = 1
