# {{PROJECT_NAME}}

This directory is the worktree root for the {{PROJECT_NAME}} project. The
primary clone lives at `main/`. Each sibling subdirectory (except `.wiki/`)
is a git worktree.

## Wiki

This project maintains a wiki — a structured, interlinked knowledge base of
operational knowledge shared across all worktrees. Claude maintains the wiki.
The human curates, corrects, and guides what gets captured.

**Wiki location**: `{{PROJECT_DIR}}/.wiki/`

The wiki lives at the workspace root (alongside this `AGENTS.md`), NOT inside
any worktree. From inside a worktree, reference it by absolute path or via
`../.wiki/` (worktrees are direct children of the workspace root). The entry
point is `{{PROJECT_DIR}}/.wiki/index.md`.

### Folder structure

```
{{PROJECT_NAME}}/
  AGENTS.md
  CLAUDE.md  -> AGENTS.md
  .wiki/
    index.md   -- table of contents for the entire wiki
    *.md       -- individual topic pages
  main/        -- primary clone
  <branch>/    -- worktrees (siblings of main/)
```

### Consulting the wiki

**Always consult the wiki before doing work.** This includes:
- Planning or implementing changes
- Reviewing code or PRs
- Debugging issues
- Running tests
- Working with environment, build, or deployment configuration

**Use the `wiki-search` subagent** (Agent tool, `subagent_type: wiki-search`) as
the default way to consult the wiki. It reads the index, picks the relevant
pages, and returns a focused summary with source citations — keeping page
bodies out of the main context. Fall back to reading pages directly only when
you need to edit the wiki, lint it, or quote exact text.

If the subagent reports the answer isn't in the wiki, say so clearly to the
user, and if you discover the answer through other means, offer to save it as
a wiki update.

### Maintaining the wiki

When you learn something operationally useful that isn't already captured — a new
env var, a startup quirk, a debugging trick, a worktree-specific behavior — add
or update the appropriate `.wiki/` page.

After every wiki change:
1. Update `.wiki/index.md` with any new pages and one-line descriptions
2. Use descriptive git commit messages (wiki history is tracked via git)

Do NOT store things derivable from code, git history, or existing CLAUDE.md
files in worktrees. The wiki is for cross-worktree operational knowledge that
would otherwise be lost between sessions.

### Page format

Every wiki page should follow this structure:

```markdown
# Page Title

**Summary**: One to two sentences describing this page.

**Sources**: Project files or configs this page draws from.

**Last updated**: YYYY-MM-DD

---

Main content here. Use clear headings and short paragraphs.

Link to related topics using [[wiki-links]] throughout.

## Related pages

- [[related-topic]]
```

### Citation rules

- Reference where knowledge was found using (source: path/to/file) after claims
- If information varies per worktree, note that explicitly
- If a claim has no source, mark it as (unverified)

### Lint

When asked to lint or audit the wiki:

- Check for contradictions between pages
- Find orphan pages (no inbound links from other pages)
- Identify concepts mentioned but lacking their own page
- Flag claims that may be outdated
- Check that all pages follow the page format above
- Report findings as a numbered list with suggested fixes

### Browsing the wiki

The `.wiki/` directory is an `nb` local notebook. To browse as rendered HTML:

    nb browse --gui

### Rules

- Always update `index.md` after changes
- Keep page names lowercase with hyphens (e.g., `environment-variables.md`)
- Write in clear, plain language
- When uncertain about how to categorize something, ask the user
