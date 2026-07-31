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
unalias g ga gb gcm gd gl gps gpl 2>/dev/null || true

# dotfiles utilities path
export PATH="$SHELL_UTILS:$PATH"

# Interactive shell wrappers for directory-changing utilities
function c() {
  local target=$(command c "$@")
  if [[ -n "$target" && -d "$target" ]]; then
    cd "$target"
  fi
}

function uu() {
  local root=$(command uu "$@")
  if [[ -n "$root" && -d "$root" ]]; then
    cd "$root"
    echo "Found $(basename "$root")"
  fi
}

function jd() {
  local cwd=$(pwd)
  local root=$(command jd "$@")
  if [[ -n "$root" && -d "$root" ]]; then
    cd "$root"
    echo "$root"
  fi
}

# Override zsh builtin 'r' to execute ranger utility script
alias r="command r"

# Environment & PATH settings
export PATH="$PATH:$HOME/depot_tools"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/17/bin"

if [[ "$(uname -s)" == "Darwin" ]]; then
  ulimit -n 200000
  alias ls="gls --color"
else
  ulimit -u unlimited 2>/dev/null || true
fi

alias ll="ls -al"

# NVM & Rust & Autojump
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -f /usr/local/opt/autojump/etc/profile.d/autojump.sh ] && . /usr/local/opt/autojump/etc/profile.d/autojump.sh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.zsh ] && . /usr/share/autojump/autojump.zsh

# Colors
if command -v vivid >/dev/null 2>&1; then
  export LS_COLORS="$(vivid generate nord)"
fi

# Zsh git completion helper
__git_files () { 
    _wanted files expl 'local files' _files     
}


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
