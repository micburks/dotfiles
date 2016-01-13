# Generic
alias vi='vim -p'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ll -a'
alias grep='grep --color=auto'


######################
# Show git branch name
function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0m\]"

PS1="$GREEN\u@\h$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "
######################


# If Mac
if [ $(uname -s) = 'Darwin' ]; then

    # DNS
    alias dnsflush='sudo discoveryutil udnsflushcaches'

    # Postgres config - Mac install of Postgres.App
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
    export PGDATA=/Users/mickey/Library/Application\ Support/Postgres/var-9.4

    # Composer installs - Mac
    export PATH=$PATH:/Users/mickey/.composer/vendor/bin

    alias ls='ls -G'
fi

# Aquameta aliases
if [ -f ~/.aquameta_aliases ]; then
    source ~/.aquameta_aliases
fi

# MAB aliases
if [ -f ~/.mab_aliases ]; then
    source ~/.mab_aliases
fi
