{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    extraConfig = builtins.readFile ~/.config/nixpkgs/config/tmux.conf;
  };
}
