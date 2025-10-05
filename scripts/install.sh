#!/bin/bash

brew install autojump
brew install bat
brew install fd
brew install fzf
brew install jq
brew install lazygit
brew install neovim
brew install nvm
brew install ranger
brew install ripgrep
brew install tmux
brew install vivid

# dependency of vivid
brew install coreutils

# node
mkdir -p $HOME/.nvm
nvm install node
nvm use default node

# oh-my-zsh - https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# rust - https://rust-lang.org/tools/install/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
