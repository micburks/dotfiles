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
alias nvim='vim'
function vim() {
  local original_args=("$@")
  local vim_args=()
  local filtered_vim_args=()
  local new=0
  local fail=0

  if [[ "$@" == "" ]]; then
    vim_unmerged
    return
  fi

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
    command nvim -p "${vim_args[@]}"
  else
    # if not "--new", filter non-existent files
    for file in "${vim_args[@]}"; do
      # ignore options
      [[ $file = -* ]] && continue

      if ! [[ -e $file ]]; then
        printf '[vim wrapper] ignored argument "%s" - no such file or directory\n' "$file" >&2
        fail=1
      # after switching to nvim, there is a much better behavior with opening a directory
      #elif [[ -d $file ]]; then
        #printf '[vim wrapper] ignored argument "%s" - refusing to open directory\n' "$file" >&2
        #fail=1
      else
        filtered_vim_args+=( $file )
      fi
    done

    if (( fail )); then
      echo -e "[vim wrapper] filtered arguments - force default behavior by using \"--\e[4mn\e[0mew\"\n"
      echo "  vim $@ -n"
      echo ""
    fi

    if [[ "$filtered_vim_args" == "" ]]; then
      echo "[vim wrapper] no files to open"
    else
      command nvim -p "${filtered_vim_args[@]}"
    fi
  fi
}

# open unmerged files if they exist
function vim_unmerged() {
  local unmerged="$(git diff --name-only --diff-filter=U)"
  if [[ "$unmerged" != "" ]]; then
    # mac
    echo $unmerged | xargs command nvim -p
    # linux
    # echo $unmerged | xargs nvim -p
  else
    echo "[vim_unmerged] no unmerged files to open"
  fi
}
