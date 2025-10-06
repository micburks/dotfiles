#!/bin/bash

if [[ $(uname -s) == "Darwin" ]]; then
  ./brew-install.sh
fi

# node
mkdir -p $HOME/.nvm
nvm install node
nvm use default node

# oh-my-zsh - https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# rust - https://rust-lang.org/tools/install/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install global npm utilities
./npm-globals-install.sh

# create symlinks
./setup.sh
