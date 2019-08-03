
# Generic
alias vi='vim -p'
alias ls='ls -G'
alias ll='ls -l'
alias la='ll -a'
alias grep='grep --color=auto'

# Open daily logbook
function lb () {
  vim ~/logbook/$(date '+%Y-%m-%d').md
}

######################
# Show git branch name
function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set colors
export TERM="xterm-256color"
RED="\[\033[0;31m\]" #$(tput setaf 1)
GREEN="\[\033[0;32m\]" # $(tput setaf 2)
YELLOW="\[\033[0;33m\]" # $(tput setaf 3)
BLUE="\[\033[0;34m\]" # $(tput setaf 4)
NO_COLOR="\[\033[0m\]" # $(tput sgr0)

# Set terminal prompt
PS1="\n$YELLOW[\d] $GREEN\$(parse_git_branch) $BLUE\w $NO_COLOR\n\$ "

######################

# If Mac
if [ $(uname -s) = 'Darwin' ]; then

    # DNS
    #alias dnsflush='sudo discoveryutil udnsflushcaches'

    # Postgres config - Mac install of Postgres.App
    #export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/{VERSION}/bin
    #export PGDATA=/Users/mickey/Library/Application\ Support/Postgres/var-{VERSION}
    #alias pglog='tail -f /Users/mickey/Library/Application\ Support/Postgres/var-{VERSION}/postgresql.log'

    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin/
    export PGDATA=/Users/mickey/Library/Application\ Support/Postgres/var-10
    alias pglog="tail -f /Users/mickey/Library/Application\ Support/Postgres/var-10/postgresql.log"

    alias ls='ls -G'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/scripts/node_env

# Emacs
alias emacs='/usr/local/bin/emacs'

# JSON tool
alias json='python -m json.tool'

# Ranger
alias ranger="~/bin/ranger/ranger.py"

# Edit and source bash in one command - useful for testing commands as you write
alias edit_bash="vi ~/.bash_profile && source ~/.bash_profile"

# cd back to previous directory
alias back="cd $OLDPWD"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

# User bins
export PATH=~/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

