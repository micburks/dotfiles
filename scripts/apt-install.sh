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

# bat
# Using apt will install the package as `batcat`
mkdir -p $HOME/.local/bin
if [ ! -L "$HOME/.local/bin/bat" ]; then
  ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi


# vivid
wget "https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid_0.8.0_amd64.deb"
sudo dpkg -i vivid_0.8.0_amd64.deb

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
