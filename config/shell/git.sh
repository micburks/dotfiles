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
