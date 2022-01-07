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

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
       ${builtins.readFile ~/.config/nixpkgs/config/init.vim}
       lua require('init');
    '';
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
      nvim-tree-lua
      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-web-devicons
      packer-nvim
      plenary-nvim
      popup-nvim
      quick-scope
      registers-nvim
      splitjoin-vim
      tagalong-vim
      telescope-fzf-native-nvim
      telescope-nvim
      toggleterm-nvim
      # trouble-nvim
      vim-closetag
      vim-gitgutter
      vim-illuminate
      # vim-surround
      zenburn

      # hrsh7th/nvim-cmp
      # hrsh7th/cmp-nvim-lsp
      # saadparwaiz1/cmp_luasnip
      # L3MON4D3/LuaSnip
    ];
  };
}
