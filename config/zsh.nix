{ config, pkgs, ... }:

{
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
        echo $(pwd) | sed -e "s/^$(echo $HOME | sed 's/\//\\\//g')\(.*\)$/~\1/"
      }
      # Show git branch name
      function parse_git_branch () {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
      }
      
      PROMPT='
      %{$fg[yellow]%}[$(parse_date)] %{$fg[green]%}$(parse_git_branch) %{$fg[blue]%}$(parse_pwd)
      %{$reset_color%}$ '
      ######################

      ${builtins.readFile ~/.config/nixpkgs/config/shared.sh}

      export LS_COLORS="$(${pkgs.vivid}/bin/vivid generate molokai)"

      alias ls="${pkgs.exa}/bin/exa"
      alias la="${pkgs.exa}/bin/exa -a"
      alias ll="${pkgs.exa}/bin/exa -la --git"
      alias lt="${pkgs.exa}/bin/exa --tree"
    '';
    history.share = false;
    oh-my-zsh.enable = true;
  };
}
