# tmux session `linuxdev` + iTerm2 tmux integration

Claude and long runs share one tmux session, `linuxdev`. iTerm2's tmux integration (`tmux -CC`) shows each
tmux window as a native iTerm2 tab: one tab for Claude, one per build.

## Setup

- One SSH connection: `ssh -t <vm> tmux -CC new -A -s linuxdev`. This attaches to the session, or creates it.
  - The tab you run it in becomes the "gateway": Esc detaches, X force-quits. iTerm2 can hide it.
  - Detaching (closing the window, Mac sleep, SSH drop) leaves everything running. Reattach with the same command.
- Claude runs in a window of the session: press Cmd-T in the tmux window, then
  `cd /opt/linuxdev && claude --continue` (or `--resume` to pick a conversation).
- Same Unix user everywhere (`rpardini`, uid 501), so Claude's shell and your SSH share the default tmux socket.
- iTerm2 → Settings → General → tmux:
  - "When attaching, restore windows as": **Native windows**.
  - "Automatically bury the tmux client session after connecting": on, to hide the gateway tab.
  - Pausing slow panes: keep the default. A pause stops only the display; the build and its log keep going.
    Press a key in the pane to catch up.
- Shell → tmux → Dashboard lists the windows and lets you show or hide them.

## Runs (`scripts/40-tmux-run.sh`)

- `DRY_RUN=0 scripts/40-tmux-run.sh <name> [-C <dir>] -- <cmd...>` opens a background (`-d`) window named `<name>`.
- `~/linuxdev/runs/<name>-<ts>.sh` (runner), `.log` (output with colors, via `script`), `.rc` (exit code, written at the end).
- A finished window stays open (`remain-on-exit`). Its last line is `== <name> exited N ==`.
- Starting a run with the name of a finished window replaces that window. The new window is created before the
  old one is killed, so the session never empties and an attached client isn't detached. The old log stays.
  A run with the name of a window that's still running is refused.
- Window names: `<board>-<branch>` for Armbian (eg. `nanopct6-edge`), `<worktree-slug>-<target>` for kernel/u-boot (eg. `cec-dtbs`).
- Ctrl-C in a build tab interrupts it like in a normal terminal; the `.rc` records the exit code.
