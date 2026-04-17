# Zellij Helpers
# Tag zellij tabs with emojis based on Linear ticket status.

alias zel='zellij'

# -- Emoji mapping for Linear workflow statuses --
# Product Dev "Started" statuses + common lifecycle states
_linear_status_emoji() {
  case "${1:l}" in
    # Started statuses (Product Dev workflow)
    in\ progress*|ip)       echo "󰣪" ;;
    acc*|at)                echo "󰙨" ;;
    aw*|ar)                 echo "󰈈" ;;
    code*|cr)               echo "" ;;
    # Lifecycle statuses
    tri*|t)                 echo "🔍" ;;
    back*|b)                echo "📋" ;;
    todo*|td)               echo "📝" ;;
    done*|d)                echo "✅" ;;
    cancel*|x)              echo "❌" ;;
    *)                      echo "❓" ;;
  esac
}

# Extract a Linear ticket identifier (e.g. SPHY-1234) from a string.
# Falls back to current git branch when called with no args.
_linear_ticket_id() {
  local input="${1:-$(git rev-parse --abbrev-ref HEAD 2>/dev/null)}"
  echo "$input" | grep -oiE '[a-z]+-[0-9]+' | head -1 | tr '[:lower:]' '[:upper:]'
}

# -- Manual status tagging ---------------------------------------------------

# Set a status emoji on the current zellij tab.
# Usage: zt-status <status>
#   statuses: "in progress" (ip), "acceptance testing" (at),
#             "awaiting review" (ar), "code review" (cr),
#             triage (t), backlog (b), todo (td), done (d), canceled (x)
zt-status() {
  if [[ -z "$ZELLIJ" ]]; then
    echo "Not inside a zellij session" >&2
    return 1
  fi

  local status_type="$*"
  if [[ -z "$status_type" ]]; then
    echo "Usage: zt-status <status>" >&2
    echo "  in progress (ip), acceptance testing (acc/at), awaiting review (aw/ar), code review (code/cr)" >&2
    echo "  triage (tri/t), backlog (back/b), todo (td), done (d), canceled (x)" >&2
    return 1
  fi

  local emoji=$(_linear_status_emoji "$status_type")
  local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  local icon=$'\uef81'
  zellij action rename-tab "${emoji} ${icon} ${branch}"
}

# Clear status emoji from tab, restoring the default worktrunk format.
zt-clear() {
  if [[ -z "$ZELLIJ" ]]; then
    echo "Not inside a zellij session" >&2
    return 1
  fi

  local branch="${1:-$(git rev-parse --abbrev-ref HEAD 2>/dev/null)}"
  local icon=$'\uef81'
  zellij action rename-tab "${icon} ${branch}"
}

# -- Linear API integration (stretch goal) -----------------------------------
# Requires LINEAR_API_KEY env var. Get one at:
#   Linear Settings > API > Personal API keys

# Fetch the workflow state type for a Linear issue.
# Usage: linear-status [TICKET-ID]
#   Defaults to ticket ID extracted from the current git branch.
linear-status() {
  if [[ -z "$LINEAR_API_KEY" ]]; then
    echo "LINEAR_API_KEY not set. Create one at Linear > Settings > API > Personal API keys" >&2
    return 1
  fi

  local ticket_id="${1:-$(_linear_ticket_id)}"
  if [[ -z "$ticket_id" ]]; then
    echo "Could not determine ticket ID. Pass it explicitly or run from a branch with a ticket ID." >&2
    return 1
  fi

  local query='{"query":"{ issue(id: \"'"$ticket_id"'\") { state { name type } } }"}'

  local response
  response=$(curl -s -X POST https://api.linear.app/graphql \
    -H "Content-Type: application/json" \
    -H "Authorization: $LINEAR_API_KEY" \
    -d "$query" 2>/dev/null)

  if [[ $? -ne 0 ]] || echo "$response" | grep -q '"errors"'; then
    echo "Failed to fetch status for $ticket_id" >&2
    echo "$response" | grep -o '"message":"[^"]*"' >&2
    return 1
  fi

  local state_name state_type
  state_type=$(echo "$response" | grep -o '"type":"[^"]*"' | head -1 | sed 's/"type":"//;s/"//')
  state_name=$(echo "$response" | grep -o '"name":"[^"]*"' | head -1 | sed 's/"name":"//;s/"//')

  if [[ -z "$state_type" ]]; then
    echo "No status found for $ticket_id" >&2
    return 1
  fi

  local emoji=$(_linear_status_emoji "$state_name")
  echo "${emoji} ${state_name}"
}

# Fetch status from Linear and update the current zellij tab.
# Usage: zt-sync [TICKET-ID]
zt-sync() {
  if [[ -z "$ZELLIJ" ]]; then
    echo "Not inside a zellij session" >&2
    return 1
  fi

  local ticket_id="${1:-$(_linear_ticket_id)}"
  local result
  result=$(linear-status "$ticket_id") || return 1

  local emoji="${result%% *}"
  local branch="${2:-$(git rev-parse --abbrev-ref HEAD 2>/dev/null)}"
  local icon=$'\uef81'

  zellij action rename-tab "${emoji} ${icon} ${branch}"
  echo "Tab updated: ${result}"
}
