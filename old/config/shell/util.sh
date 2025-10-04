# Shell-agnostic configuration (hopefully)

# nix
### ,           - run tool from nix-pkg without installing

# No idea why home-manager isn't doing this already
if [[ -e "$HOME/.nix-defexpr/channels" ]]; then
  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
fi

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


### hm          - home-manager switch
alias hm="command time home-manager switch --flake ~/.config/nixpkgs#$USER --impure && source ~/.zshrc"



### r/ranger    - ranger file explorer
alias r='ranger --cmd "set show_hidden=true"'



# -------------------------------
#
# change directories
#
# -------------------------------
### uu          - (u)p (u)p - cd to root parent `git` directory
function uu() {
  local cwd=$PWD
  local root=$(find_git_root $PWD)
  if [[ "$root" == "/" ]]; then
    echo "No root found"
  elif [[ "$root" == "$PWD" ]]; then
    echo "Already at root!"
  else
    cd $root
    echo "Found $(basename $root)"
  fi
}

### uud         - uu (d)ry run - echo root parent `git` directory
function uud() {
  find_git_root $PWD
}

### rel         - rel - print pwd relative to `git` root directory
function rel() {
  if [[ "$(pwd)" == "$(uud)" ]]; then
    echo "."
  else
    echo "${$(pwd)/$(uud)\//}"
  fi
}

# prints path at root of current `git` directory
function find_git_root() {
  if [[ -s "$1/.git" || "$1" == "/" ]]; then
    echo "$1"
  else
    find_git_root "$(dirname "$1")"
  fi
}

### c [-a]      - fuzzy cd (-a for hidden and ignored files)
function c() {
  FD_CMD="fd --max-depth 6 --type d"
  if [[ "$@" == *"-a"* ]]; then
    FD_CMD="fd --max-depth 6 --type d --hidden -I"
  fi
  local target=$(eval ${FD_CMD} | fzf --preview "tree -C {} | head -200")
  if [[ "$target" != "" ]]; then
    cd $target
  fi
}

### cpwd        - copy current working directory
function cpwd() {
  echo "cd $(pwd)" | pbcopy
}



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
  pbpaste > $1
}



# -------------------------------
#
# postgres
#
# -------------------------------
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin/
export PGDATA=$HOME/Library/Application\ Support/Postgres/var-10

### pglog       - tail postgres logs
alias pglog="tail -f $HOME/Library/Application\ Support/Postgres/var-10/postgresql.log"



# -------------------------------
#
# edit configuration
#
# -------------------------------
# Edit and source bash in one command - useful for testing commands as you write
### esh         - edit and source shell configuration
alias esh="vim ~/.config/nixpkgs/config/shell/util.sh && hm"



# -------------------------------
#
# external scripts
#
# -------------------------------
# machine specific setup
[ -r ~/.machine-specific.sh ] && . ~/.machine-specific.sh

# user scripts
export PATH="$HOME/bin:$HOME/machine-specific-scripts:$HOME/scripts:$PATH"



# -------------------------------
#
# miscellaneous utilities
#
# -------------------------------
### CMD | i CMD - use fzf/xargs to pipe stdin to another command
function i () {
  fzf | xargs "$@"
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

### show-files  - fix mac finder for hidden files
alias show-files='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'



# -------------------------------
#
# miscellaneous 3rd party setup
#
# -------------------------------
# emacs
alias emacs='/usr/local/bin/emacs'

### json        - pretty display json dump from stdin
alias json='python -m json.tool'

### j           - autojump
### jd          - j (d)ry run - echo first result from autojump
function jd() {
  local cwd=$(pwd)
  local root=$(j $1)
  cd $cwd
  echo $root
}

### pg          - use pgcli to fuzzy open a database
function dbs () {
  psql -l | awk 'NR>3 {if ($1 != "" && $1 !~ /^[|(]/) {print $1}}' | fzf
}
alias pg='pgcli $(dbs)'
