-- npm i -g bash-language-server graphql-language-service-cli flow-bin typescript-language-server vscode-langservers-extracted vim-language-server eslint_d @tailwindcss/language-server

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
  -- use 'hrsh7th/cmp-cmdline' -- completion source for cmdline
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin

  -- vsnip
  use 'hrsh7th/cmp-vsnip' -- completion source for vsnip
  use 'hrsh7th/vim-vsnip' -- Snippet plugin
  use 'hrsh7th/vim-vsnip-integ' -- snippet completion and expansion

  use 'hrsh7th/cmp-nvim-lua' -- completion source for neovim lua api
  -- use 'lukas-reineke/cmp-rg' -- completion source for ripgrep

  use 'rafamadriz/friendly-snippets'

  use 'nanotee/sqls.nvim'
end)

local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {

-- # autocomplete
-- unnecessary
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-n>'] = cmp.mapping.select_next_item(),

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

-- This is kind of annoying
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--   { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--     })
-- })


local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local nvim_lsp = require('lspconfig')

local servers = {
  -- 'awk_ls',
  'bashls',
  'clangd',
  'cssls',
  'flow',
  'graphql',
  'html',
  'jsonls',
  'rust_analyzer',
  'sqls',
  'vimls'
}

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

-- # keymaps NEED work-------
-- group keymaps by???:
-- - g for going
-- - <space> for actions
-- - <leader> for dialogs
-- - capital letters for dialogs?

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
local on_attach = function(client, bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions

    -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Lsp mappings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  
-- does nothing
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- redundant
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  
-- ---movement.lsp - gd            - lsp.buf.definition (lsp)
  -- attempting to replace this with treesitter and lsp fallback
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
---movement.lsp - gD            - lsp.buf.type_definition (lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
---diagnostics - \k            - lsp.buf.hover (lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- todo remove redundant mapping
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
---editing - <space>r      - lsp.buf.rename across multiple files (lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
---editing - <space>c      - lsp.buf.code_action (lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
---diagnostics - \r            - lsp.buf.references (lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
---editing - <space>f      - lsp.buf.formatting (lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

---workspace - <space>wa     - lsp.buf.add_workspace_folder (lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
---workspace - <space>wr     - lsp.buf.remove_workspace_folder (lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
---workspace - <space>wl     - print(vim.inspect(vim.lsp.buf.list_workspace_folders())) (lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buflist_workspace_folders()))<CR>', opts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }
end

-- nvim_lsp.sumneko_lua.setup {
--   on_attach = on_attach,
--   flags = {
--     debounce_text_changes = 150,
--   },
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   }
-- }

nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  settings = {
    tailwindCSS = {
      classAttributes = { 'class' , 'className' , 'classList' },
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning"
        },
      validate = true
    }
  }
}

nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  }
}

-- note: bug in efm-langserver/neovim/nvm-lspconfig where a directory that ends
-- with '-2021' will not run eslint. no time to investigate
nvim_lsp.efm.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}

nvim_lsp.gopls.setup{
	cmd = {'gopls'},
	-- for postfix snippets and analyzers
  capabilities = capabilities,
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
  on_attach = on_attach,
}
