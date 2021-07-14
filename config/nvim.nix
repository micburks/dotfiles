{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  # kamwitsta/nordisk
  # pgavlin/pulumi.vim
  # terrortylor/nvim-comment
  # nacro90/numb.nvim
  # hkupty/nvimux

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ~/.config/nixpkgs/.nvimrc;
    plugins = with pkgs.vimPlugins; [
      galaxyline-nvim
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
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      quick-scope
      registers-nvim
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
