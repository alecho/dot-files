# Utility Functions

# Interactive cd with fzf
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

# Raycast confetti on success
function confetti {
  STATUS=$?
  if [ $STATUS -eq 0 ]; then
    open raycast://confetti
  fi
}

# Initialize a worktree-root project in ~/Code/<name>: AGENTS.md + CLAUDE.md
# symlink + .wiki/ seeded with default stubs. Templates live at
# ~/dotfiles/dot_file_scripts/templates/. The primary clone is expected at
# ~/Code/<name>/main/ (created separately via `git clone-in-project` or `git init`).
# Idempotent: missing files are created, identical files are skipped, divergent
# files trigger an interactive diff/keep/overwrite prompt via gum + delta.
function code-init() {
  if [[ -z "$1" ]]; then
    echo "Usage: code-init <project-name>" >&2
    return 1
  fi

  local name="$1"
  local dir="$HOME/Code/$name"
  local templates="$HOME/dotfiles/dot_file_scripts/templates"
  local agents_template="$templates/AGENTS.md"
  local wiki_templates="$templates/wiki"
  local today=$(date +%Y-%m-%d)

  if [[ ! -f "$agents_template" ]]; then
    echo "code-init: template not found at $agents_template" >&2
    return 1
  fi
  if [[ ! -d "$wiki_templates" ]]; then
    echo "code-init: wiki templates not found at $wiki_templates" >&2
    return 1
  fi
  if ! command -v gum >/dev/null 2>&1; then
    echo "code-init: gum is required for interactive prompts" >&2
    return 1
  fi

  mkdir -p "$dir/.wiki" || return 1

  local created=0 overwritten=0 kept=0

  _code_init_render() {
    sed -e "s|{{PROJECT_NAME}}|$name|g" \
        -e "s|{{PROJECT_DIR}}|$dir|g" \
        -e "s|{{DATE}}|$today|g" \
        "$1"
  }

  _code_init_install() {
    local template="$1" target="$2" label="$3"

    if [[ ! -e "$target" && ! -L "$target" ]]; then
      _code_init_render "$template" > "$target" || return 1
      echo "  + $label"
      ((created++))
      return 0
    fi

    local tmp
    tmp=$(mktemp) || return 1
    _code_init_render "$template" > "$tmp"

    if cmp -s "$tmp" "$target"; then
      rm -f "$tmp"
      return 0
    fi

    local choice
    while true; do
      choice=$(gum choose --header "$label differs from template" "diff" "keep" "overwrite")
      case "$choice" in
        diff)
          if command -v delta >/dev/null 2>&1; then
            delta "$target" "$tmp"
          else
            diff -u "$target" "$tmp"
          fi
          ;;
        overwrite)
          mv "$tmp" "$target" || return 1
          echo "  ~ $label (overwritten)"
          ((overwritten++))
          return 0
          ;;
        keep|"")
          rm -f "$tmp"
          echo "  = $label (kept)"
          ((kept++))
          return 0
          ;;
      esac
    done
  }

  _code_init_install "$agents_template" "$dir/AGENTS.md" "AGENTS.md" || \
    { unfunction _code_init_render _code_init_install; return 1; }

  if [[ ! -e "$dir/CLAUDE.md" && ! -L "$dir/CLAUDE.md" ]]; then
    ln -s AGENTS.md "$dir/CLAUDE.md" || \
      { unfunction _code_init_render _code_init_install; return 1; }
    echo "  + CLAUDE.md -> AGENTS.md"
    ((created++))
  fi

  for src in "$wiki_templates"/*.md; do
    _code_init_install "$src" "$dir/.wiki/$(basename "$src")" ".wiki/$(basename "$src")" || \
      { unfunction _code_init_render _code_init_install; return 1; }
  done

  unfunction _code_init_render _code_init_install

  if (( created + overwritten + kept == 0 )); then
    echo "$dir already initialized"
  else
    echo "Initialized $dir (created: $created, overwritten: $overwritten, kept: $kept)"
  fi
  builtin cd "$dir"
}
