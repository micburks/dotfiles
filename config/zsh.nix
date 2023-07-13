{ config, pkgs, lib, machine-name, ... }:

let
  shellDir = ~/.config/nixpkgs/config/shell;
  dirContents = builtins.attrNames (builtins.readDir shellDir);
  fileNames = map (file: shellDir + "/${file}") dirContents;
  concatContents = lib.foldr(a: b: (builtins.readFile a) + b) "";
  shellContents = concatContents fileNames;
in
{
  xdg.configFile."help".source = ../help;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    initExtra = ''
      # binaries installed with nix
      export PATH="$HOME/.nix-profile/bin:$PATH"
      export PATH="$PATH:/nix/var/nix/profiles/default/bin/"

      function get_hostname () {
        local MACHINE_NAME="${machine-name}"
        if [ -n "$TMUX" ]; then
          echo "tmux:$MACHINE_NAME"
        else
          echo $MACHINE_NAME
        fi
      }
      function parse_git_branch () {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
      }
      function parse_repo_basename () {
        if [[ "$GIT_ROOT" != "/" ]]; then
          echo "[$(basename $GIT_ROOT)] "
        fi
      }
      function parse_pwd () {
        if [[ $GIT_ROOT == $PWD ]]; then
          echo "- "
        elif [[ $GIT_ROOT == "/" ]]; then
          echo $PWD | sed -e "s/^$(echo $HOME | sed 's/\//\\\//g')/~/"
        else
          echo $PWD | sed -e "s/^$(echo "$GIT_ROOT" | sed 's/\//\\\//g')\///"
        fi
      }
      PROMPT='%{$fg[yellow]%}$(parse_repo_basename)%{$fg[green]%}$(parse_git_branch)%{$fg[red]%}<$(get_hostname)> %{$fg[blue]%}$(parse_pwd)
      %{$reset_color%}$ '

      ${shellContents}

      function chpwd () {
        export GIT_ROOT=$(uud)
      }
      chpwd

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
