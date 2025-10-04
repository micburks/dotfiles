# -------------------------------
#
# help
#
# -------------------------------
### help        - print all help comments or help for specific binaries (e.g. ag, fd, git, etc.)
help() {
  if [[ "$1" == "" ]]; then
    echo "\n custom commands\n ------"
    awk -F'###' '/^###/ { print $2 }' ~/.zshrc | sort
  elif [[ "$1" == "help" ]]; then
    awk -F'###' '/^###/ { print $2 }' ~/.config/help/$1
    echo ""
    echo "\n custom help docs\n ------"
    echo "$(ls ~/.config/help)"
  elif [[ -e ~/.config/help/$1 ]]; then
    awk -F'###' '/^###/ { print $2 }' ~/.config/help/$1
  else
    echo "no such help doc"
  fi
}
