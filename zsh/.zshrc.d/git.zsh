# Git Functions & Aliases

# Git status shorthand
alias gits='git status -sb'

# Fuzzy-find git log --oneline
function gii() {
  git lol | fzf --reverse --no-sort | awk '{print $1}' | xargs git "$1"
}

function gsh() {
  git lol | fzf --reverse --no-sort | awk '{print $1}' | xargs git
}

# Create a new git worktree with branch naming pattern sphy-XXXX--descriptor
workspace() {
    local subcommand="$1"

    # Default to 'create' if no subcommand provided
    if [[ -z "$subcommand" || "$subcommand" != "create" ]]; then
        subcommand="create"
        # If first arg isn't 'create', treat it as the descriptor
        if [[ -n "$1" ]]; then
            set -- "create" "$@"
        fi
    fi

    case "$subcommand" in
        create)
            local descriptor="$2"

            if [[ -z "$descriptor" ]]; then
                echo "Usage: workspace [create] <descriptor>" >&2
                return 1
            fi

            # Extract the branch number from the current branch
            local current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
            if [[ $? -ne 0 ]]; then
                echo "Error: not in a git repository" >&2
                return 1
            fi

            local branch_match=$(echo "$current_branch" | grep -oE 'sphy-[0-9]+')

            if [[ -z "$branch_match" ]]; then
                echo "Current branch does not match sphy-XXXX pattern" >&2
                return 1
            fi

            # Create new branch name
            local new_branch="${branch_match}--${descriptor}"
            local worktree_path="../${new_branch}"

            # Create worktree
            git worktree add "$worktree_path" -b "${new_branch}" || return 1

            # Change to the new worktree directory
            cd "$worktree_path"

            # If zellij is available, rename the current tab
            if command -v zellij &> /dev/null; then
                # Titleize the descriptor (capitalize first letter of each word)
                local titleized_descriptor=$(echo "$descriptor" | awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1')
                zellij action rename-tab "Worktree - ${titleized_descriptor}"
            fi
            ;;
        *)
            echo "Unknown subcommand: $subcommand" >&2
            echo "Usage: workspace [create] <descriptor>" >&2
            return 1
            ;;
    esac
}
