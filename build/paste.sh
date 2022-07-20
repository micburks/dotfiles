#!/bin/bash
cp build/.zshrc ~/.zshrc
mkdir -p ~/.config/nvim
cp -R build/lua ~/.config/nvim/lua
cp -R build/utils ~/.config/nvim/utils
cp build/init.vim ~/.config/nvim/init.vim
