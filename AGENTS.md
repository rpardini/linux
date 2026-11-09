# AGENTS.md: linuxdev workspace (kernel / u-boot upstreaming)

Instructions for AI agents working under `~/linuxdev` (= `/opt/linuxdev`). This file lives in the
`linuxdev-status` repo (branch `status`, pushed as `linuxdev-work/status` on `rpardini/linux`), and
`/opt/linuxdev/CLAUDE.md` imports it.

## Layout

| Path | What |
|---|---|
| `kernel/`, `u-boot/` | main trees (blobless clones). Remotes are listed in `linuxdev-status/remotes.tsv` |
| `kernel-<slug>/`, `u-boot-<slug>/` | per-topic git worktrees of the main trees (eg. `kernel-rk3588-rtl-eth`, `kernel-cec`) |
| `linuxdev-status/` | this repo: `STATUS.md` (human tracker), `topics.tsv` (machine data per topic), `remotes.tsv`, `notes/`, `scripts/` |
| `lore/` | lei store and saved searches, per-topic mail and Sashiko reviews (see `notes/lore-lei.md`) |
| `armbian-build/` | Armbian build framework. Patch paths in STATUS are relative to `armbian-build/patch/` |

- Topic IDs: K = kernel mainline, KA = kernel Armbian trees, RK = Rockchip vendor 6.1, U/UA = u-boot.
- Keep `STATUS.md` and `topics.tsv` IDs in sync.
- Per-topic notes go in `notes/kernel/` and `notes/u-boot/`, linked from the STATUS row's Notes column.

## topics.tsv

Columns: `id repo branch source mode base picks remote b4 slug`.

- `branch` is the local name. On the forks it's `linuxdev-work/<branch>`.
- `b4=y` restores the b4 branch config on checkout.
- `slug` names the worktree dir (`<repo>-<slug>`). Use `-` for an empty field.
- Rows commented out as `#<id>` are picks that need a manual port.

## Scripts (`linuxdev-status/scripts/`)

All of them default to **dry-run** (they print commands). `DRY_RUN=0` executes. `ONLY='^(K4|U1)$'` restricts to topics.

- `01-make-branches.sh`, `02-push.sh`, `03-verify.sh`: create, push (no force) and verify topic branches against the forks.
- `10-vm-clone-main.sh <repo>`: create a main tree.
- `11-vm-checkout.sh <ID> [--worktree [path]]`: check out a topic. The worktree defaults to `<repo>-<slug|id>`.
- `20-lore.sh init|mine|topic <ID>|sashiko <ID>|all <ID>|up`: lore mail through lei, plus Sashiko reviews.

Prefer extending these scripts (they share `lib.sh`: `run`, `each_topic`, `topic_row`, ...) over one-off commands.

## b4 workflow

- Series are b4 prep branches `b4/<name>` with cover strategy `commit`. The cover commit holds the b4 tracking JSON: change-id, and message-ids of sent versions in `history`.
- Sent versions are tagged `sent/<change-id>-vN`.
- Before preparing a new revision, collect feedback:
  1. `scripts/20-lore.sh all <ID>`
  2. read `lore/topics/<ID>/mbox/*.mbx` and `sashiko/*.md`
  3. summarize per version: reviewer, what they asked for, whether it's addressed, tags received
- Before sending, run `b4 prep --check`, `make dt_binding_check` / `CHECK_DTBS=y` for DT work, `b4 send --dry-run`.
- **Never** run `b4 send`, `git push` or `02-push.sh` (with DRY_RUN=0), and never post to lists, without the user's explicit OK.
- Before rewriting a branch that matters (rebase, drop, `b4 trailers -u`), make a backup branch.

## Kernel / u-boot rules

- AI agents must not add `Signed-off-by` (Documentation/process/coding-assistants.rst). The user adds their own SoB (`git commit --amend -s`) before sending.
- Don't add `Assisted-by:` either. User, 2026-11-08: the kernel doesn't take it anymore.
- Signing (set up 2026-11-08):
  - The user's GPG key `AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9` is git `user.signingkey`. patatt falls back to it as `openpgp:`, and b4 sends through B4 Relay by default in kernel trees.
  - **What needs a signature is the mail, not the commits.** `b4 send` signs each message with patatt (`X-Developer-Signature`, openpgp-sha256), and b4 signs its `sent/` tags.
  - b4's own rewrites drop commit signatures by design (cover edits, `--auto-to-cc`, `trailers -u`, the post-send revision bump: pygit2 in `b4/_rewrite.py`). That's fine.
  - So **don't spend effort on commit signatures**: no re-signing rebases, no `%G?` checks, no hooks (user, 2026-11-09).
  - `commit.gpgsign` and `tag.gpgsign` are still on, so `git commit` and `git rebase` need an unlocked gpg-agent, and so does `b4 send`. The agent caches the passphrase for 8h; the user unlocks it in their own terminal with `echo test | gpg --clearsign >/dev/null`.
  - Agent shells have no TTY. Check first with `echo t | gpg --batch --pinentry-mode error --clearsign >/dev/null`; if it fails, ask the user to unlock.
- Commit messages and cover letters are written in the user's voice. Show the wording to the user before anything is sent.
- Build in an out-of-tree dir inside the worktree (eg. `O=.build`). The host is arm64, so no cross compile is needed for arm64.

## Working with the user

- Ask questions before deciding things. The user prefers questions to rework.
- Ask before installing host packages (apt). Never work around missing deps with config hacks.
- Status words used in STATUS.md: `merged`, `sent vN`, `prepared`, `wip`, `needs port`, `armbian-only`, `debug`, `parked`, `landed`, `drop`.
