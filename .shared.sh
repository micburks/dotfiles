# Shell-agnostic configuration (hopefully)



# -------------------------------
#
# help
#
# -------------------------------
### help        - print all help comments or help for specific binaries (e.g. ag, fd, git, etc.)
help() {
  if [[ "$1" == "" ]]; then
    echo "\n shared\n ------"
    awk -F'###' '/^###/ { print $2 }' ~/.shared.sh | sort
    echo "\n machine-specific\n ----------------"
    awk -F'###' '/^###/ { print $2 }' ~/.machine-specific.sh | sort
  elif [[ "$1" == "help" ]]; then
    awk -F'###' '/^###/ { print $2 }' ~/Code/oss/dotfiles/help/$1
    echo ""
    echo "$(ls ~/Code/oss/dotfiles/help)"
  else
    awk -F'###' '/^###/ { print $2 }' ~/Code/oss/dotfiles/help/$1
  fi
}



# -------------------------------
#
# git
#
# -------------------------------
[ "$(alias gcm)" != "" ] && unalias gcm
[ "$(alias gl)" != "" ] && unalias gl
[ "$(alias ga)" != "" ] && unalias ga

### g/git       - git
alias g='git'

# these are aliases so autocomplete works
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gb='git branch'
alias gl='git log'
alias gch='git checkout'
alias gcm='git commit -m'
alias gps='git push'
alias gpl='git pull'

### pr-checkout - interactively find pr and checkout that branch
function pr-checkout() {
  get-pr-number | xargs hub pr checkout
}

### pr-open     - interactively find pr and open in the browser
function pr-open() {
  get-pr-number | xargs hub pr show
}

### pr-release  - open `Release` PR in browser
function pr-release() {
  hub pr list | fzf -q Release -1 | extract-pr-number | xargs hub pr show
}

### browse      - open current branch or branch PR in GitHub
function browse() {
  # open current branch PR in GitHub
  # if no PR, open current branch in GitHub 
  # doesn't work for forks
  local PR_URL=$(get-pr-url-for-branch)
  if [[ -n $PR_URL ]] then
    open $PR_URL
  else
    hub browse -- tree/$(get-branch-name)
  fi
}

# utility functions

# start interactive fuzzy find of current prs
# return pr number of selected pr
function get-pr-number() {
  hub pr list | fzf | extract-pr-number
}

# input: tabular output of `hub pr list`
# output: pr number
function extract-pr-number() {
  awk '{print substr($1,2)}'
}

# return
# - url of open pr for current branch
# - void otherwise
function get-pr-url-for-branch() {
  hub pr list --format='%H %U%n' | awk "\$1==\"$(get-branch-name)\" {print \$2}"
}

# return name of current branch
function get-branch-name () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}



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
alias n8='nvm exec 8 node'
alias n10='nvm exec 10 node'
alias n12='nvm exec 12 node'
alias n14='nvm exec 14 node'

### vn          - (v)irtual (n)ode - switch to compatible node/yarn versions
alias vn='virtualnode'
virtualnode () {
  if [[ $(node -p -e "require('./package.json').engines") ]]; then
    nodeengine_nodever=$(node -p -e "require('./package.json').engines.node")
    echo $nodeengine_nodever
    sanitized_nodever=$(echo $nodeengine_nodever | tr -d '\>\<\=' | cut -d' ' -f1)
    if [[ $sanitized_nodever ]]; then
      echo "Updating node from $(node -v) to $sanitized_nodever..."
      nvm use $sanitized_nodever
      #. ~/.nvm/nvm.sh use $sanitized_nodever
    fi  
    nodeengine_yarnver=$(node -p -e "require('./package.json').engines.yarn")
    sanitized_yarnver=$(echo $nodeengine_yarnver | tr -d '\>\<\=' | cut -d' ' -f1) 
    if [[ $sanitized_yarnver ]]; then
      echo "Updating yarn from $(yarn -v) to $sanitized_yarnver..."       
      #yvm install $sanitized_yarnver
      yvm use $sanitized_yarnver
      #. ~/.yvm/yvm.sh use $sanitized_yarnver
    fi      
  fi
}

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# yvm
export YVM_DIR=/Users/MICKEY/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh



