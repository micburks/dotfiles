# chromium

# depot_tools
export PATH="$PATH:$HOME/depot_tools"

# need more FDs for chromium build
if [[ "$(uname -s)" == "Darwin" ]]; then
  ulimit -n 200000
else
  ulimit -u unlimited
fi

### reset-wnp   - [CHROME] reset wn page
function reset-wnp() {
  if [[ "$1" == "" ]]; then
    echo "need 'chromium' or 'google-chrome'"
    return
  fi
  cat "$HOME/.config/$1/Local State" | jq '.browser.last_whats_new_version -= 1' >tmp.json && mv tmp.json "$HOME/.config/$1/Local State"
}

### reset-wnpr  - [CHROME] reset wn refresh page
function reset-wnpr() {
  if [[ "$1" == "" ]]; then
    echo "need 'chromium' or 'google-chrome'"
    return
  fi
  cat "$HOME/.config/$1/Local State" | jq '.browser.has_shown_refresh_2023_whats_new = false' >tmp.json && mv tmp.json "$HOME/.config/$1/Local State"
}

### reset-iph   - [CHROME] reset iph config
function reset-iph() {
  if [[ "$1" == "" ]]; then
    echo "need 'chromium' or 'google-chrome'"
    return
  fi
  cat "$HOME/.config/$1/Default/Preferences" | jq '.in_product_help = {}' >tmp.json && mv tmp.json "$HOME/.config/$1/Default/Preferences"
}

### reset-exit  - [CHROME] reset exit config
function reset-exit() {
  if [[ "$1" == "" ]]; then
    echo "need 'chromium' or 'google-chrome'"
    return
  fi
  cat "$HOME/.config/$1/Local State" | jq '.exited_cleanly = true' >tmp.json && mv tmp.json "$HOME/.config/$1/Local State"
  cat "$HOME/.config/$1/Default/Preferences" | jq '.profile.exit_type = "none"' >tmp.json && mv tmp.json "$HOME/.config/$1/Default/Preferences"
}

CHROME_DIR="$HOME/chromium/src"
BUILD_STATUS_FILENAME=".ignore/chrome-build-dir"
function get_build_dir_() {
  if [[ ! -f "./$BUILD_STATUS_FILENAME" ]]; then
    echo "Default"
    return
  fi

  cat "./$BUILD_STATUS_FILENAME"
}

### ch-set      - [CHROME] set build status
function ch-set() {
  if [[ "$1" == "" ]]; then
    echo "need build name"
    return
  fi

  mkdir -p "$(dirname $BUILD_STATUS_FILENAME)"
  echo "$1" > "./$BUILD_STATUS_FILENAME"
  ch-status
}

