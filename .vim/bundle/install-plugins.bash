#!/bin/bash

# colorschemes
git clone https://github.com/dracula/vim.git dracula
git clone https://github.com/kamwitsta/nordisk
git clone https://github.com/cocopon/iceberg.vim
git clone git@github.com:morhetz/gruvbox.git
# git clone https://github.com/nanotech/jellybeans.vim
# git clone https://github.com/altercation/vim-colors-solarized

# utils
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/scrooloose/nerdcommenter
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/nathanaelkane/vim-indent-guides.git
git clone https://github.com/easymotion/vim-easymotion.git
git clone https://tpope.io/vim/surround.git

# terminal integration
git clone https://github.com/kassio/neoterm

# js
git clone https://github.com/mxw/vim-jsx.git
git clone https://github.com/pangloss/vim-javascript.git

# flow
# git clone https://github.com/othree/es.next.syntax.vim
# git clone https://github.com/kern/vim-es7

# typescript
git clone https://github.com/leafgarland/typescript-vim

# reason
git clone https://github.com/reasonml-editor/vim-reason-plus.git
echo "follow instructions for reason here: https://github.com/jaredly/reason-language-server"

# graphql
git clone https://github.com/jparise/vim-graphql.git

# syntax and lsp support
git clone https://github.com/dense-analysis/ale.git

# auto-complete
git clone https://github.com/shougo/deoplete.nvim
# deps
pip3 install --user pynvim # ?
git clone https://github.com/roxma/nvim-yarp
git clone https://github.com/roxma/vim-hug-neovim-rpc

# manage universal ctags
# git clone https://github.com/universal-ctags/ctags
# cd ctags && ./autogen.sh && ./configure && make && sudo make install
# cd ~/.vim/bundle/
# git clone https://github.com/ludovicchabant/vim-gutentags.git

# js imports
git clone https://github.com/kristijanhusak/vim-js-file-import
cd vim-js-file-import
npm install
cd ~/.vim/bundle/
