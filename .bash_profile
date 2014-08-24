# PATH
# Homebrew in general
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
# Hombrew PHP 55
export PATH="$(brew --prefix homebrew/php/php55)/bin:$PATH"
# Composer
export PATH=~/.composer/vendor/bin:$PATH


# Color!
export CLICOLOR=1
black=$(tput -Txterm setaf 0)
red=$(tput -Txterm setaf 1)
green=$(tput -Txterm setaf 2)
yellow=$(tput -Txterm setaf 3)
dk_blue=$(tput -Txterm setaf 4)
pink=$(tput -Txterm setaf 5)
lt_blue=$(tput -Txterm setaf 6)

bold=$(tput -Txterm bold)
reset=$(tput -Txterm sgr0)

#VCS Functions
__has_parent_dir () {
    # Utility function so we can test for things like .git/.hg without firing up a
    # separate process
    test -d "$1" && return 0;

    current="."
    while [ ! "$current" -ef "$current/.." ]; do
        if [ -d "$current/$1" ]; then
            return 0;
        fi
        current="$current/..";
    done

    return 1;
}

__vcs_name() {
    if [ -d .svn ]; then
        echo "-[svn]";
    elif __has_parent_dir ".git"; then
        echo "-[$(__git_ps1 'git %s')]";
    elif __has_parent_dir ".hg"; then
        echo "-[hg $(hg branch)]"
    fi
}

__git_ahead_behind() {
    GIT_BRANCH=""
    GIT_AHEAD=""
    GIT_BEHIND=""
    GIT_START=""
    GIT_END=""

    git_status_output=$(git status -s 2> /dev/null) || return 1
    git_branch_output=$(git branch -vv 2> /dev/null | grep -e '^\*') || return 1

    GIT_START="｢"
    GIT_END="｣"

    local tracking=""
    GIT_AHEAD=""
    GIT_BEHIND=""
    if [[ "$git_branch_output" =~ .*\[(.*/[^:]*)[]:].* ]]
    then
        tracking="${BASH_REMATCH[1]}"
        if [[ "$git_branch_output" =~ .*\ \[.*/.*:.*\ ahead\ ([0-9]*).*\].* ]]
        then
            #GIT_AHEAD="+${BASH_REMATCH[1]}"
            echo "$green+${BASH_REMATCH[1]}"
        fi
        if [[ "$git_branch_output" =~ .*\ \[.*/.*:.*\ behind\ ([0-9]*).*\].* ]]
        then
            #GIT_BEHIND="-${BASH_REMATCH[1]}"
            echo "$red-${BASH_REMATCH[1]}"
        fi
    fi

    local staged=`echo "$git_status_output" | grep -e "^[MARCDT]. .*" | wc -l`
    local changed=`echo "$git_status_output" | grep -e "^.[MD] .*" | wc -l`
    local untracked=`echo "$git_status_output" | grep -e "^?? .*" | wc -l`

}

# Prompt
export PS1='\n\[$pink\]\w  \[$yellow\]$(__vcs_name) \[$reset\] $(__git_ahead_behind)\n\[$reset\]\$ '

# Aliases

## General
alias ll='ls -lA'

## Vagrant
alias v='vagrant'
alias vs='vagrant status'

# Hombrew Git Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi


