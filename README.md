# Dotfiles

This is my collection of [configuration files](http://dotfiles.github.io/).

## Installation

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/alecho/dot-files/main/install.sh)"
```

## Create a Project

Stow and trust the global mise task once:

```sh
stow --target="$HOME" mise
mise trust ~/.config/mise/tasks/project-new
```

Then run the task:

```sh
mise run project-new
```

The task creates a workspace at `~/Code/<name>` and puts the primary Git
repository in `main/`. It also creates `.mise.toml` with the detected trunk
branch.

The prompts can create these optional files:

- A `.wiki/` zk notebook with the wiki templates from this repository.
- An `AGENTS.md` file from `dot_file_scripts/templates/AGENTS.md`.
- A `CLAUDE.md` link to `AGENTS.md`.

The task requires `gum` and `git`. The wiki option also requires `zk`. The
task does not replace a non-empty workspace.

Worktrunk uses its global path until the project has a stable remote
identifier. Add a project override later if worktrees must be workspace
siblings.

## Contributor Guide

See the repository guidelines in [AGENTS.md](./AGENTS.md).

## License

[MIT](http://opensource.org/licenses/MIT).
