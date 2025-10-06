# chromium

# depot_tools
export PATH="$PATH:$HOME/depot_tools"

# need more FDs for chromium build
if [[ "$(uname -s)" == "Darwin" ]]; then
  ulimit -n 200000
else
  ulimit -u unlimited
fi

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
  # gn refs out/Default //components/autofill/core/browser/payments/payments_requests/get_details_for_enrollment_request_unittest.cc --type=executable --all
  fd | fzf | xargs -I {} gn refs out/Default {} --type=executable --all
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

  local TEST=$(./out/Default/$TYPE --gtest_list_tests | ~/.config/nixpkgs/scripts/transform_tests.js | fzf)
  # print to history
  print -s "autoninja -C out/Default $TYPE && ./out/Default/$TYPE --gtest_filter=\"$TEST\"\n"
  echo "$TEST"
}

### reset-wnp   - [CHROME] reset wn page
function reset-wnp() {
  if [[ "$1" == "" ]]; then
    echo "need 'chromium' or 'google-chrome'"
    return
  fi
  cat "$HOME/.config/$1/Local State" | jq '.browser.last_whats_new_version -= 1' > tmp.json && mv tmp.json "$HOME/.config/$1/Local State"
}

### reset-wnpr  - [CHROME] reset wn refresh page
function reset-wnpr() {
  if [[ "$1" == "" ]]; then
    echo "need 'chromium' or 'google-chrome'"
    return
  fi
  cat "$HOME/.config/$1/Local State" | jq '.browser.has_shown_refresh_2023_whats_new = false' > tmp.json && mv tmp.json "$HOME/.config/$1/Local State"
}

### reset-iph   - [CHROME] reset iph config
function reset-iph() {
  if [[ "$1" == "" ]]; then
    echo "need 'chromium' or 'google-chrome'"
    return
  fi
  cat "$HOME/.config/$1/Default/Preferences" | jq '.in_product_help = {}' > tmp.json && mv tmp.json "$HOME/.config/$1/Default/Preferences"
}

### reset-exit  - [CHROME] reset exit config
function reset-exit() {
  if [[ "$1" == "" ]]; then
    echo "need 'chromium' or 'google-chrome'"
    return
  fi
  cat "$HOME/.config/$1/Local State" | jq '.exited_cleanly = true' > tmp.json && mv tmp.json "$HOME/.config/$1/Local State"
  cat "$HOME/.config/$1/Default/Preferences" | jq '.profile.exit_type = "none"' > tmp.json && mv tmp.json "$HOME/.config/$1/Default/Preferences"
}

### ch-update   - [CHROME] run update script
function ch-update() {
  cd "$HOME/chromium/src"

  # updates
  if [[ "$@" != *"--skip-rebase"* ]]; then
    git rebase-update -k # skip failed rebases
    gclient sync -fD
  fi

  # build
  autoninja -C out/Default chrome

  # lsp
  tools/clang/scripts/generate_compdb.py -p out/Default > compile_commands.json

  # editor
  git-common
}

### ch-tsd      - [CHROME] create ts configs for whats_new
function ch-ts() {
  python3 ash/webui/personalization_app/tools/gen_tsconfig.py \
    --root_out_dir out/Default \
    --gn_target chrome/browser/resources/whats_new:build_ts

  python3 ash/webui/personalization_app/tools/gen_tsconfig.py \
    --root_out_dir out/Default \
    --gn_target chrome/test/data/webui/whats_new:build_ts
}
