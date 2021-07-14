#!/bin/bash

if [[ "$(which nix-env)" == "" ]]; then
  NIX_INSTALLER_NO_MODIFY_PROFILE=1 sh <(curl https://nixos.org/nix/install) --no-daemon --darwin-use-unencrypted-nix-store-volume
fi

# keep up to date
nix-channel --update nixpkgs
nix-env -u '*'
