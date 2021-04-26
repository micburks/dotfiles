#!/bin/bash
USER="MICKEY"

./install-nix.sh

mkdir -p ~/Code/oss
mkdir -p ~/Code/utilities
mkdir -p ~/scripts
mkdir -p ~/machine-specific-scripts
mkdir -p ~/bin

# brew - some nix packages are broken
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# nix pkg for delta is outdated
# brew install git-delta

# autojump - broken in nix
# git clone git://github.com/wting/autojump.git ~/Code/utilities
# cd ~/Code/utilities/autojump
# ./install.py

# ranger - broken in nix
# ~/scripts/install-ranger

pushd ~/Code/oss/dotfiles || exit

function change-user() {
  sed "s/$USER/$(whoami)/g" "$1"
}
# configs
git config --global core.excludesfile ~/.gitignore
change-user .bash_profile > ~/.bash_profile
change-user .gitconfig > ~/.gitconfig
change-user .shared.sh > ~/.shared.sh
change-user .vimrc > ~/.vimrc
change-user .zshrc > ~/.zshrc
change-user vmd > ~/.config/vmd
cp .gitignore ~
cp .tmux.conf ~
cp .psqlrc ~
cp alacritty.yml ~/.config/alacritty/alacritty.yml
mkdir -p ~/.config/bat
cp bat-config ~/.config/bat/config

# zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# user scripts
mkdir -p ~/scripts && cp -R scripts/ ~/scripts/

# vim plugins
# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#cp .vim/bundle/install-plugins.bash ~/.vim/bundle/
#cd ~/.vim/bundle/ && ./install-plugins.bash

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
