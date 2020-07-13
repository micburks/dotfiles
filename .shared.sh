### help        - print all help comments
help() {
  awk -F'###' '/^###/ { print $2 }' ~/.shared.sh
}

# If machine specific setup
[ -r ~/.machine-specific.sh ] && . ~/.machine-specific.sh

# -------------------------------
#
# git
#
# -------------------------------
[ "$(alias gcm)" != "" ] && unalias gcm
[ "$(alias gl)" != "" ] && unalias gl
[ "$(alias ga)" != "" ] && unalias ga
alias g='git'
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gb='git branch'
alias gl='git log'
alias gch='git checkout'
alias gps='git push'
alias gpl='git pull'



# -------------------------------
#
# node
#
# -------------------------------
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### nX          - run node using specific version (8/10/12/14)
alias n8='nvm exec 8'
alias n10='nvm exec 10'
alias n12='nvm exec 12'
alias n14='nvm exec 14'



# -------------------------------
#
# utils
#
# -------------------------------
### v/vi/vim    - vim
export EDITOR=vim
alias v='vim -p'
alias vi='vim -p'

# ls colors
eval $(dircolors ~/.nix-profile/share/LS_COLORS)
alias ls='ls --color=auto -F'

### vn          - switch to compatible node/yarn versions
alias vn='virtualnode'

### uu          - cd to root parent `git` directory
function uu() {
  # go to root directory of current git repo
  if [ -s ".git" ]; then
    return
  else
    cd ..
    uu
  fi
}

### i           - interactively pipe first command to second command
function i () {
  local get=$1;
  shift;
  $get | fzf | xargs $@
}

### cl          - clear half of terminal
function cl () {
  half=$(stty size | awk '{print int($1/2)-1;}')
  echo $half
  for i in `seq ${half}`;
    do echo ''
  done
  tput cup ${half} 0 && tput ed
}

### lb          - open daily logbook
function lb () {
  vim ~/logbook/$(date '+%Y-%m-%d').md
}

### copy FILE   - copy file contents
function copy() {
  cat $1 | pbcopy
}

### paste FILE  - destructively paste clipboard contents to file
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
### pglog       - tail postgres logs
  alias pglog="tail -f /Users/MICKEY/Library/Application\ Support/Postgres/var-10/postgresql.log"
fi

# source scripts
source ~/scripts/virtualnode.sh
source ~/scripts/pull-requests

# Edit and source bash in one command - useful for testing commands as you write
### esh         - edit and source shared shell configuration
alias esh="vi ~/.shared.sh && source ~/.shared.sh"

# user scripts
export PATH="$HOME/bin:$HOME/machine-specific-scripts:$HOME/scripts:$PATH"

# show hidden files in finder
### showFiles   - fix mac finder for hidden files
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'



# -------------------------------
#
# 3rd party
#
# -------------------------------
# Emacs
alias emacs='/usr/local/bin/emacs'

### json        - pretty display json dump from stdin
alias json='python -m json.tool'

### r/ranger    - ranger file explorer
alias ranger="~/bin/ranger/ranger.py"
alias r="ranger"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# yvm
export YVM_DIR=/Users/MICKEY/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

# autojump
### j           - autojump
[[ -s /Users/MICKEY/.autojump/etc/profile.d/autojump.sh ]] && source /Users/MICKEY/.autojump/etc/profile.d/autojump.sh

# fzf options
### fzf         - fuzzy find files
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f'

# fuzzy find with colors
### fzp         - fuzzy preview files
alias fzp="fzf --preview 'bat --style=numbers --color=always {}'"
### fzo         - fuzzy open files
alias fzo='vi $(fzp)'

# nix
### ,           - run tool from nix-pkg without installing
if [ -e /Users/MICKEY/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/MICKEY/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
