# Pi config sync — work machine trial run

Temporary runbook for testing the `pi` and `agents` stow packages on a second
machine. Delete this file once the setup is confirmed.

Introduced in commit `eb00032`.

## What is being synced

| Path | Synced | Notes |
| --- | --- | --- |
| `~/.pi/agent/settings.json` | yes | theme, default model/provider, thinking level, `packages` list |
| `~/.pi/agent/models.json` | yes | custom providers (local ollama endpoint) |
| `~/.agents/.skill-lock.json` | yes | skill provenance |
| `~/.agents/skills/find-skills/` | yes | vendored; the `skills` CLI has no restore-from-lockfile command |
| `~/.pi/agent/auth.json` | **no** | credentials, stays machine-local |
| `~/.pi/agent/models-store.json` | **no** | cached model catalog |
| `~/.pi/agent/trust.json` | **no** | absolute paths |
| `~/.pi/agent/npm/`, `git/` | **no** | plugin payloads, rebuilt from the `packages` manifest |
| `~/.pi/agent/sessions/` | **no** | chat history |

## Before you start

> **Do not run `install.sh` for this trial.**
> Its stow step passes `--adopt`, which moves this machine's files *into* the
> repo and overwrites the committed versions — the opposite of what you want on
> the receiving end. `--adopt` is only correct on the machine you are capturing
> config *from*. If you run it by accident, recover with:
> `git -C ~/dotfiles checkout -- pi agents`

Requires `stow`, `jq`, and `pi` on PATH.

## Steps

### 1. Pull

```bash
cd ~/dotfiles && git pull
```

### 2. Dry run

Shows what would be linked and any conflicts. Changes nothing.

```bash
stow -n -v --no-folding --target="$HOME" pi agents
```

### 3. Back up what pi already wrote here

```bash
mkdir -p ~/pi-config-backup
mv ~/.pi/agent/settings.json ~/.pi/agent/models.json ~/.agents/.skill-lock.json \
   ~/pi-config-backup/ 2>/dev/null
```

### 4. Compare before committing to the shared version

This is the step that actually matters — it shows what work-specific config the
shared file would replace.

```bash
diff ~/pi-config-backup/settings.json pi/.pi/agent/settings.json
diff ~/pi-config-backup/models.json   pi/.pi/agent/models.json
```

Note anything that genuinely differs per machine (most likely `defaultModel` /
`defaultProvider`, or the ollama block if this machine has no ollama). See
[Divergence](#divergence) below.

### 5. Link

Note: no `--adopt`.

```bash
mkdir -p ~/.pi/agent ~/.agents/skills
stow --no-folding --target="$HOME" pi agents
```

### 6. Rehydrate plugins

The payloads under `~/.pi/agent/npm/` are not tracked; `settings.json` is the
manifest.

```bash
jq -r '(.packages // [])[] | if type=="string" then . else .source end' \
  ~/.pi/agent/settings.json | xargs -n1 pi install
```

### 7. Authenticate

`auth.json` is deliberately not synced, so this machine needs its own
credentials. In pi, run `/login`, or set the provider env var.

## Verification

```bash
# settings.json and models.json point into the repo
ls -la ~/.pi/agent/ | grep -E 'settings|models\.json'

# auth.json is a real local file, NOT a symlink into the repo
ls -la ~/.pi/agent/auth.json

# packages resolve
pi list

# secrets and caches are still ignored
cd ~/dotfiles
for f in pi/.pi/agent/auth.json pi/.pi/agent/models-store.json \
         pi/.pi/agent/sessions/x.jsonl pi/.pi/agent/npm/package.json; do
  printf '%-45s ' "$f"
  git check-ignore -q "$f" && echo IGNORED || echo 'TRACKABLE  <-- STOP'
done

# repo is clean: nothing secret got pulled in
git status --short
```

Then start pi and confirm the theme loads, the model picker works, and
`/skill:find-skills` is available.

## Divergence

Pi has only two settings layers, global and project (`docs/settings.md`). There
is **no machine-local override**, so `defaultModel`, `defaultProvider`, and
`theme` are shared whether or not you want them shared. `lastChangelogVersion`
will also produce a diff on each machine whenever either one updates.

If this machine needs a different model, do not fight `settings.json`. Use the
existing machine-local escape hatch — `zsh/.zshrc.d/local.zsh` is gitignored:

```bash
# ~/.zshrc.d/local.zsh
alias c='pi --model openai/gpt-5'
```

### Secrets in `models.json`

`apiKey` supports `$ENV_VAR`, `${ENV_VAR}`, and `!command` (see
`docs/providers.md`). Since this file is tracked, **never put a literal key in
it** — use `$WORK_LLM_KEY` or `!op read op://vault/item/field`. The existing
`"apiKey": "ollama"` is a required placeholder for the local endpoint, not a
credential.

## Rollback

```bash
cd ~/dotfiles
stow -D --target="$HOME" pi agents

# restore originals (named explicitly: .skill-lock.json is a dotfile
# and would be missed by a * glob)
cp ~/pi-config-backup/settings.json    ~/.pi/agent/   2>/dev/null
cp ~/pi-config-backup/models.json      ~/.pi/agent/   2>/dev/null
cp ~/pi-config-backup/.skill-lock.json ~/.agents/     2>/dev/null
```

## Cleanup

Once confirmed on both machines:

```bash
rm ~/dotfiles/PI-SYNC-WORK-MACHINE.md
rm -rf ~/pi-config-backup
```
