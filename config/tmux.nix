{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ~/.config/nixpkgs/.tmux.conf;
  };
}
