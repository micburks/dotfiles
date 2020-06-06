#!/bin/bash
USER="MICKEY"

./install-nix.sh

mkdir -p ~/Code/oss
mkdir -p ~/Code/utilities
mkdir -p ~/scripts
mkdir -p ~/machine-specific-scripts
mkdir -p ~/bin

# brew - some nix packages are broken
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# autojump - broken in nix
git clone git://github.com/wting/autojump.git ~/Code/utilities
cd ~/Code/utilities/autojump
./install.py

# ranger - broken in nix
~/scripts/install-ranger

cd ~/Code/oss/dotfiles

# configs
git config --global core.excludesfile ~/.gitignore
cat .bash_profile | sed "s/$USER/$(whoami)/g" > ~/.bash_profile
cat .gitconfig | sed "s/$USER/$(whoami)/g" > ~/.gitconfig
cat .shared.sh | sed "s/$USER/$(whoami)/g" > ~/.shared.sh
cat .vimrc | sed "s/$USER/$(whoami)/g" > ~/.vimrc
cat .zshrc | sed "s/$USER/$(whoami)/g" > ~/.zshrc
cat vmd | sed "s/$USER/$(whoami)/g" > ~/.config/vmd
cp .gitignore ~
cp .tmux.conf ~
cp .psqlrc ~
cp alacritty.yml ~/.config/alacritty/alacritty.yml

# user scripts
mkdir -p ~/scripts && cp -R scripts/ ~/scripts/

# vim plugins
cp .vim/bundle/install-plugins.bash ~/.vim/bundle/
cd ~/.vim/bundle/ && ./install-plugins.bash

# yvm
curl -s https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | node

# utilities
~/scripts/install-nvm
source ~/.shared.sh
nvm install node && nvm use default node
npm i -g vmd ndb

git clone git@github.com:micburks/codemod.git ~/machine-specific-scripts/codemod
cd ~/machine-specific-scripts/codemod
yarn

cd ~