# -------------------------------
#
# vim
#
# -------------------------------
### v/vi/vim    - vim (wrapped): prevent implicitly opening new files
export EDITOR=vim
# Necessary for colors to work in tmux
export TERM=xterm-256color
alias v='vim'
alias vi='vim'
function vim() {
  local original_args=("$@")
  local vim_args=()
  local filtered_vim_args=()
  local new=0
  local fail=0

  # check for "--new"
  for arg in "${original_args[@]}"; do
    if [[ "$arg" == "--new" || "$arg" == "-n" ]]; then
      new=1
    else
      vim_args+=( "$arg" )
    fi
  done

  if (( new )); then
    # if "--new", let vim create new files
    command vim -p "${vim_args[@]}"
  else
    # if not "--new", filter non-existant files
    for file in "${vim_args[@]}"; do
      # ignore options
      [[ $file = -* ]] && continue

      if ! [[ -e $file ]]; then
        printf '[vim wrapper] ignored argument "%s" - no such file or directory\n' "$file" >&2
        fail=1
      elif [[ -d $file ]]; then
        printf '[vim wrapper] ignored argument "%s" - refusing to open directory\n' "$file" >&2
        fail=1
      else
        filtered_vim_args+=( $file )
      fi
    done

    if (( fail )); then
      echo -e "[vim wrapper] filtered arguments - force default behavior by using \"--\e[4mn\e[0mew\"\n"
      echo "  vim $@ -n"
    fi

    if [[ "$filtered_vim_args" == "" ]]; then
      if (( fail )); then
        # extra space after previous log
        echo ""
      fi
      echo "[vim wrapper] no files to open"
    else
      command vim -p "${filtered_vim_args[@]}"
    fi
  fi
}

### r/ranger    - ranger file explorer
alias ranger='~/bin/ranger/ranger.py --cmd "set show_hidden=true"'
alias r="ranger"



# -------------------------------
#
# ls
#
# -------------------------------
# ls colors
eval $(dircolors ~/.nix-profile/share/LS_COLORS)
alias ls='ls --color=auto -F'



# -------------------------------
#
# change directories
#
# -------------------------------
### uu          - (u)p (u)p - cd to root parent `git` directory
function uu() {
  local cwd=$(pwd)
  local root=$(find_git_root)
  if [[ "$root" == "/" ]]; then
    cd $cwd
    echo "No root found"
  else
    cd $root
    echo "Found $(basename $root)"
  fi
}

### uud         - uu (d)ry run - echo root parent `git` directory
function uud() {
  local cwd=$(pwd)
  local root=$(find_git_root)
  cd $cwd
  echo $root
}

# prints path at root of current `git` directory
# contains side-effect of changing to root directory
function find_git_root() {
  if [[ -s ".git" || "$(pwd)" == "/" ]]; then
    pwd
  else
    cd ..
    find_git_root
  fi
}

### c           - fuzzy cd
function c() {
  local target=$(fd --max-depth 6 --type d | fzf --preview "tree -C {} | head -200")
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
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --max-depth 6 --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --max-depth 7 --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"


### fzp         - fuzzy preview files
alias fzp="fzf --no-height --preview 'bat --style=numbers --color=always {}'"

### fzo         - fuzzy open files
alias fzo='vi $(fzp)'

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
export PGDATA=/Users/MICKEY/Library/Application\ Support/Postgres/var-10

### pglog       - tail postgres logs
alias pglog="tail -f /Users/MICKEY/Library/Application\ Support/Postgres/var-10/postgresql.log"



# -------------------------------
#
# edit configuration
#
# -------------------------------
# Edit and source bash in one command - useful for testing commands as you write
### esh         - edit and source shared shell configuration
alias esh="vi ~/.shared.sh && source ~/.shared.sh"
### ezsh        - edit and source .zshrc configuration
alias ezsh="vi ~/.zshrc && source ~/.zshrc"



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
[[ -s /Users/MICKEY/.autojump/etc/profile.d/autojump.sh ]] && source /Users/MICKEY/.autojump/etc/profile.d/autojump.sh

# nix
### ,           - run tool from nix-pkg without installing
if [ -e /Users/MICKEY/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/MICKEY/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
