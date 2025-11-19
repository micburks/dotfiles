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

### git-common  - cache commonly edit files data for this repo
git-common() {
  git log --author="$(git config user.name)" --numstat --oneline | \
    grep -E "^\w{1,4}\s" | \
    # grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} -E "^\w{1,4}\s" | \
    awk '{print $3}' | \
    file-exists | \
    sort | \
    uniq -c | \
    sort -r | \
    awk '{print $2}' \
    > "common-files"
}

### fzc         - fzo for commonly edited files
function fzc() {
  if [[ -e "common-files" ]]; then
    cat "common-files" | \
      fzf --no-height --preview 'bat --style=numbers --color=always {}' --no-sort | \
      xargs nvim {}
  else
    echo "run git-common first";
  fi
}
