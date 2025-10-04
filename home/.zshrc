CONFIG="$HOME/.config"
DOTFILES="$CONFIG/dotfiles"
CONFIG_SRC="$DOTFILES/config"
HOME_SRC="$DOTFILES/home"
SHELL_SRC="$DOTFILES/shell"

MACHINE_NAME="local"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh


# dotfiles
[ -f $SHELL_SRC/cd.sh ] && . $SHELL_SRC/cd.sh
[ -f $SHELL_SRC/chromium.sh ] && . $SHELL_SRC/chromium.sh
[ -f $SHELL_SRC/git.sh ] && . $SHELL_SRC/git.sh
[ -f $SHELL_SRC/help.sh ] && . $SHELL_SRC/help.sh
[ -f $SHELL_SRC/util.sh ] && . $SHELL_SRC/util.sh
[ -f $SHELL_SRC/vim.sh ] && . $SHELL_SRC/vim.sh


# work machine specific things
[ -f $HOME/work-DO-NOT-COMMIT.sh ] && . $HOME/work-DO-NOT-COMMIT.sh


# prompt
function get_hostname () {
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

function chpwd () {
export GIT_ROOT=$(uud)
}
chpwd
