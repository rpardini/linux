# tmux session per VM + iTerm2 tmux integration

Claude and long runs share one tmux session per VM. iTerm2's tmux integration (`tmux -CC`) shows each tmux
window as a native iTerm2 tab: one tab for Claude, one per build.

## Setup

- iTerm2 profiles "<host> lima <vm> tmux" (made by xml-gen-iterm2) SSH in, attach `tmux -CC` to the most
  recently attached session, and open a new tab with a shell. With no session they create one named after the VM
  (eg. `armbian-trixie-linuxdev`).
  - By hand: `ssh -t <vm> tmux -CC new -A -s <session>`.
  - The tab you run it in becomes the "gateway": Esc detaches, X force-quits. iTerm2 can hide it.
  - Detaching (closing the window, Mac sleep, SSH drop) leaves everything running. Reattach with the same command.
- Claude runs in a window of the session: press Cmd-T in the tmux window, then
  `cd /opt/linuxdev && claude --continue` (or `--resume` to pick a conversation).
- Same Unix user everywhere (`rpardini`, uid 501), so Claude's shell and your SSH share the default tmux socket.
- iTerm2 → Settings → Advanced → tmux: "Where should new tmux windows not created by iTerm2 open?": **New window**
  (defaults key `AnonymousTmuxWindowsOpenInCurrentWindow`, int: 0 new window, 1 focused window (default), 2 topmost
  session window). This is what puts each build (`tmux new-window -d` from the VM) in its own native window.
- iTerm2 → Settings → General → tmux:
  - "When attaching, restore windows as": **Native windows** (`OpenTmuxWindowsIn` = 0). Applies only at attach.
  - "Automatically bury the tmux client session after connecting": on, to hide the gateway tab.
  - Pausing slow panes: keep the default. A pause stops only the display; the build and its log keep going.
    Press a key in the pane to catch up.
- Shell → tmux → Dashboard lists the windows and lets you show or hide them.

## Runs (`scripts/40-tmux-run.sh`)

- `DRY_RUN=0 scripts/40-tmux-run.sh <name> [-C <dir>] -- <cmd...>` opens a background (`-d`) window named `<name>`.
- Session: `$TMUX_SESSION`, else the current one (run from inside tmux), else the most recently attached,
  else a new one named after the VM (`hostname -s` minus `lima-`), the same name the iTerm2 profiles use.
- `DRY_RUN` and `ONLY` are kept out of tmux: a tmux server copies the environment of whoever starts it into every
  window, so `DRY_RUN=0` would otherwise end up in the user's shells. Put `DRY_RUN=0` in `<cmd>` explicitly if needed.
- SSH agent: tmux's `SSH_AUTH_SOCK` (global and per session) is set at attach time and goes stale once that SSH
  connection drops. The script passes the caller's `SSH_AUTH_SOCK` to the window (`tmux -e`) when that agent
  holds keys. Otherwise the runner uses the first `/tmp/ssh-*/agent.*` that answers `ssh-add -l`, or prints
  `[warn] no live ssh agent` and runs anyway. This matters for `git@` remotes and fetches.
- `~/linuxdev/runs/<name>-<ts>.sh` (runner), `.log` (output with colors, via `script`), `.rc` (exit code, written at the end).
- A finished window stays open (`remain-on-exit`). Its last line is `== <name> exited N ==`.
- Starting a run with the name of a finished window replaces that window. The new window is created before the
  old one is killed, so the session never empties and an attached client isn't detached. The old log stays.
  A run with the name of a window that's still running is refused.
- Window names: `<board>-<branch>` for Armbian (eg. `nanopct6-edge`), `<worktree-slug>-<target>` for kernel/u-boot (eg. `cec-dtbs`).
- Ctrl-C in a build tab interrupts it like in a normal terminal; the `.rc` records the exit code.
