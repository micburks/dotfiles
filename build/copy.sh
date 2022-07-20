#!/bin/bash
cp ~/.zshrc build
sudo cp -LR ~/.config/nvim/lua build/lua
sudo cp -LR ~/.config/nvim/utils build/utils
cp ~/.config/nvim/init.vim build/init.vim
