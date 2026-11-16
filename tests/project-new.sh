#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
test_root=$(mktemp -d)
trap 'rm -rf "$test_root"' EXIT

export HOME="$test_root/home"
export DOTFILES_DIR="$repo_root"
mkdir -p "$HOME/.config/mise/tasks" "$HOME/Code" "$test_root/bin"
ln -s "$repo_root/mise/.config/mise/tasks/project-new" "$HOME/.config/mise/tasks/project-new"

cat > "$test_root/bin/gum" <<'MOCK'
#!/usr/bin/env bash
set -euo pipefail
response=$(head -n 1 "$GUM_RESPONSES")
tail -n +2 "$GUM_RESPONSES" > "$GUM_RESPONSES.tmp"
mv "$GUM_RESPONSES.tmp" "$GUM_RESPONSES"
case "$1" in
  input|choose) printf '%s\n' "$response" ;;
  confirm) [[ "$response" == yes ]] ;;
  *) exit 2 ;;
esac
MOCK
chmod +x "$test_root/bin/gum"
export PATH="$test_root/bin:$PATH"
export GUM_RESPONSES="$test_root/gum-responses"

mise trust "$HOME/.config/mise/tasks/project-new" >/dev/null
mise -C "$HOME" tasks --global --name-only | grep -Fx project-new >/dev/null
mise -C "$HOME" tasks validate >/dev/null

printf '%s\n' \
  new-project \
  "Initialize a new Git repository" \
  yes \
  yes > "$GUM_RESPONSES"
mise -C "$HOME" run project-new >/dev/null
[[ $(git -C "$HOME/Code/new-project/main" symbolic-ref --short HEAD) == main ]]
grep -Fx 'TRUNK_BRANCH = "main"' "$HOME/Code/new-project/.mise.toml" >/dev/null
[[ -f "$HOME/Code/new-project/.wiki/.zk/config.toml" ]]
[[ -f "$HOME/Code/new-project/AGENTS.md" ]]
[[ $(readlink "$HOME/Code/new-project/CLAUDE.md") == AGENTS.md ]]
! grep -q '{{PROJECT_' "$HOME/Code/new-project/AGENTS.md"

source_repo="$test_root/source"
git init -q -b develop "$source_repo"
printf 'source\n' > "$source_repo/README.md"
git -C "$source_repo" -c user.name=Test -c user.email=test@example.com add README.md
git -C "$source_repo" -c user.name=Test -c user.email=test@example.com commit -qm initial
printf '%s\n' \
  cloned-project \
  "Clone an existing repository URL" \
  "$source_repo" \
  no \
  yes > "$GUM_RESPONSES"
mise -C "$HOME" run project-new >/dev/null
[[ $(git -C "$HOME/Code/cloned-project/main" symbolic-ref --short HEAD) == develop ]]
grep -Fx 'TRUNK_BRANCH = "develop"' "$HOME/Code/cloned-project/.mise.toml" >/dev/null
[[ ! -e "$HOME/Code/cloned-project/.wiki" ]]
[[ -f "$HOME/Code/cloned-project/AGENTS.md" ]]
! grep -q '^## Wiki$' "$HOME/Code/cloned-project/AGENTS.md"

mkdir -p "$HOME/Code/existing"
printf 'keep\n' > "$HOME/Code/existing/marker"
printf '%s\n' existing > "$GUM_RESPONSES"
if mise -C "$HOME" run project-new >/dev/null 2>&1; then
  echo "project-new overwrote a non-empty destination" >&2
  exit 1
fi
grep -Fx keep "$HOME/Code/existing/marker" >/dev/null

printf 'project-new checks passed\n'
