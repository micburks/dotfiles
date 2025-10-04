#!/bin/bash

CONFIG="$HOME/.config"
DOTFILES="$CONFIG/dotfiles"
CONFIG_SRC="$DOTFILES/config"
HOME_SRC="$DOTFILES/home"

mkdir -p $CONFIG

# bat
[ ! -L $CONFIG/bat ] && \
  ln -s $CONFIG_SRC/bat $CONFIG/bat

# help
[ ! -L $CONFIG/help ] && \
  ln -s $CONFIG_SRC/help $CONFIG/help

# node - manual
echo "run 'nvm use default node'" 
mkdir $HOME/.nvm

# nvim
[ ! -L $CONFIG/nvim ] && \
  ln -s $CONFIG_SRC/nvim $CONFIG/nvim

# tmux
[ ! -L $CONFIG/tmux ] && \
  ln -s $CONFIG_SRC/tmux $CONFIG/tmux

# zsh
# Remove the zshrc that oh-my-zsh sets up.
rm ~/.zshrc
ln -s $HOME_SRC/.zshrc $HOME
