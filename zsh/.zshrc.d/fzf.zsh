# FZF Configuration & Functions

# Source FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FZF path/directory completion using fd
# <C-t> runs $FZF_CTRL_T_COMMAND
# vim ``<tab> runs _fzf_compgen_path()

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# FZF completion for mix commands
_fzf_complete_mix() {
  _fzf_complete --reverse --prompt="mix> " -- "$@" < <(
  command mix help
  )
}

_fzf_complete_mix_post() {
  awk '{print $2}'
}

# Git fixup with fzf
_fzf_complete_git() {
  _fzf_complete --color --preview '(echo {} | awk "{print \$1}" | xargs -I % git show --color=always %)' --preview-window=up:10:wrap --height 40% -- "$@" < <(
    git log --abbrev-commit --oneline
  )
}
_fzf_complete_git_post() {
  awk '{print $1}'
}

# FZF file selection from home directory (Ctrl+x Ctrl+t)
fzf-home-file-widget() {
    local orig="$FZF_CTRL_T_COMMAND"
    FZF_CTRL_T_COMMAND="$FZF_CTRL_T_COMMAND $HOME"
    zle fzf-file-widget
    FZF_CTRL_T_COMMAND="$orig"
}
zle -N fzf-home-file-widget

# Git branch selection widget (Ctrl+b)
select-git-branch-with-fzf() {
    local branch
    branch=$(git branch --all --color=always --sort=-committerdate | fzf --ansi --reverse | sed 's/^[* ]*//' | sed 's|remotes/origin/||' | tr -d '\n')
    if [[ -n $branch ]]; then
        LBUFFER+="$branch"
        zle redisplay
    fi
    zle reset-prompt
}
zle -N select-git-branch-with-fzf

# Git hash selection widget (Ctrl+h)
select-git-hash-with-fzf() {
    local commits selected commit_hash
    commits=$(git lol)
    selected=$(echo "$commits" | fzf +m --height 40% --reverse \
        --preview 'git show --color=always {1}' \
        --preview-window=right:60%)
    if [[ -n $selected ]]; then
        commit_hash=$(echo "$selected" | awk '{print $1}')
        LBUFFER+="$(echo $commit_hash | tr -d '\n')"
        zle redisplay
    fi
    zle reset-prompt
}
zle -N select-git-hash-with-fzf

# Delete merged branches with fzf multi-select
git-clean-branches() {
    git branch --merged origin/main \
        | egrep -v '^\*|^\s*(main|master|develop)' \
        | fzf -m \
        | xargs -n 1 git branch -d
}

# Search a file for a pattern added or removed in its history
gitfzf() {
    local file="$1"
    local pattern="$2"

    if [[ -z "$file" || -z "$pattern" ]]; then
        echo "Usage: gitfzf <file> <pattern>"
        return 1
    fi

    git log -G "$pattern" --color=always -- "$file" |
    fzf --ansi --delimiter="\n" --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git show --color=always"
}

# Browse a file's git history with fzf, copy selected commit hash to clipboard
gitblame() {
    local file="$1"

    if [[ -z "$file" ]]; then
        echo "Usage: gitblame <file>"
        return 1
    fi

    local selected
    selected=$(git log --oneline --follow --color=always -- "$file" |
        fzf --ansi --reverse \
            --preview "echo {} | awk '{print \$1}' | xargs git show --color=always -- $file" \
            --preview-window=right:60%:wrap)

    if [[ -n "$selected" ]]; then
        local hash
        hash=$(echo "$selected" | awk '{print $1}')
        echo "$hash" | pbcopy
        echo "Copied $hash to clipboard"
    fi
}
