#!/bin/bash
USER="MICKEY"

mkdir -p ~/Code/oss
mkdir -p ~/Code/utilities
mkdir ~/scripts
mkdir ~/machine-specific-scripts
mkdir ~/bin


# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# vim/bash/zsh
cd ~/Code/oss/dotfiles
cat .bash_profile | sed "s/$USER/$(whoami)/g" > ~/.bash_profile
cat .gitconfig | sed "s/$USER/$(whoami)/g" > ~/.gitconfig
cat .shared.sh | sed "s/$USER/$(whoami)/g" > ~/.shared.sh
cat .vimrc | sed "s/$USER/$(whoami)/g" > ~/.vimrc
cat .zshrc | sed "s/$USER/$(whoami)/g" > ~/.zshrc
cat vmd | sed "s/$USER/$(whoami)/g" > ~/.config/vmd
cp .gitignore ~
cp .tmux.conf ~
cp .psqlrc ~
mkdir -p ~/scripts && cp -R scripts/ ~/scripts/
cp .vim/bundle/install-plugins.bash ~/.vim/bundle/
cd ~/.vim/bundle/ && ./install-plugins.bash
brew cask install alacritty
cp alacritty.yml ~/.config/alacritty/alacritty.yml


# yvm
curl -s https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | node


# git setup
git config --global core.excludesfile ~/.gitignore


# utilities
git clone git://github.com/wting/autojump.git ~/Code/utilities
cd ~/Code/utilities/autojump
./install.py

~/scripts/install-ranger

~/scripts/install-nvm
source ~/.shared.sh
nvm install node && nvm use default node
npm i -g vmd ndb
~/scripts/install-yarn
~/scripts/install-zsh

git clone git://github.com/micburks/codemod.git ~/machine-specific-scripts
~/machine-specific-scripts/codemod
yarn
cd ~

brew install jq fzf bat fd hub tree comby

