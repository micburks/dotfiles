source ~/.gen_shell

######################
# Show git branch name
function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Set colors
export TERM="xterm-256color"
RED="\[\033[0;31m\]" #$(tput setaf 1)
GREEN="\[\033[0;32m\]" # $(tput setaf 2)
YELLOW="\[\033[0;33m\]" # $(tput setaf 3)
BLUE="\[\033[0;34m\]" # $(tput setaf 4)
NO_COLOR="\[\033[0m\]" # $(tput sgr0)

# Set terminal prompt
PS1="\n$YELLOW[\d] $GREEN\$(parse_git_branch) $BLUE\w $NO_COLOR\n\$ "

######################
