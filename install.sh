#!/bin/bash
mkdir -p ~/Code/oss
mkdir -p ~/Code/utilities
mkdir ~/scripts
mkdir ~/bin


# zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# vim/bash/zsh
cd ~/Code/oss/dotfiles
cp .vimrc ~
cp .vim/bundle/install-plugins.bash ~/.vim/bundle/
cp .shared.sh ~
cp .bash_profile ~
cp .gitignore ~
cp .gitconfig ~
cp .tmux.conf ~
cp .psqlrc ~
cp .zshrc ~
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

install-nvm
source ~/.bash_profile # ?
nvm install node && nvm use default node
install-yarn
npm i -g vmd npx

brew install fzf bat fd hub

