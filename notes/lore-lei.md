# lore.kernel.org mail with lei, plus Sashiko reviews

Set up 2026-11-08. Everything lives under `$LINUXDEV_ROOT/lore` (`~/linuxdev/lore` = `/opt/linuxdev/lore`).

## Install

- Debian: `apt install lei` (lei is its own package, from public-inbox 1.9.0). `public-inbox` itself isn't needed for lei.
  lei is Perl and is not on PyPI.
- b4 is in `~/.local/bin` (pip).
- `lei --version` does not exist in 1.9. Use `lei help`.

## Layout

```
lore/
  lei-store/            lei's store (lei init); config in ~/.config/lei/config
  mine/                 Maildir: every thread I posted in (direct + via B4 Relay)
  topics/<ID>/
    INFO                id, branch, change-id
    maildir/            Maildir: every thread of the b4 series (matched by change-id)
    mbox/vN.mbx         b4 mbox of each sent version's thread
    sashiko/vN.json     Sashiko patchset JSON (includes per-patch inline reviews)
    sashiko/vN.md       readable dump of the same
```

## scripts/20-lore.sh

It defaults to dry-run, like the other scripts. `DRY_RUN=0` executes.

| Command | Does |
|---|---|
| `init` | `lei init lore/lei-store` and `lei add-external https://lore.kernel.org/all/`. Idempotent. |
| `mine` | saved search `f:ricardo@pardini.net OR f:devnull+ricardo.pardini.net@kernel.org` with `-t` (whole threads) |
| `topic <ID>` | reads the b4 tracking JSON from the branch's cover commit. Saves a search `b:<change-id>` with `-t`, then runs `b4 mbox` for each sent version |
| `sashiko <ID>` | `GET https://sashiko.dev/api/patchset?id=<msgid>` for each sent version, saved as JSON and .md |
| `all <ID>` | topic + sashiko |
| `up` | `lei up --all` (incremental. The first `lei q` also saves the search) |

- `topic`/`sashiko` need a b4 prep branch (cover strategy `commit`) that's present locally. Use `11-vm-checkout.sh <ID>` first.
- `topics.tsv` gives the branch.
- b4 puts `change-id: …` at the bottom of every cover letter, so the change-id search also catches versions sent after the search was created.
- Env overrides: `LORE_DIR`, `LORE_URL`, `SASHIKO_URL`, `MY_FROM`.

## lei gotchas

- Pass query terms as **separate arguments**: `lei q f:a OR f:b`. A single argument with spaces becomes a quoted phrase, which matches nothing.
- `-O https://lore.kernel.org/all/` queries only that remote external. Remote results are memoized into the local store.
- `lei q -o DIR` saves the search. Running `lei q` again on the same DIR clobbers it. To refresh, use `lei up DIR` (the script does this automatically).
- To remove a search: `lei forget-search DIR`, then delete DIR.

## Useful queries (lore/public-inbox search prefixes)

| Prefix | Meaning | Example |
|---|---|---|
| `f:` | From | `f:krzk@kernel.org` |
| `t:` `c:` `a:` | To / Cc / any address | `a:linux-rockchip@lists.infradead.org` |
| `s:` | subject | `s:RTL8125` |
| `b:` | body | `b:20260524-rk3588-dts-rtl-eth-describe-dt-alias-c1ed187b7c50` |
| `m:` | message-id | `m:1971659.CQOukoFCf9@phil` |
| `dfn:` | file name touched by a patch | `dfn:rk3588-nanopc-t6.dtsi` |
| `dfhh:` `dfb:` | diff hunk header / diff body | `dfb:pci10ec` |
| `d:` / `rt:` | date / received time | `d:2026-09-01..` |

One-off search to stdout without saving: `lei q --no-save -O https://lore.kernel.org/all/ -f mboxrd -o - 's:foo'`.

## Reading

- Maildirs work with `mutt -f lore/topics/K4/maildir` / neomutt (not installed yet). Or use `python3 -I` with `mailbox.Maildir`.
- mbox files work with `mutt -f …/v5.mbx`, `b4 am …` (to apply), or `mailbox.mbox` in Python.
- To fetch a thread ad hoc: `b4 mbox <msgid>`. To get a series ready to apply: `b4 am <msgid>`.
- Trailers received on a b4 branch: `b4 trailers -u` (it rewrites the branch, so use a backup branch first).

## Sashiko (sashiko.dev, AI patch review that posts as sashiko-bot@kernel.org)

- Web: `https://sashiko.dev/#/patchset/<msgid with @ → %40>`
- API (no auth for reads):
  - `GET /api/patchset?id=<msgid>`: patchset with `patches[]`, `reviews[]` (each has `inline_review`, `summary`, `result`, `patch_id`), `versions[]` (links to other versions), `thread[]`, `model_name`, `baseline`
  - other endpoints: `/api/patchsets`, `/api/review`, `/api/message(s)`, `/api/lists`, `/api/stats`
- Its findings are also mailed to the lists (sashiko-bot), so they show up in the lei Maildirs too.
