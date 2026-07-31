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

# git
git config --global core.excludesfile ~/.config/git/.gitignore

# gemini skills
GEMINI_SKILLS="$HOME/.gemini/config/skills"
if [ -d "$DOTFILES/skills" ]; then
  mkdir -p "$GEMINI_SKILLS"
  for skill in "$DOTFILES/skills"/*; do
    if [ -d "$skill" ]; then
      SKILL_NAME=$(basename "$skill")
      if [ ! -L "$GEMINI_SKILLS/$SKILL_NAME" ]; then
        ln -s "$skill" "$GEMINI_SKILLS/$SKILL_NAME"
      fi
    fi
  done
fi

# local binaries
mkdir -p "$HOME/.local/bin"
if [ ! -e "$HOME/.local/bin/fd" ] && command -v fdfind >/dev/null 2>&1; then
  ln -s "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi
