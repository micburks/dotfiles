#!/bin/bash
USER="MICKEY"

#cat ~/.bash_profile | sed "s/$(whoami)/$USER/g" > .bash_profile
cat ~/.gitconfig | sed "s/$(whoami)/$USER/g" > .gitconfig
cat ~/.shared.sh | sed "s/$(whoami)/$USER/g" > .shared.sh
#cat ~/.vimrc | sed "s/$(whoami)/$USER/g" > .vimrc
#cat ~/.zshrc | sed "s/$(whoami)/$USER/g" > .zshrc
#cat ~/.config/vmd | sed "s/$(whoami)/$USER/g" > vmd
#cp ~/.config/alacritty/alacritty.yml .
#cp ~/.config/bat/config bat-config
# cp ~/.vim/bundle/install-plugins.bash .vim/bundle/
cp ~/.gitignore .
cp ~/.tmux.conf .
cp ~/.psqlrc .
rsync -av --exclude='node_modules' ~/scripts/ ./scripts


# nix
cp ~/.config/nixpkgs/home.nix .

# nvim
cat ~/.nvimrc | sed "s/$(whoami)/$USER/g" > .nvimrc
