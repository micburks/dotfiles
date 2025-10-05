#!/bin/bash

CONFIG="$HOME/.config"
DOTFILES="$CONFIG/dotfiles"
CONFIG_SRC="$DOTFILES/config"

mkdir -p $CONFIG

for dir in "$CONFIG_SRC"/*; do
  DIRNAME=$(basename "$dir")
  if [ ! -L "$CONFIG/$DIRNAME" ]; then
    ln -s "$CONFIG_SRC/$DIRNAME" "$CONFIG/$DIRNAME"
  fi
done

# zsh
# Remove the zshrc that oh-my-zsh sets up.
[ -f $HOME/.zshrc ] && rm $HOME/.zshrc
# The env file sets the root directory
[ ! -L $HOME/.zshenv ] &&
  ln -s $CONFIG/zsh/.zshenv $HOME/.zshenv
