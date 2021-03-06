
# RVM added this
source ~/.profile

source ~/.bash/.pgen_autocomplete.sh

# PATH
# Homebrew in general
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
# Hombrew PHP 55
export PATH="$(brew --prefix homebrew/php/php55)/bin:$PATH"
# Composer
export PATH=~/.composer/vendor/bin:$PATH
# Postgres.app
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

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

# grep's Color output
export GREP_OPTIONS='--color=auto'

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
        echo "[$(__git_ps1 '%s')]";
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
            GIT_AHEAD="$green+${BASH_REMATCH[1]}"
            #echo "$green+${BASH_REMATCH[1]}"
        fi
        if [[ "$git_branch_output" =~ .*\ \[.*/.*:.*\ behind\ ([0-9]*).*\].* ]]
        then
            GIT_BEHIND="$red-${BASH_REMATCH[1]}"
            #echo "$red-${BASH_REMATCH[1]}"
        fi
    fi

    local staged=`echo "$git_status_output" | grep -e "^[MARCDT]. .*" | wc -l`
    local changed=`echo "$git_status_output" | grep -e "^.[MD] .*" | wc -l`
    local untracked=`echo "$git_status_output" | grep -e "^?? .*" | wc -l`

		if (true)
		then
			echo "$GIT_AHEAD $GIT_BEHIND"
		fi

}

# Prompt
export PS1='\n\[$dk_blue\]{\h} \[$pink\]\w  \[$yellow\]$(__vcs_name) \[$reset\] $(__git_ahead_behind)\n\[$reset\]\$ '

# Aliases

## General
alias ll='ls -lA'
alias nap='pmset sleepnow'
# OS X's sed causes an issues with bash_completion ssh where
# hosts that beging with "t" aren't completed properly
alias sed='gsed'

## Vagrant
alias v='vagrant'
alias vs='vagrant status'
alias vsus='vagrant suspend'
alias vh='vagrant halt'

# git related commands
alias ghostpr='f() { git fetch upstream && git checkout pr/"$1" && npm install && grunt init && npm start; }; f'

# Hombrew Git Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

#GitHub's hub tool
eval "$(hub alias -s)"

# Node and NPM
alias nombom='npm cache clear && bower cache clean && rm -rf node_modules bower_components && npm install && bower install'

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"
