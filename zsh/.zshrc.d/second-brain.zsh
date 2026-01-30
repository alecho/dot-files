# Second Brain location (iCloud Drive)
export SB_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/second-brain"

# Convenience
alias sb='cd "$SB_DIR"'

# --- Helpers ---
_sb_slugify() {
  # naive slugify: lowercase, spaces->dashes, strip some punctuation
  local s="${1:l}"
  s="${s// /-}"
  s="${s//\//-}"
  s="${s//:/}"
  s="${s//\?/}"
  s="${s//\!/}"
  echo "$s"
}

_sb_today() { date +%F; }

# Find most recent daily note BEFORE today (or if today missing, still returns latest prior)
# Prints path relative to SB_DIR
_sb_yesterday_path() {
  cd "$SB_DIR" || return 1
  local today="$(_sb_today)"
  # list daily notes, filter those < today, pick last
  local p
  p=$(ls -1 areas/daily/*.md 2>/dev/null | sed 's|.*/||' | sed 's|\.md$||' | awk -v t="$today" '$1 < t {print}' | sort | tail -n 1)
  [[ -n "$p" ]] && echo "areas/daily/$p.md"
}

# --- Inbox capture ---
# Usage: inbox "some thought"  (writes a markdown file into inbox/)
inbox() {
  cd "$SB_DIR" || return 1
  local title="${*:-inbox}"
  local slug="$(_sb_slugify "$title")"
  local f="inbox/$(_sb_today)-$slug.md"

  # Use inbox template if it exists; otherwise simple body
  if [[ -f "resources/templates/inbox.md" ]]; then
    local tpl
    tpl="$(cat resources/templates/inbox.md)"
    tpl="${tpl//'{{title}}'/$title}"
    tpl="${tpl//'{{date}}'/$(_sb_today)}"
    printf "%s\n" "$tpl" | nb add "$f" >/dev/null
  else
    printf "%s\n" "$title" | nb add "$f" >/dev/null
  fi

  echo "$f"
}

# Alias requested: sbin -> inbox
alias sbin='inbox'

# Encrypted capture (option A)
# Usage: inboxx "secret title"
inboxx() {
  cd "$SB_DIR" || return 1
  nb add --title "${*:-Secret}" --encrypt
}
alias sbinx='inboxx'

# --- Daily note creation ---
# Create/open today's daily note from template, injecting today's Taskwarrior tasks
daily() {
  cd "$SB_DIR" || return 1
  local f="areas/daily/$(_sb_today).md"

  # If already exists, open it
  if [[ -f "$f" ]]; then
    nb edit "$f"
    return 0
  fi

  # Build task list from Taskwarrior
  # Columns: id, project, description
  local tasks
  tasks="$(task status:pending rc.verbose=nothing rc.report.minimal.columns=id,project,description rc.report.minimal.labels= minimal 2>/dev/null | sed 's/^/- [ ] /')"
  [[ -z "$tasks" ]] && tasks="- [ ] (no pending tasks pulled from Taskwarrior)"

  # Render template
  local tpl
  tpl="$(cat resources/templates/daily-standup.md)"
  tpl="${tpl//'{{date}}'/$(_sb_today)}"
  tpl="${tpl//'{{tasks}}'/$tasks}"

  printf "%s\n" "$tpl" | nb add "$f" >/dev/null
  nb edit "$f"
}

# Alias requested: sbd -> daily
alias sbd='daily'

# --- Yesterday shortcut (open most proximal prior daily) ---
yesterday() {
  cd "$SB_DIR" || return 1
  local p="$(_sb_yesterday_path)"
  if [[ -n "$p" ]]; then
    nb edit "$p"
  else
    echo "No prior daily note found under areas/daily/"
    return 1
  fi
}
alias y='yesterday'

# --- Taskwarrior: frictionless add with auto-tagging from mise env ---
# In repos with .mise.toml setting:
#   SB_TASK_PROJECT="work-auth-refactor"
#   SB_TASK_TAGS="work,mentorship"
# these will be applied automatically.
tadd() {
  local desc="$*"
  [[ -z "$desc" ]] && { echo "Usage: tadd \"task description\""; return 1; }

  local args=()
  if [[ -n "$SB_TASK_PROJECT" ]]; then
    args+=( "project:$SB_TASK_PROJECT" )
  fi

  if [[ -n "$SB_TASK_TAGS" ]]; then
    # comma-separated list -> +tag +tag
    local IFS=,
    local tag
    for tag in $SB_TASK_TAGS; do
      tag="${tag## }"; tag="${tag%% }"
      [[ -n "$tag" ]] && args+=( "+$tag" )
    done
  fi

  task add "${args[@]}" "$desc"
}

# Short aliases
alias ta='tadd'
alias t='task'

# taskwarrior-tui
alias tt='taskwarrior-tui'
