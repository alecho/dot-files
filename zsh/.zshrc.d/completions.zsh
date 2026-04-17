# Completions Setup

# The actual autocomplete function for zk
function _zk {
  local state context line
  typeset -A opt_args

  _arguments -C\
    '1: :->level1'\
    '*:: :->extra'\
    && return 0

  case $state in
    level1)
      case $line[1] in
        edit)
          _arguments -C\
            '--force[Do not confirm before editing many notes at the same time.]'\
            '--path[Path of the note/notes to edit]: :_directories'\
            '--tag[Tag filter for the notes]: :_tags'\
            '--interactive[Enable interactive mode]'\
            '*:: :->extra'
          return 0
          ;;
      esac
      _describe 'command' commands && return 0
      ;;

    extra)
      case $line[1] in
        edit)
          _arguments -C\
            '--path[Path of the note/notes to edit]: :_directories'\
            '--tag[Tag filter for the notes]: :_tags'\
            '--interactive[Enable interactive mode]'\
            '*:: :->extra'
          return 0
          ;;
      esac
      _describe 'command' commands && return 0
      ;;
  esac
}

# Zellij completion FIX
# Put Homebrew site-functions first in fpath so `_zellij` wins
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
# Deduplicate while keeping first occurrence
typeset -U fpath

# Initialize completion (after OMZ)
autoload -U compinit
compinit -u

# Register completions for custom tools
compdef _zk zk

# Bind Zellij's completion from Homebrew-installed _zellij
compdef -d zellij 2>/dev/null
compdef _zellij zellij
# DO NOT eval "$(zellij setup --generate-completion zsh)" here; it can
# trigger `_arguments` outside a completion context.

# 1Password completion
eval $(op completion zsh)

# second-brain completion
function _second-brain {
  local state context line
  typeset -A opt_args

  local -a top_cmds=(
    'status:Show current project and tags'
    's:Alias for status'
    'project:Get/set project or manage project lifecycle'
    'p:Alias for project'
    'inbox:Capture a note to the inbox'
    'i:Alias for inbox'
    'tags:Get current tags'
    'triage:Walk through inbox items and file them'
    't:Alias for triage'
    'tag:Add, remove, or clear tags'
    'help:Show help'
  )

  _arguments -C \
    '1: :->cmd' \
    '*:: :->args' \
    && return 0

  case $state in
    cmd)
      _describe 'command' top_cmds
      ;;
    args)
      case $line[1] in
        project|p)
          local -a project_cmds=(
            'set:Set SB_TASK_PROJECT in mise.local.toml'
            's:Alias for set'
            'unset:Remove SB_TASK_PROJECT from mise.local.toml'
            'u:Alias for unset'
            'list:List projects (--all includes archived)'
            'l:Alias for list'
            'ls:Alias for list'
            'archive:Move a project to the archive'
            'a:Alias for archive'
            'unarchive:Restore a project from the archive'
            'ua:Alias for unarchive'
          )
          _arguments -C \
            '1: :->subcmd' \
            '*:: :->project_args' \
            && return 0
          case $state in
            subcmd)
              _describe 'project command' project_cmds
              ;;
            project_args)
              local sb_dir="${SB_DIR:-$HOME/Library/Mobile Documents/com~apple~CloudDocs/second-brain}"
              case $line[1] in
                set|s)
                  local -a projects=()
                  if [[ -d "$sb_dir/projects" ]]; then
                    projects=("$sb_dir"/projects/*(/:t))
                  fi
                  _describe 'project' projects
                  ;;
                archive|a)
                  local -a projects=()
                  if [[ -d "$sb_dir/projects" ]]; then
                    projects=("$sb_dir"/projects/*(/:t))
                  fi
                  _describe 'project' projects
                  ;;
                unarchive|ua)
                  local -a archived=()
                  if [[ -d "$sb_dir/archive" ]]; then
                    archived=("$sb_dir"/archive/*(/:t))
                  fi
                  _describe 'archived project' archived
                  ;;
                list|l|ls)
                  _arguments \
                    '--all[Include archived projects]' \
                    '--flat[Plain names only, no tree or markers]'
                  ;;
              esac
              ;;
          esac
          ;;
        tag)
          local -a tag_cmds=(
            'add:Add a tag'
            'a:Alias for add'
            'rm:Remove a tag'
            'r:Alias for rm'
            'clear:Remove all tags'
            'c:Alias for clear'
          )
          _arguments -C \
            '1: :->subcmd' \
            '*:: :->tag_args' \
            && return 0
          case $state in
            subcmd)
              _describe 'tag command' tag_cmds
              ;;
            tag_args)
              case $line[1] in
                rm|r)
                  local current_tags
                  current_tags="$(mise set SB_TASK_TAGS 2>/dev/null)"
                  if [[ -n "$current_tags" ]]; then
                    local -a tags=(${(s:,:)current_tags})
                    _describe 'tag' tags
                  fi
                  ;;
              esac
              ;;
          esac
          ;;
        inbox|i)
          _arguments '--encrypt[Encrypt the note]'
          ;;
      esac
      ;;
  esac
}
compdef _second-brain second-brain

# Bun completions
[ -s "/Users/andrewlechowicz/.bun/_bun" ] && source "/Users/andrewlechowicz/.bun/_bun"

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
