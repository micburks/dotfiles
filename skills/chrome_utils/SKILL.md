---
name: chrome_utils
description: Useful Chromium build, status, test, formatting, and workspace helper utilities (ch-status, ch-set, ch-build, ch-run, ch-format, etc.).
---

# Chrome & System Utilities Cheatsheet

These utilities are located in `~/.config/zsh/utils` (or `$SHELL_UTILS`). Ensure `~/.config/zsh/utils` and `~/.local/bin` are included in `PATH` when executing terminal commands via `run_command`.

## Environment Setup
Before running utilities, include the directory in `PATH`:
```bash
export PATH="$HOME/.config/zsh/utils:$HOME/.local/bin:$PATH"
```

## Chromium Utilities (`ch-*`)

| Command | Description | Example Usage |
| :--- | :--- | :--- |
| `ch-status` | Displays the current Chrome gn output directory and `args.gn` | `ch-status` |
| `ch-set <name>` | Sets the active Chrome build directory (in `out/<name>`) | `ch-set Default` |
| `ch-build <target>` | Builds a Chromium target using `autoninja` | `ch-build chrome` |
| `ch-run <target> [args]`| Runs a built Chromium target with `--user-data-dir` | `ch-run chrome` |
| `ch-format` | Formats C++ and WebUI files using `git cl format` | `ch-format` |
| `ch-ts <project>` | Generates TypeScript configs for WebUI project and tests | `ch-ts personalization_app` |
| `ch-ts-ui` | Generates TypeScript configs for shared `ui/webui` code | `ch-ts-ui` |
| `ch-ts-comp <comp>`| Generates TypeScript config for a `cr_components` component | `ch-ts-comp history_clusters` |


## When to use these utilities

* When you need to change build args.gn, set it with `ch-set` and check current status with `ch-status`.
* When building and running a specific target, use `ch-build` and `ch-run`.
* Before making a commit, run `ch-format` to align formatting with presubmit checks.
* When checking the typescript validity, run `ch-ts[-*]` to generate a tsconfig to be used.
