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

    alias ls='ls -G'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# JSON tool
alias json='python -m json.tool'

# Add npm bin to PATH
alias npm-bin='PATH=$(npm bin):$PATH'
