{ config, pkgs, ... }:

let
  comma = import ( pkgs.fetchFromGitHub {
      owner = "Shopify";
      repo = "comma";
      rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
      sha256 = "0n5a3rnv9qnnsrl76kpi6dmaxmwj1mpdd2g0b4n1wfimqfaz6gi1";
  }) {};

in

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
    comma
    coreutils
    delta
    exa
    fd
    fzf
    fontforge
    gitAndTools.hub
    go
    highlight
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

  # programs.git = {
  #   enable = true;
  #   userName = "Mickey Burks";
  #   userEmail = "brks.mck@gmail.com";
  #   aliases = {
  #     unstage = "reset HEAD --";
  #   };
  #   delta = {
  #     enable = true;
  #     options = {
  #       features = "side-by-side line-numbers decorations";
  #       syntax-theme = "Nord";
  #       side-by-side = true;
  #     };
  #   };
  #   extraConfig = {
  #     core = {
  #       excludesfile = "/Users/$USER/.gitignore";
  #     };
  #     pull = {
  #       rebase = true;
  #     };
  #   };
  # };

  programs.exa = {
    enable = true;
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

      export LS_COLORS="$(${pkgs.vivid}/bin/vivid generate molokai)"

      alias ls="${pkgs.exa}/bin/exa"
      alias la="${pkgs.exa}/bin/exa -a"
      alias ll="${pkgs.exa}/bin/exa -la --git"
      alias lt="${pkgs.exa}/bin/exa --tree"
    '';
    history.share = false;
    oh-my-zsh.enable = true;
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --max-depth 6 --type f --hidden --follow --exclude .git";
    defaultOptions = ["--height 40%" "--layout=reverse" "--border"];
    fileWidgetCommand = "fd --max-depth 7 --type f --hidden --follow --exclude .git";
    fileWidgetOptions = ["--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"];
    historyWidgetOptions = ["--sort" "--exact"];
    tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = ["-d 40%"];
    };
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
      nvim-treesitter-context
      nvim-treesitter-refactor
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
