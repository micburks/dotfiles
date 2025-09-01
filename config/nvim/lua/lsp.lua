-- npm i -g
--
-- -- bash-language-server
-- graphql-language-service-cli
-- -- typescript-language-server
-- -- vscode-langservers-extracted
-- -- vim-language-server
-- -- eslint_d
--  @tailwindcss/language-server


-- # keymaps legend
-- group keymaps by:
-- - g for going
-- - <space> for actions
-- - <leader> for dialogs
-- - capital letters for dialogs?


---diagnostics - \a            - open symbols
vim.api.nvim_set_keymap('n', '<leader>a', "<cmd>SymbolsOutline<cr>", {noremap=true})
vim.g.symbols_outline = {
  keymaps = {
---symbols - <ESC>         - close
    close = {"<Esc>", "q"},
---symbols - <CR>          - go to location
    goto_location = "<Cr>",
---symbols - o             - focus location
    focus_location = "o",
---symbols - <C-space>     - hover symbol
    hover_symbol = "<C-space>",
---symbols - K             - toggle preview
    toggle_preview = "K",
    rename_symbol = "<Nop>",
    code_actions = "<Nop>",
  },
  highlight_hovered_item = false,
  auto_close = true,
  auto_preview = false,
  show_symbol_details = false,
}
vim.api.nvim_exec(
[[
  hi FocusedSymbol guibg=NONE guifg=NONE ctermfg=NONE ctermbg=NONE
]], false)


-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- autocomplete packages
-- these are not updated in nix right now
local use = require('packer').use
require('packer').startup(function()
  -- nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp' -- completion source for neovim builtin LSP
  use 'hrsh7th/cmp-buffer' -- completion source for words in current buffer
  use 'hrsh7th/cmp-path' -- completeion source for path
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin

  -- vsnip
  use 'hrsh7th/cmp-vsnip' -- completion source for vsnip
  use 'hrsh7th/vim-vsnip' -- Snippet plugin
  use 'hrsh7th/vim-vsnip-integ' -- snippet completion and expansion

  use 'hrsh7th/cmp-nvim-lua' -- completion source for neovim lua api

  use 'rafamadriz/friendly-snippets'
end)

---snip - :VsnipOpen    - Edit snippets
vim.g.vsnip_snippet_dir = '~/.config/nixpkgs/snip/'
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {

-- # autocomplete
---autocomplete - <C-b>         - cmp.mapping.scroll_docs back
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
---autocomplete - <C-f>         - cmp.mapping.scroll_docs forward
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
---autocomplete - <C-Space>     - cmp.mapping.complete
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
---autocomplete - <C-y>         - cmp.config.disable
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
---autocomplete - <C-e>         - cmp.mapping.abort or cmp.mapping.close
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
---autocomplete - <CR>          - cmp.mapping.confirm
    ['<CR>'] = cmp.mapping.confirm {
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
---autocomplete - <Tab>         - select_next or expand_or_jump
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
---autocomplete - <S-Tab>       - select_prev or jump back
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'nvim_lua' },
    -- { name = 'rg' }
  }, {
    { name = 'buffer' }
  })
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local nvim_lsp = require('lspconfig')

local servers = {
  'bashls',
  'clangd',
  'cssls',
  'eslint',
  'html',
  'jsonls',
  'rust_analyzer',
  'tsserver',
  'vimls',
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
  }
end

nvim_lsp.gopls.setup{
	cmd = {'gopls'},
	-- for postfix snippets and analyzers
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
}

-- # lsp
-- Diagnostics mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
---movement.lsp - g;            - diagnostic.goto_next (lsp)
vim.api.nvim_set_keymap('n', 'g;', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
---movement.lsp - g,            - diagnostic.goto_prev (lsp)
vim.api.nvim_set_keymap('n', 'g,', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
---diagnostics - \s            - diagnostic.open_float (lsp)
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- not helpful
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- local opts = { buffer = ev.buf }
    local opts = { noremap=true, silent=true, buffer=ev.buf }

    -- does nothing
      -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- redundant
      -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      -- vim.keymap.set('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      
    -- ---movement.lsp - gd            - lsp.buf.definition (lsp)
      -- attempting to replace this with treesitter and lsp fallback
      -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

    ---movement.lsp - gD            - lsp.buf.type_definition (lsp)
    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
    ---diagnostics - \k            - lsp.buf.hover (lsp)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
    -- todo remove redundant mapping
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    ---editing - <space>r      - lsp.buf.rename across multiple files (lsp)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
    ---editing - <space>c      - lsp.buf.code_action (lsp)
    vim.keymap.set('n', '<space>c', vim.lsp.buf.code_action, opts)
    ---diagnostics - \r            - lsp.buf.references (lsp)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
    ---editing - <space>f      - lsp.buf.formatting (lsp)
    if client.name == 'eslint' then
      vim.keymap.set('n', '<space>f', ':EslintFixAll<cr>', opts)
    elseif client.name == 'tsserver' then
    else
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end

    ---workspace - <space>wa     - lsp.buf.add_workspace_folder (lsp)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    ---workspace - <space>wr     - lsp.buf.remove_workspace_folder (lsp)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    ---workspace - <space>wl     - print(vim.inspect(vim.lsp.buf.list_workspace_folders())) (lsp)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
  end,
})
