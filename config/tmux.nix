{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    extraConfig = builtins.readFile ~/.config/nixpkgs/config/tmux.conf;
    newSession = true;
    plugins = with pkgs.tmuxPlugins; [
    {
      plugin = resurrect;
      extraConfig = "set -g @resurrect-strategy-nvim 'session'";
    }
    {
      plugin = continuum;
      extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '60' # minutes
        '';
    }
    {
      plugin = extrakto;
      extraConfig = ''
        set -g @extrakto_copy_key "tab"      # use tab to copy to clipboard
        set -g @extrakto_insert_key "enter"  # use enter to insert selection
        '';
    }
    ];
  };
}
