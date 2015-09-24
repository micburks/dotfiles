# Generic
alias vi='vim'
alias ls='ls -G'
alias ll='ls -l'
alias la='ll -a'
alias grep='grep --color=auto'

# If Mac
if [ $(uname -s) = 'Darwin' ]; then

    # DNS
    alias dnsflush='sudo discoveryutil udnsflushcaches'

    # Postgres config - Mac install of Postgres.App
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
    export PGDATA=/Users/mickey/Library/Application\ Support/Postgres/var-9.4

    # Composer installs - Mac
    export PATH=$PATH:/Users/mickey/.composer/vendor/bin
fi

# Aquameta aliases
if [ -f ~/.aquameta_aliases ]; then
    source ~/.aquameta_aliases
fi

# MAB aliases
if [ -f ~/.mab_aliases ]; then
    source ~/.mab_aliases
fi
