# -------------------------------
#
# change directories
#
# -------------------------------
#
# autojump

# could be this...
[ -f /usr/local/opt/autojump/etc/profile.d/autojump.sh ] && . /usr/local/opt/autojump/etc/profile.d/autojump.sh
# or this
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
# or this
[ -f /usr/share/autojump/autojump.zsh ] && . /usr/share/autojump/autojump.zsh

### j           - autojump
### jd          - j (d)ry run - echo first result from autojump
function jd() {
  local cwd=$(pwd)
  local root=$(j $1)
  cd $cwd
  echo $root
}

### r/ranger    - ranger file explorer
alias r='ranger --cmd "set show_hidden=true"'

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
