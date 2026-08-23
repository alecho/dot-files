# Dotfiles TODO

**Summary**: Tracked follow-up work for this repo.

**Last updated**: 2026-08-23

---

## Remove GnuPG and the GPG Suite

**Status**: blocked on migrating the M4 to SSH signing.

Commit signing moved from GPG to SSH in `da5340c`, so GnuPG is no longer
needed for git on this machine. Once the work M4 is migrated too, the whole
GnuPG stack can come off.

### Why

- `gpg.program` was hardcoded to `/opt/homebrew/bin/gpg`, an Apple Silicon
  path that does not exist on Intel Homebrew (`/usr/local`). That forced a
  `~/.gitconfig.local` override on the Intel machine.
- gpg-agent shells out to `pinentry`, which cannot prompt from a
  non-interactive shell. Signing timed out and blocked agent-driven commits.
- SSH signing has no such path dependency and needs no agent or pinentry.

### Steps

1. Migrate the M4 to SSH signing:
   - `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_signing -C "andrew@alecho.com git signing (m4)"`
   - Append that public key to `git/.config/git/allowed_signers`.
   - Set `user.signingkey` in the M4's `~/.gitconfig.local`.
   - Delete the `[gpg] program = gpg` block from the M4's `~/.gitconfig.local`.
   - Upload the key to GitHub with type **signing** (an auth key will not
     verify commits): `gh ssh-key add ~/.ssh/id_ed25519_signing.pub --type signing`
2. Confirm nothing else depends on GnuPG before uninstalling. Check for
   encrypted files, `pass`, Yubikey/smartcard workflows, and any signed
   tags or release tooling that shells out to `gpg`.
3. Drop the Brewfile entries in `homebrew/.Brewfile`: `pinentry` (line 71)
   and `gnupg` (line 73).
4. Uninstall on each machine:
   ```
   brew uninstall --cask gpg-suite
   brew uninstall gnupg pinentry
   brew autoremove   # clears libassuan, libgcrypt, libgpg-error, libksba, npth
   ```
5. Remove leftover state: `~/.gnupg/` (holds `gpg-agent.conf` with the
   cache-ttl settings). Back up any private keys first if they are worth
   keeping.

### Notes

- The current signing key `~/.ssh/id_ed25519_signing` has **no passphrase**,
  so agent-driven commits work without a prompt. It signs only and is never
  used for authentication, so exposure means forged signatures, not server
  access. Add a passphrase with `ssh-keygen -p -f ~/.ssh/id_ed25519_signing`
  if that tradeoff stops being worth it.
- Do not sign with `~/.ssh/id_ed25519_sk`. It is hardware-backed and needs a
  physical touch per signature, which breaks non-interactive commits.
