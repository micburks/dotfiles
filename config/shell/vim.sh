# -------------------------------
#
# vim
#
# -------------------------------
### v/vi/vim    - vim (wrapped): prevent implicitly opening new files
export EDITOR=nvim
# Necessary for colors to work in tmux
export TERM=xterm-256color
export XDG_CONFIG_HOME=$HOME/.config
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
    nvim -p "${vim_args[@]}"
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
      nvim -p "${filtered_vim_args[@]}"
    fi
  fi
}
