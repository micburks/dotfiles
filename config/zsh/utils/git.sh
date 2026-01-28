# -------------------------------
#
# git
#
# -------------------------------
[ "$(alias gcm)" != "" ] && unalias gcm
[ "$(alias gl)" != "" ] && unalias gl
[ "$(alias ga)" != "" ] && unalias ga

### g           - git
alias g='git'

# these are aliases so autocomplete works
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gb='git branch'
alias gl='git log'
alias gcm='git commit -m'
alias gps='git push'
alias gpl='git pull'

### gch         - git checkout (fuzzy branch checkout without args)
function gch() {
  if [[ "$1" == "" ]]; then
    git branch | i git checkout
    return
  fi

  git checkout "$@"
}

# improve speed of zsh autocomplete for git commands
__git_files () { 
    _wanted files expl 'local files' _files     
}

### git-stats   - log my stats for this repo (git-stats | pbcopy)
git-stats() {
  git log --author="$(git config user.name)" --numstat --oneline
}

file-exists() {
  while read -r filename; do
    test -f "$filename" && echo "$filename"
  done
}

GIT_COMMON_FILE=".ignore/git-common-files"

### git-common  - cache commonly edit files data for this repo
git-common() {
  mkdir -p "$(dirname $GIT_COMMON_FILE)"
  git log --author="$(git config user.name)" --numstat --oneline | \
    grep -E "^\w{1,4}\s" | \
    # grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} -E "^\w{1,4}\s" | \
    awk '{print $3}' | \
    file-exists | \
    sort | \
    uniq -c | \
    sort -r | \
    awk '{print $2}' \
    > $GIT_COMMON_FILE
}

### fzc         - fzo for commonly edited files
function fzc() {
  if [[ -e "$GIT_COMMON_FILE" ]]; then
    cat $GIT_COMMON_FILE | \
      fzf --no-height --preview 'bat --style=numbers --color=always {}' --no-sort | \
      xargs nvim {}
  else
    echo "run git-common first";
  fi
}
