alias vi='vim -p'
alias ls='ls -G'
alias ll='ls -l'
alias la='ll -a'
alias grep='grep --color=auto'

function lb () {
  vim ~/logbook/$(date '+%Y-%m-%d').md
}

# If Mac
if [ $(uname -s) = 'Darwin' ]; then
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

# source scripts
source ~/scripts/node_env
source ~/scripts/pull-requests

# Emacs
alias emacs='/usr/local/bin/emacs'

# JSON tool
alias json='python -m json.tool'

# Ranger
alias ranger="~/bin/ranger/ranger.py"

# Edit and source bash in one command - useful for testing commands as you write
alias esh="vi ~/.shared.sh && source ~/.shared.sh"

# cd back to previous directory
alias back="cd $OLDPWD"

function copy() {
  cat $0 | pbcopy
}

function paste() {
  pbpaste > $0
}

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# show hidden files in finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

# autojump
[[ -s /Users/mickey/.autojump/etc/profile.d/autojump.sh ]] && source /Users/mickey/.autojump/etc/profile.d/autojump.sh

# fuzzy find with colors
alias fzp="fzf --preview 'bat --style=numbers --color=always {}'"
alias fzo='vi $(fzp)'
export FZF_DEFAULT_COMMAND='fd --type f'

# user bins
export PATH=~/bin:$PATH

