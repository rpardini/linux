#!/usr/bin/env bash
# Run a long command (build, make, dt_binding_check, ...) in a window of a tmux session, so the
# user can watch it from iTerm2 (`ssh -t <vm> tmux -CC new -A -s linuxdev`, see notes/tmux-iterm2.md).
# Output is logged (with colors) to $RUNS_DIR/<id>.log; the exit code goes to $RUNS_DIR/<id>.rc when done.
# The window stays open after exit (remain-on-exit). Starting a run with the name of a finished window
# replaces that window (its log stays); a running one with the same name is an error.
#
# Usage: [DRY_RUN=0] scripts/40-tmux-run.sh <name> [-C <dir>] -- <cmd...>
#   <name>   window name, eg. nanopct6-edge, kernel-cec-dtbs ([A-Za-z0-9._-])
#   -C       working dir (default: current dir)
# Session: $TMUX_SESSION if set; else the current one (when run inside tmux); else the most recently
#   attached existing session; else a new one named after the VM (hostname minus 'lima-', eg. armbian-trixie-linuxdev),
#   the same name the iTerm2 tmux profiles create.
# Env: RUNS_DIR (default $LINUXDEV_ROOT/runs), TMUX_SESSION
# SSH agent: tmux's own SSH_AUTH_SOCK goes stale when the SSH connection that set it drops. The caller's
#   SSH_AUTH_SOCK is passed to the window (tmux -e) if that agent holds keys; otherwise the runner picks the first
#   /tmp/ssh-*/agent.* that does, and warns if there is none (git@ remotes, b4 send etc. will then fail).
# Prints (stdout) LOG=, RC= and WINDOW= lines; wait for the RC file to appear.
source "$(dirname "$0")/lib.sh"

usage="usage: $0 <name> [-C <dir>] -- <cmd...>"
name="${1:-}"
[[ "$name" =~ ^[A-Za-z0-9._-]+$ ]] || die "$usage"
shift
dir="$PWD"
while (($#)); do
	case "$1" in
		-C) dir="${2:?$usage}"; shift 2 ;;
		--) shift; break ;;
		*) die "$usage" ;;
	esac
done
(($#)) || die "$usage"
[[ -d "$dir" ]] || die "no such dir: $dir"
dir="$(cd "$dir" && pwd)"

RUNS_DIR="${RUNS_DIR:-$LINUXDEV_ROOT/runs}"
SESSION="${TMUX_SESSION:-}"
if [[ -z "$SESSION" && -n "${TMUX:-}" ]]; then
	SESSION="$(tmux display-message -p '#{session_name}')"
fi
if [[ -z "$SESSION" ]]; then
	SESSION="$(tmux list-sessions -F '#{session_last_attached} #{session_name}' 2> /dev/null | sort -rn | awk 'NR == 1 { print $2 }')" || true
fi
if [[ -z "$SESSION" ]]; then
	SESSION="$(hostname -s)"
	SESSION="${SESSION#lima-}"
	SESSION="$(tr 'A-Z' 'a-z' <<< "$SESSION" | tr -c 'a-z0-9_\n-' '-')" # same slug rule as the iTerm2 profiles
fi
id="${name}-$(date +%Y%m%d-%H%M%S)"
log="$RUNS_DIR/$id.log" rc="$RUNS_DIR/$id.rc" runner="$RUNS_DIR/$id.sh"
printf -v cmd_q '%q ' "$@"
cmd_q="${cmd_q% }"

# Runner script: the window runs this; `script` gives the command a real TTY (colors) and logs it.
runner_body="$(
	cat << EOF
#!/usr/bin/env bash
# $id: started $(date -Is)
tmux set-option -w -t "\$TMUX_PANE" remain-on-exit on
unset DRY_RUN ONLY # never inherit this script's DRY_RUN=0; put it in <cmd> explicitly if wanted
# SSH agent: keep the inherited one if it holds keys, else the first live one with keys under /tmp.
if ! ssh-add -l > /dev/null 2>&1; then
	for s in /tmp/ssh-*/agent.*; do
		[[ -S "\$s" ]] && SSH_AUTH_SOCK="\$s" ssh-add -l > /dev/null 2>&1 || continue
		export SSH_AUTH_SOCK="\$s"
		echo "[info] SSH_AUTH_SOCK=\$s (inherited agent was not usable)"
		break
	done
	ssh-add -l > /dev/null 2>&1 || echo "[warn] no live ssh agent; git@ remotes will fail"
fi
cd $(printf %q "$dir") || exit 1
printf '== %s: %s (in %s) ==\n' $(printf '%q ' "$name" "$cmd_q" "$dir")
SHELL=/bin/bash script -qefc $(printf '%q ' "$cmd_q" "$log")
rc=\$?
echo "\$rc" > $(printf %q "$rc.tmp") && mv $(printf '%q ' "$rc.tmp" "$rc")
printf '== %s exited %s ==\n' $(printf %q "$name") "\$rc"
EOF
)"

# Same-name window: replace if finished, refuse if still running. The old window is killed only after the
# new one exists, so the session (and an attached iTerm2 -CC client) never runs out of windows.
old_ids=()
agent_env=() # caller's agent, only if it holds keys; the runner falls back otherwise
if [[ -S "${SSH_AUTH_SOCK:-}" ]] && ssh-add -l > /dev/null 2>&1; then
	agent_env=(-e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK")
fi
if tmux has-session -t "=$SESSION" 2> /dev/null; then
	while read -r wid wname dead; do
		[[ "$wname" == "$name" ]] || continue
		[[ "$dead" == "1" ]] || die "window '$name' in session '$SESSION' is still running"
		old_ids+=("$wid")
	done < <(tmux list-windows -t "=$SESSION" -F '#{window_id} #{window_name} #{pane_dead}')
	new=(env -u DRY_RUN -u ONLY tmux new-window -d -t "=$SESSION:" -n "$name" -c "$dir" ${agent_env[@]+"${agent_env[@]}"} bash "$runner")
else
	new=(env -u DRY_RUN -u ONLY tmux new-session -d -s "$SESSION" -n "$name" -c "$dir" ${agent_env[@]+"${agent_env[@]}"} bash "$runner")
fi

if [[ "$DRY_RUN" != "0" ]]; then
	info "dry run; runner $runner would be:"
	echo "$runner_body" >&2
else
	mkdir -p "$RUNS_DIR"
	echo "$runner_body" > "$runner"
fi
# tmux copies the caller's environment into a new server's global env (and so into every window, including
# the user's shells), hence `env -u DRY_RUN`. The runner sets remain-on-exit on its own pane first thing.
run "${new[@]}" > /dev/null
for wid in "${old_ids[@]}"; do
	run tmux kill-window -t "$wid"
done

echo "WINDOW=$SESSION:$name"
echo "LOG=$log"
echo "RC=$rc"
