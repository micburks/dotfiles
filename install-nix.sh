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
  nixpkgs.silver-searcher
