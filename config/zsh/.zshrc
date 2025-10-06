MACHINE_NAME="local"
CONFIG="$HOME/.config"
SHELL_UTILS="$CONFIG/zsh/utils"

export XDG_CONFIG_HOME="$CONFIG"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export VIMRC="$CONFIG/nvim/vimrc.vim"

# Used by ranger.py for editing.
export VISUAL="vim -p -u $VIMRC"
# Used by git for editing commit messages.
export EDITOR="$VISUAL"
# Used by ranger.py for previews.
export PAGER=bat

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
