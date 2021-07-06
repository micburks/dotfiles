{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "21.11";
  home.username = "$USER";
  home.homeDirectory = "/Users/$USER";

  xdg.enable = true;

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    alacritty
    autojump
    bat
    coreutils
    delta
    exa
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

  programs.git = {
    enable = true;
    userName = "Mickey Burks";
    userEmail = "brks.mck@gmail.com";
    aliases = {
      unstage = "reset HEAD --";
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        syntax-theme = "Nord";
        side-by-side = true;
      };
    };
    extraConfig = {
      core = {
        excludesfile = "/Users/$USER/.gitignore";
      };
      pull = {
        rebase = true;
      };
    };
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };
    
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    initExtra = ''
      ######################
      # Show today's date
      function parse_date() {
        date +'%a %b %d'
      }
      # Show pwd
      function parse_pwd () {
        echo $(pwd) | sed -e 's/^\/Users\/mburks\(.*\)$/~\1/'
      }
      # Show git branch name
      function parse_git_branch () {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
      }
      
      PROMPT='
      %{$fg[yellow]%}[$(parse_date)] %{$fg[green]%}$(parse_git_branch) %{$fg[blue]%}$(parse_pwd)
      %{$reset_color%}$ '
      ######################

      ${builtins.readFile ~/.shared.sh}
    '';
    history.share = false;
    oh-my-zsh.enable = true;
  };

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
    extraConfig = builtins.readFile ~/.nvimrc;
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
