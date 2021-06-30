{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "21.11";
  home.username = "$USER";
  home.homeDirectory = "/Users/$USER";

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    alacritty
    autojump
    bat
    coreutils
    delta
    fzf
    fd
    gitAndTools.hub
    go
    jq
    neovim
    ranger
    rustup
    silver-searcher
    tmux
    tree
    vivid
    yarn
    zsh
  ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    plugins = [
    ];
  };
}