function ch-status_() {
  BUILD_DIR="$(get_build_dir_)"

  local STR=" CHROME STATUS: '$BUILD_DIR' (out/$BUILD_DIR) "
  local HR=$(head -c ${#STR} < /dev/zero | tr '\0' '-')
  local SUBHR=$(echo $HR | tr '-' '.')

  echo "$HR"
  echo "$STR"
  if [[ ! "$1" == "" ]]; then
    echo "$SUBHR"
    echo " $1"
  fi
  echo "$HR"
}

### ch-status   - [CHROME] output build status
function ch-status() {
  BUILD_DIR="$(get_build_dir_)"

  local STR=" CHROME STATUS: '$BUILD_DIR' (out/$BUILD_DIR) "
  local HR=$(head -c ${#STR} < /dev/zero | tr '\0' '-')
  local SUBHR=$(echo $HR | tr '-' '.')

  echo "$HR"
  echo "$STR"
  echo "$SUBHR"
  cat "out/$BUILD_DIR/args.gn"
  echo "$HR"
}

### ch-clean    - [CHROME] clean all other output directories
function ch-clean() {
  ch-status_ "Clean"
  BUILD_DIR="$(get_build_dir_)"

  if [[ ! -d "./out/$BUILD_DIR" ]]; then
    echo "output directory does not exist for $BUILD_DIR"
    return
  fi

  for DIR in out/*; do
    if [[ ! "$DIR" == "out/$BUILD_DIR" ]]; then
      echo "Cleaning $DIR"
      gn clean "$DIR"
    fi
  done
}

### ch-build    - [CHROME] build a target
function ch-build() {
  if [[ "$1" == "" ]]; then
    echo "need build target"
    return
  fi

  ch-status_ "Build $1"
  BUILD_DIR="$(get_build_dir_)"

  autoninja -C "out/$BUILD_DIR" "$1"
}

### ch-run      - [CHROME] run a target
function ch-run() {
  if [[ "$1" == "" ]]; then
    echo "need build target"
    return
  fi

  BUILD_DIR="$(get_build_dir_)"

  # Chrome builds on Mac have different binary names.
  if [[ "$(uname -s)" == "Darwin" && "$1" == "chrome" ]]; then
    # TODO: Make more robust branded detection
    if [[ "$BUILD_DIR" == "branded" ]]; then
      # This is necessary for branded builds on the local OS so it doesn't open an existing browser.
      local USER_DATA_DIR="--user-data-dir=./out/$BUILD_DIR/data"

      ch-status_ "Run $1\n./out/$BUILD_DIR/Google Chrome.app/Contents/MacOS/Google Chrome $USER_DATA_DIR ${@:2}"
      "./out/$BUILD_DIR/Google Chrome.app/Contents/MacOS/Google Chrome" "$USER_DATA_DIR" "${@:2}"
    else
      ch-status_ "Run $1\n./out/$BUILD_DIR/Chromium.app/Contents/MacOS/Chromium ${@:2}"
      "./out/$BUILD_DIR/Chromium.app/Contents/MacOS/Chromium" "${@:2}"
    fi
  else
    # pass the rest of arguments to the binary
    ch-status_ "Run $1\n./out/$BUILD_DIR/$1 ${@:2}"
    "./out/$BUILD_DIR/$1" "${@:2}"
  fi
}

### ch-update   - [CHROME] run update script
function ch-update() {
  ch-status_ "Update"
  BUILD_DIR="$(get_build_dir_)"

  # updates
  if [[ "$@" != *"--skip-rebase"* ]]; then
    git rebase-update -k # skip failed rebases
    gclient sync -fD
  fi

  # build
  ch-build chrome

  # lsp
  tools/clang/scripts/generate_compdb.py -p "out/$BUILD_DIR" > compile_commands.json

  # editor
  git-common
}

### ch-tsd      - [CHROME] create ts configs for a webui and its tests
function ch-ts() {
  if [[ "$1" == "" ]]; then
    echo "need project name"
    return
  fi

  ch_status_ "Build tsconfig.js: $1"
  BUILD_DIR="$(get_build_dir_)"

  if [[ -d "chrome/browser/resources/$1" ]]; then
    python3 ash/webui/personalization_app/tools/gen_tsconfig.py \
      --root_out_dir "out/$BUILD_DIR" \
      --gn_target "chrome/browser/resources/$1:build_ts"
  fi

  if [[ -d "chrome/test/data/webui/$1" ]]; then
    python3 ash/webui/personalization_app/tools/gen_tsconfig.py \
      --root_out_dir "out/$BUILD_DIR" \
      --gn_target "chrome/test/data/webui/$1:build_ts"
  fi

  # TODO: Might want to consider building all the ui/webui/ directories, too.
}

### ch-gn-args  - [CHROME] copy a decent starting args file
function ch-gn-args() {
  ch_status_
  BUILD_DIR="$(get_build_dir_)"
  mkdir -p "$HOME/chromium/src/out/$BUILD_DIR"
  cp "$HOME/.config/dotfiles/args.gn" "$HOME/chromium/src/out/$BUILD_DIR/args.gn"
}

### ch-constants- [CHROME] edit common feature constants
function ch-constants() {
  nvim chrome/browser/ui/browser_element_identifiers.cc \
    chrome/browser/ui/browser_element_identifiers.h \
    components/feature_engagement/public/feature_constants.cc \
    components/feature_engagement/public/feature_constants.h \
    components/feature_engagement/public/feature_list.cc \
    components/feature_engagement/public/feature_list.h
}

### ch-find     - [CHROME] find executable that references a file (good for finding what type of test this file is)
function ch-find() {
  ch_status_
  BUILD_DIR="$(get_build_dir_)"
  # gn refs out/Default //components/autofill/core/browser/payments/payments_requests/get_details_for_enrollment_request_unittest.cc --type=executable --all
  fd | fzf | xargs -I {} gn refs "out/$BUILD_DIR" {} --type=executable --all
}

### ch-test     - [CHROME] fuzzy find a test and add the command to history
function ch-test() {
  local TYPE
  if [[ "$1" == "browser" ]]; then
    TYPE="browser_tests"
  elif [[ "$1" == "unit" ]]; then
    TYPE="unit_tests"
  elif [[ "$1" == "ui" ]]; then
    TYPE="interactive_ui_tests"
  elif [[ "$1" == "component" ]]; then
    TYPE="components_unittests"
  else
    echo "browser, unit, ui, or component?"
    return
  fi

  ch_status_
  BUILD_DIR="$(get_build_dir_)"

  local TEST=$(ch-run $TYPE --gtest_list_tests | ~/.config/nixpkgs/scripts/transform_tests.js | fzf)
  # print to history
  print -s "ch-build $TYPE && ch-run $TYPE --gtest_filter=\"$TEST\"\n"
  echo "$TEST"
}
