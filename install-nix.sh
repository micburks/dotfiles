#!/bin/bash

NIX_INSTALLER_NO_MODIFY_PROFILE=1 sh <(curl https://nixos.org/nix/install) --no-daemon --darwin-use-unencrypted-nix-store-volume

# keep up to date
nix-channel --update nixpkgs
nix-env -u '*'

nix-env -iA nixpkgs.jq \
  nixpkgs.fzf \
  nixpkgs.bat \
  nixpkgs.fd \
  nixpkgs.gitAndTools.hub \
  nixpkgs.tree \
  nixpkgs.silver-searcher \
  nixpkgs.autojump \
  nixpkgs.ranger \
  nixpkgs.zsh \
  nixpkgs.yarn \
  nixpkgs.alacritty \
  nixpkgs.rustup

nix-env -i -f nix/ls-colors.nix

git clone git@github.com:Shopify/comma.git tmp/comma
nix-env -i -f tmp/comma
