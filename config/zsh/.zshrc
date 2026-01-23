CONFIG="$HOME/.config"
MACHINE_FILE="$CONFIG/dotfiles/machine.txt"

# Prompt for machine name if not already named.
if [[ ! -f "$MACHINE_FILE" ]]; then
  vared -p "No machine name found. What would you like to name this machine: " -c name
  echo "$name" > $MACHINE_FILE
  echo "Wrote $name to $MACHINE_FILE"
fi

MACHINE_NAME=$(cat "$MACHINE_FILE")
SHELL_UTILS="$CONFIG/zsh/utils"

export XDG_CONFIG_HOME="$CONFIG"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export VIMRC="$CONFIG/nvim/vimrc.vim"
export HOMEBREW_NO_AUTO_UPDATE=1

# Oh my zsh auto-update
zstyle ':omz:update' mode disabled

# Extra local binaries
export PATH=$PATH:$HOME/.local/bin

# Used by ranger.py for editing.
export VISUAL="vim -p -u $VIMRC"
# Used by git for editing commit messages.
export EDITOR="$VISUAL"
# Used by ranger.py for previews.
export PAGER=bat

# Required by ranger
export TERM=xterm-256color

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# dotfiles
[ -f $SHELL_UTILS/cd.sh ] && . $SHELL_UTILS/cd.sh
[ -f $SHELL_UTILS/chromium.sh ] && . $SHELL_UTILS/chromium.sh
[ -f $SHELL_UTILS/git.sh ] && . $SHELL_UTILS/git.sh
[ -f $SHELL_UTILS/help.sh ] && . $SHELL_UTILS/help.sh
[ -f $SHELL_UTILS/util.sh ] && . $SHELL_UTILS/util.sh
[ -f $SHELL_UTILS/vim.sh ] && . $SHELL_UTILS/vim.sh


# work machine specific things
[ -f $HOME/.work-DO-NOT-COMMIT.sh ] && . $HOME/.work-DO-NOT-COMMIT.sh


# prompt
function get_hostname () {
  if [ -n "$TMUX" ]; then
    echo "tmux:$MACHINE_NAME"
  else
    echo $MACHINE_NAME
  fi
}

function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function parse_repo_basename () {
  if [[ "$GIT_ROOT" != "/" ]]; then
    echo "$(basename $GIT_ROOT)"
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

function get_repo_at_branch () {
  repo=$(parse_repo_basename)
  branch=$(parse_git_branch)
  if [[ $branch != "" ]]; then
    repo="$repo @ $branch"
  fi
  if [[ $repo != "" ]]; then
    echo "($repo) "
  fi
}

# https://www.nordtheme.com/
declare -A c
c[yellow]="%F{#ebcb8b}"
c[green]="%F{#a3be8c}"
c[red]="%F{#bf616a}"
c[blue]="%F{#5e81ac}"

timestamp="[%D{%H:%M:%S}] "

PROMPT='%{$c[yellow]%}$(echo $timestamp)%{$c[green]%}$(get_repo_at_branch)%{$c[red]%}<$(get_hostname)> %{$c[blue]%}$(parse_pwd)
%{$reset_color%}$ '

function chpwd () {
export GIT_ROOT=$(uud)
}
chpwd
