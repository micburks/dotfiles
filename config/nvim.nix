{ config, pkgs, ... }:

{
  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #   }))
  # ];

  # kamwitsta/nordisk
  # pgavlin/pulumi.vim
  # terrortylor/nvim-comment
  # nacro90/numb.nvim
  # hkupty/nvimux

  xdg.configFile."nvim/lua".source = ./nvim/lua;
  xdg.configFile."nvim/utils".source = ./nvim/utils;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
       ${builtins.readFile ~/.config/nixpkgs/config/init.vim}
       lua require('init');
    '';
    plugins = with pkgs.vimPlugins; [
      galaxyline-nvim
      goyo-vim
      gruvbox-nvim
      hop-nvim
      iceberg-vim
      lsp-colors-nvim
      nvim-lspconfig
      nvim-tree-lua
      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-web-devicons
      packer-nvim
      plenary-nvim
      popup-nvim
      quick-scope
      registers-nvim
      symbols-outline-nvim
      tagalong-vim
      telescope-fzf-native-nvim
      telescope-nvim
      toggleterm-nvim
      vim-closetag
      vim-gitgutter
      vim-illuminate
      zenburn

      # nvim-dap
      # nvim-dap-ui
      # trouble-nvim
      # vim-surround
    ];
  };
}
