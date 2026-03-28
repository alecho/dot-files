# --- Taskwarrior: frictionless add with auto-tagging from mise env ---
# In repos with mise.local.toml setting:
#   SB_TASK_PROJECT="work-auth-refactor"
#   SB_TASK_TAGS="work,mentorship"
# these will be applied automatically.
tadd() {
  [[ $# -eq 0 ]] && { echo "Usage: tadd \"task description\""; return 1; }

  local args=()
  if [[ -n "$SB_TASK_PROJECT" ]]; then
    args+=( "project:$SB_TASK_PROJECT" )
  fi

  if [[ -n "$SB_TASK_TAGS" ]]; then
    # comma-separated list -> +tag +tag
    local tag
    for tag in ${(s:,:)SB_TASK_TAGS}; do
      tag="${tag## }"; tag="${tag%% }"
      [[ -n "$tag" ]] && args+=( "+${tag//-/_}" )
    done
  fi

  task add "${args[@]}" "$@"
}

# Short aliases
alias ta='tadd'
alias t='task'

# taskwarrior-tui
alias tt='taskwarrior-tui'

# Show tasks completed in the last N days (default: 7)
# Usage: tdone [days]
tdone() {
  local days="${1:-7}"
  task status:completed end.after:today-${days}d \
    rc.report.completed.columns=end,project,description \
    rc.report.completed.labels=Completed,Project,Description \
    completed
}
