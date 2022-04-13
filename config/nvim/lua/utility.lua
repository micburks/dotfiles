
-- # help
---general - \h            - help
vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua require"modules/help".help()<CR>', {noremap=true, silent=true})


-- # hop
---movement - g\            - hop
require('hop').setup{}
vim.api.nvim_set_keymap('n', 'g<leader>', "<cmd>lua require'hop'.hint_words()<cr>", {noremap=true})


-- ... closetag ...
vim.g.closetag_filetypes = 'html,xhtml,phtml,javascript,javascriptreact,javascript.jsx,typescript.tsx,typescriptreact'


-- not available on nix yet
require('packer').use {
  'lewis6991/spellsitter.nvim',
  config = function()
    require('spellsitter').setup()
  end
}

require('packer').use {
  'beauwilliams/focus.nvim',
  config = function()
    require("focus").setup({
      excluded_filetypes = {'fterm', 'term', 'toggleterm', 'NvimTree'},
      excluded_buftypes = {'nofile', 'prompt', 'popup', 'terminal'},
      minwidth = 65,
      treewidth = 40,
      colorcolumn = {enable = true, width = 100},
    })
  end
}

---splits - \<enter>      - Toggle between equal splits or maximized
vim.api.nvim_set_keymap('n', '<leader><enter>', '<cmd>lua require"focus".focus_max_or_equal()<CR>', {noremap=true, silent=true})


-- numb
require('numb').setup()


-- git gutter
vim.g.gitgutter_map_keys = 0
 


--
-- # comment
-- - gcc           - normal: Toggles the current line using linewise comment
-- - gbc           - normal: Toggles the current line using blockwise comment
-- - Ngcc          - normal: Toggles N lines given as a prefix-count using linewise
-- - Ngbc          - normal: Toggles N lines given as a prefix-count using blockwise
-- - gcNM          - normal: (Op-pending) Toggles the region using linewise comment
-- - gbNM          - normal: (Op-pending) Toggles the region using linewise comment
-- - gc            - visual: Toggles the region using linewise comment
-- - gb            - visual: Toggles the region using blockwise comment
-- require('Comment').setup()



-- # splitjoin
---editing - <space>s      - splitjoin: 1 -> many lines (splitjoin)
vim.api.nvim_set_keymap('n', '<space>s', '<cmd>SplitjoinSplit<cr>', {noremap=true, silent=true})
---editing - <space>j      - splitjoin: many -> 1 line (splitjoin)
vim.api.nvim_set_keymap('n', '<space>j', '<cmd>SplitjoinJoin<cr>', {noremap=true, silent=true})
-- remove default keybindings
vim.api.nvim_set_keymap('', 'gS', '<Nop>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('', 'gJ', '<Nop>', {noremap=true, silent=true})



-- # telescope
---search - \ff           - fuzzy find find_files (telescope)
---search - \fg           - fuzzy find live_grep (telescope)
---search - \fb           - fuzzy find buffers (telescope)
---search - \fh           - fuzzy find help_tags (telescope)
require('telescope').setup{}
require('telescope').load_extension('fzf')
vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>Telescope find_files<cr>", {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>Telescope buffers<cr>", {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>Telescope help_tags<cr>", {noremap=true})



-- # toggleterm
---terminal - \t            - open first terminal
---terminal - X\t           - open numbered terminal
require("toggleterm").setup{
  open_mapping = "\\t",
  direction = 'float',
}

---terminal - \g            - lazygit terminal (arrow keys, enter, space, q)
-- custom terminal for lazygit
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, count = 5 })
function _lazygit_toggle()
  lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})


-- # nvim-tree
-- TODO: remove nvim-tree help since you can find it via nvim-tree g? ??
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
