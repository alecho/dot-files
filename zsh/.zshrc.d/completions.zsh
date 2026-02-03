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

# Bun completions
[ -s "/Users/andrewlechowicz/.bun/_bun" ] && source "/Users/andrewlechowicz/.bun/_bun"
