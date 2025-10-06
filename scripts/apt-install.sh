#!/bin/bash

sudo apt-get install autojump \
                     bat \
                     fd-find \
                     fzf \
                     jq \
                     lazygit \
                     neovim \
                     ranger \
                     ripgrep \
                     tmux

# vivid
wget "https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid_0.8.0_amd64.deb"
sudo dpkg -i vivid_0.8.0_amd64.deb

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
