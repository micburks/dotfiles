{ config, pkgs, email, ... }:

let
  git = import ./config/git.nix { inherit config pkgs email; };
in
{
  programs.home-manager.enable = true;
  news.display = "silent";

  xdg.enable = true;
  xdg.configFile."nix/nix.conf".source = ./nix/nix.conf;
  xdg.configFile."sqls".source = ./sqls;
  xdg.configFile."pgcli".source = ./pgcli;

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  imports = [
    git
    ./config/nvim.nix
    ./config/tmux.nix
    ./config/zsh.nix
  ];

  home.packages = with pkgs; [
    alacritty
    autojump
    bat
    coreutils
    delta
    direnv
    efm-langserver
    exa
    fd
    fzf
    fontforge
    gawk
    gitAndTools.hub
    go
    highlight
    jq
    lazygit
    (nerdfonts.override { fonts = [ "RobotoMono" ]; })
    pgcli
    ranger
    ripgrep
    rust-analyzer
    rustup
    silver-searcher
    sqls
    # sumneko-lua-language-server
    tree
    vivid
    yarn
  ];

  programs.exa = {
    enable = true;
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

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        "TERM" = "xterm-256color";
      };
      window = {
        decorations = "none";
        startup_mode = "Windowed";
        dimensions = {
          columns = 0;
          lines = 0;
        };
        padding = {
          x = 2;
          y = 0;
        };
      };
      scrolling = {
        history = 10000;
        multiplier = 3;
        faux_multiplier = 3;
        auto_scroll = false;
      };
      font = {
        size = 12.0;
        use_thin_strokes = false;
        offset = {
          x = 0;
          y = 2;
        };
        normal = {
          family = "RobotoMono Nerd Font";
          style = "Regular";
        };
      };
      draw_bold_text_with_bright_colors = true;
      colors.primary = {
        background = "0x393a3c";
        foreground = "0xdadfe0";
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };
}
