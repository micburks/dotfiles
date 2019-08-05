#!/bin/bash
mkdir -p ~/Code/oss
mkdir -p ~/Code/utilities
mkdir ~/scripts
mkdir ~/bin


# vim/bash/zsh
cd ~/Code/oss/dotfiles
cp .vimrc ~
cp .vim/bundle/install-plugins.bash ~/.vim/bundle/
cat .shared.sh | sed "s/mickey/$(whoami)/g" > ~/.shared.sh
cp .bash_profile ~
cp .gitignore ~
cp .gitconfig ~
cp .tmux.conf ~
cp .psqlrc ~
cat .zshrc | sed "s/mickey/$(whoami)/g" > ~/.zshrc
mkdir -p ~/scripts && cp -R scripts/ ~/scripts/
cd ~/.vim/bundle/ && ./install-plugins.bash


# git setup
git config --global core.excludesfile ~/.gitignore


# utilities
cd ~/Code/utilities
git clone git://github.com/wting/autojump.git
cd autojump
./install.py

cd ~/Downloads
wget https://ranger.github.io/ranger-stable.tar.gz
tar xvf ranger-stable.tar.gz
rm ranger-stable.tar.gz
mv $(ls | grep ranger) ~/bin/ranger

~/scripts/install-nvm
source ~/.shared.sh
nvm install node && nvm use default node
npm i -g vmd npx
~/scripts/install-yarn
~/scripts/install-zsh

brew install fzf bat fd hub

