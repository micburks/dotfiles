# user bin
export PATH="$PATH:$HOME/bin"

# psql
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/17/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
#
# might be this...
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh" # This loads nvm
#
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
# or might be this...
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# rust
[ -f "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# vivid
export LS_COLORS="$(vivid generate nord)"
if [[ "$(uname -s)" == "Darwin" ]]; then
  alias ls="gls --color"
fi
alias ll="ls -al"

### show-files  - fix mac finder for hidden files
alias show-files='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

# -------------------------------
#
# fuzzy find
#
# -------------------------------
### fzf         - fuzzy find files
#export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
#export FZF_DEFAULT_COMMAND='fd --max-depth 6 --type f --hidden --follow --exclude .git'
#export FZF_CTRL_T_COMMAND='fd --max-depth 7 --type f --hidden --follow --exclude .git'
#export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

### fzp         - fuzzy preview files
alias fzp="fzf --no-height --preview 'bat --style=numbers --color=always {}'"

### fzo         - fuzzy open files
alias fzo='vim $(fzp)'

### fzr [DIR]   - fuzzy open files by contents
function fzr() {
  vim $(rg . $1 | fzf | cut -d ":" -f 1)
}

### smth        - find some file somewhere
function smth() {
  fd . ~/Code -H -d 9 -E node_modules | fzf
}

### kill-smth   - fzf kill something
function kill-smth() {
  kill -9 $(ps aux | fzf | awk 'NR<2 {print $2}')
}

### kill-grep   - kill anything that matches a string using grep
function kill-grep() {
  local all=$(ps aux | grep $1 | awk 'NR<2 {print $2}')
  echo $all
  kill -9 $all
}

# -------------------------------
#
# copy/paste
#
# -------------------------------
### copy FILE   - copy file contents
function copy() {
  cat $1 | pbcopy
}

### paste FILE  - destructively paste clipboard contents to file
function paste() {
  pbpaste >$1
}

# -------------------------------
#
# miscellaneous utilities
#
# -------------------------------
### CMD | i CMD - use fzf/xargs to pipe stdin to another command
function i() {
  fzf | xargs "$@"
}

### cl          - clear half of terminal
function cl() {
  half=$(stty size | awk '{print int($1/2)-1;}')
  echo $half
  for i in $(seq ${half}); do
    echo ''
  done
  tput cup ${half} 0 && tput ed
}

### json        - pretty display json dump from stdin
alias json='python -m json.tool'
