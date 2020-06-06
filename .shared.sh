# If mcahine specific setup
[ -r ~/.machine-specific.sh ] && . ~/.machine-specific.sh

export EDITOR=vim

# ls colors
eval $(dircolors ~/.nix-profile/share/LS_COLORS)

# utils
alias v='vim -p'
alias vi='vim -p'
alias ls='ls --color=auto -F'
alias vn='virtualnode'

[ "$(alias gcm)" != "" ] && unalias gcm
[ "$(alias gl)" != "" ] && unalias gl
[ "$(alias ga)" != "" ] && unalias ga

# git
function g () { git $@ }
function gs () { git status $@ }
function ga () { git add $@ }
function gd () { git diff $@ }
function gb () { git branch $@ }
function gl () { git log $@ }
function gch () { git checkout $@ }
function gcm () { git commit -m $@ }
function gps () { git push $@ }
function gpl () { git pull $@ }

# utils
function uu() {
  # go to root directory of current git repo
  if [ -s ".git" ]; then
    return
  else
    cd ..
    uu
  fi
}

function i () {
  local get=$1;
  shift;
  $get | fzf | xargs $@
}

function cl () {
  half=$(stty size | awk '{print int($1/2)-1;}')
  echo $half
  for i in `seq ${half}`;
    do echo ''
  done
  tput cup ${half} 0 && tput ed
}

function lb () {
  vim ~/logbook/$(date '+%Y-%m-%d').md
}

function copy() {
  cat $1 | pbcopy
}

function paste() {
  pbpaste > $1
}

# If Mac
if [ $(uname -s) = 'Darwin' ]; then
  # Postgres config - Mac install of Postgres.App
  #export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/{VERSION}/bin
  #export PGDATA=/Users/MICKEY/Library/Application\ Support/Postgres/var-{VERSION}
  #alias pglog='tail -f /Users/MICKEY/Library/Application\ Support/Postgres/var-{VERSION}/postgresql.log'

  export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin/
  export PGDATA=/Users/MICKEY/Library/Application\ Support/Postgres/var-10
  alias pglog="tail -f /Users/MICKEY/Library/Application\ Support/Postgres/var-10/postgresql.log"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# node
alias n8='nvm exec 8'
alias n10='nvm exec 10'
alias n12='nvm exec 12'
alias n14='nvm exec 14'

# source scripts
source ~/scripts/virtualnode.sh
source ~/scripts/pull-requests

# Emacs
alias emacs='/usr/local/bin/emacs'

# JSON tool
alias json='python -m json.tool'

# Ranger
alias r="ranger"

# Edit and source bash in one command - useful for testing commands as you write
alias esh="vi ~/.shared.sh && source ~/.shared.sh"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# yvm
export YVM_DIR=/Users/MICKEY/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

# show hidden files in finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

# fuzzy find with colors
alias fzp="fzf --preview 'bat --style=numbers --color=always {}'"
alias fzo='vi $(fzp)'

# fzf options
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f'

# user scripts
export PATH="$HOME/bin:$HOME/machine-specific-scripts:$HOME/scripts:$PATH"

# nix
if [ -e /Users/mburks/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/mburks/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
