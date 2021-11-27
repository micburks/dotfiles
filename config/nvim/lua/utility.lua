---
--- \\            - hop
require('hop').setup{}
vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require'hop'.hint_words()<cr>", {})

-- some issue with not being able to close the last window
require('shade').setup({
  overlay_opacity = 70,
})

require('telescope').setup{}
require('telescope').load_extension('fzf')

require("toggleterm").setup{
  open_mapping = "\\t",
  direction = 'float',
}
require("trouble").setup{}

-- nvim_tree
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_auto_open = 1
--- nvim-tree visibility
--- <leader>e   - open tree
--- I           - toggle git hidden files
--- H           - toggle dotfiles
--- R           - refresh tree
---
--- nvim-tree navigation
--- o           - open file/toggle directory
--- <TAB>       - preview file
--- <C-v>       - open in vertical split
--- <C-x>       - open in horizontal split
--- <C-t>       - open in new tab
--- <BS>        - close directory
--- -           - nav to parent directory
-- --- O           - set directory as root
---
--- nvim-tree edit tree
--- a           - add file (use trailing slash to create directory)
--- r           - rename file
--- <C-r>       - rename file omitting current name
--- d           - delete file
--- x           - add file to cut clipboard
--- c           - add file to copy clipboard
--- p           - paste file from clipboard
---
--- nvim-tree yanking
--- y           - add name to copy clipboard
--- Y           - add relative path to copy clipboard
--- gy          - add absolute path to copy clipboard
