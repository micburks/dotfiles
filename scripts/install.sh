#!/bin/bash

brew install autojump
brew install bat
brew install fzf
brew install jq
brew install neovim
brew install nvm
brew install ranger
brew install ripgrep
brew install tmux
brew install vivid

# node
nvm install node

# dependency of vivid
brew install coreutils

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
