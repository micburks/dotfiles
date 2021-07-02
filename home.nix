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
    fd
    fzf
    fontforge
    gitAndTools.hub
    go
    jq
    ranger
    rust-analyzer
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

  # Can't use nvim-web-devicons until I figure out why my patched font won't work with Alacritty
  # kyazdani42/nvim-web-devicons
  # kamwitsta/nordisk
  # pgavlin/pulumi.vim
  # terrortylor/nvim-comment
  # nacro90/numb.nvim
  # hkupty/nvimux

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = (builtins.readFile ~/.nvimrc);
    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim
      hop-nvim
      iceberg-vim
      lsp-colors-nvim
      lush-nvim
      nvim-colorizer-lua
      nvim-compe
      nvim-lspconfig
      nvim-toggleterm-lua
      nvim-tree-lua
      nvim-treesitter
      plenary-nvim
      popup-nvim
      quick-scope
      Shade-nvim
      splitjoin-vim
      telescope-nvim
      trouble-nvim
      vim-gitgutter
      vim-illuminate
      zenburn
    ];
  };
}
