#!/bin/bash
cp ~/.vimrc .
cp ~/.vim/bundle/install-plugins.bash .vim/bundle/
cp ~/.gen_shell .
cp ~/.bash_profile .
cp ~/.zshrc .
cp ~/.gitignore .
cp ~/.gitconfig .
cp ~/.tmux.conf .
cp ~/.psqlrc .
rsync -av --exclude='node_modules' ~/scripts/ ./scripts
