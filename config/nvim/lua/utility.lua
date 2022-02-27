
-- # help
---help - <space>h      - help
vim.api.nvim_set_keymap('n', '<space>h', '<cmd>lua require"modules/help".help()<CR>', {noremap=true, silent=true})

-- # hop
---hop - \\            - hop
require('hop').setup{}
vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require'hop'.hint_words()<cr>", {noremap=true})


-- ... closetag ...
vim.g.closetag_filetypes = 'html,xhtml,phtml,javascript,javascriptreact,javascript.jsx,typescript.tsx,typescriptreact'


-- not available on nix yet
require('packer').use {
  'lewis6991/spellsitter.nvim',
  config = function()
    require('spellsitter').setup()
  end
}





-- # splitjoin
---splitjoin - gS            - splitjoin: 1 -> many lines
---splitjoin - gJ            - splitjoin: many -> 1 line



-- # telescope
---telescope - \ff           - fuzzy find find_files
---telescope - \fg           - fuzzy find live_grep
---telescope - \fb           - fuzzy find buffers
---telescope - \fh           - fuzzy find help_tags
require('telescope').setup{}
require('telescope').load_extension('fzf')
vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>Telescope find_files<cr>", {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>Telescope buffers<cr>", {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>Telescope help_tags<cr>", {noremap=true})



-- # toggleterm
---toggleterm - \t            - open first terminal
---toggleterm - X\t           - open numbered terminal
require("toggleterm").setup{
  open_mapping = "\\t",
  direction = 'float',
}

---toggleterm - \rg           - lazygit terminal (arrow keys, enter, space, q)
-- custom terminal for lazygit
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, count = 5 })
function _lazygit_toggle()
  lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>rg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})


-- # nvim-tree
---nvim-tree - g?            - open help
--
-- ## visibility
---nvim-tree.visibility - <leader>e     - open tree
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
require'nvim-tree'.setup {
  open_on_setup = 1,
  view = {
    width = 40,
    auto_resize = true
  }
}
vim.api.nvim_set_keymap('n', '<leader>e', "<cmd>NvimTreeToggle<cr>", {noremap=true, silent=true})
-- vim.g.nvim_tree_width = 40

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
