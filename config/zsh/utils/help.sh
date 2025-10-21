UTILS_DIR="$HOME/.config/zsh/utils"
HELP_DIR="$HOME/.config/help"
# -------------------------------
#
# help
#
# -------------------------------
### help        - print all help comments or help for specific binaries (e.g. ag, fd, git, etc.)
help() {
  if [[ "$1" == "" ]]; then
    echo "\n custom commands\n ------"
    local cmds=""
    for util in "$UTILS_DIR"/*; do
      cmds="$cmds\n$(awk -F'###' '/^###/ { print $2 }' "$util")"
    done
    echo "$cmds" | sort
  elif [[ "$1" == "help" ]]; then
    awk -F'###' '/^###/ { print $2 }' "$HELP_DIR/$1"
    echo ""
    echo "\n custom help docs\n ------"
    echo "$(ls "$HELP_DIR")"
  elif [[ -e "$HELP_DIR/$1" ]]; then
    awk -F'###' '/^###/ { print $2 }' "$HELP_DIR/$1"
  else
    echo "no such help doc"
  fi
}
