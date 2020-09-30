# vim:ft=zsh ts=2 sw=2 sts=2

rvm_current() {
  rvm current 2>/dev/null
}

rbenv_version() {
  rbenv version 2>/dev/null | awk '{print $1}'
}

function prompt_time() {
  local the_time="%{$fg[white]%}%T"

  echo "${the_time}"
}

if [ -e ~/.rvm/bin/rvm-prompt ]; then
  RPROMPT='%{$fg_bold[red]%}‹$(rvm_current)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    RPROMPT='%{$fg_bold[red]%}$(rbenv_version)%{$reset_color%}'
  fi
fi

git_commits_ahead() {
  if $(echo $(command git status -sb 2> /dev/null) | grep 'ahead' &> /dev/null); then
    local COMMITS
    COMMITS=$(command git status -sb 2 > /dev/null | sed -e 's/^.*ahead \([0-9]*\).*/\1/' | head -1)
    echo "$ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX$COMMITS$ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX"
  fi
}

git_commits_behind() {
  if $(echo $(command git status -sb 2> /dev/null) | grep 'behind' &> /dev/null); then
    local COMMITS
    COMMITS=$(command git status -sb 2> /dev/null | sed -e 's/^.*behind \([0-9]*\).*/\1/' | head -1)
    echo "$ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX$COMMITS$ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX"
  fi
}

git_remote_exists() {
  if $(echo $(command git status -sb 2> /dev/null) | grep '...' &> /dev/null); then
    local COMMITS
    COMMITS=$(command git status -sb 2> /dev/null | sed -e 's/^.*behind \([0-9]*\).*/\1/' | head -1)
    echo "$ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX$COMMITS$ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX"
  fi
}

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" \uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}A%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}D%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[blue]%}U%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}M%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}?%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]%}R%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[yellow]%}\u223C\u223D%{$reset_color%} "
ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX=" %{$fg[red]%}-"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="$(git_commits_behind)"
ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX=" %{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="$(git_commits_ahead)"
ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$(git_commits_ahead) $(git_commits_behind)"
ZSH_THEME_GIT_PROMPT_REMOTE_EXISTS="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_REMOTE_MISSING="%{$fg[red]%}"

PROMPT='
$(prompt_time) %{$fg_bold[blue]%}${PWD/#$HOME/~}%{$reset_color%} $(git_prompt_remote)$(git_prompt_info)$(git_prompt_remote)$(git_commits_ahead)$(git_commits_behind) $(git_prompt_status)%{$reset_color%}
%{$fg[magenta]%}|>%{$reset_color%}'

RPROMPT='%{$(echotc UP 1)%}%{$(echotc DO 1)%}'

