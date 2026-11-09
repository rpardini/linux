# shellcheck shell=bash
# Shared helpers for the linuxdev-status scripts. Source, don't execute.
#
# Environment:
#   LINUXDEV_ROOT  dir holding the main trees (kernel/, u-boot/) and worktrees.
#                  Default: parent of this status worktree.
#   DRY_RUN        1 (default) = only print mutating commands; 0 = execute them.
#   ONLY           optional regex; restrict to topic ids matching it (eg. ONLY='^(K9|U1)$').
#   PUSH_PREFIX    prefix for branches on the forks (default 'linuxdev-work/'): local b4/x <-> remote linuxdev-work/b4/x.

set -euo pipefail

STATUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LINUXDEV_ROOT="${LINUXDEV_ROOT:-$(dirname "$STATUS_DIR")}"
DRY_RUN="${DRY_RUN:-1}"
ONLY="${ONLY:-}"
PUSH_PREFIX="${PUSH_PREFIX:-linuxdev-work/}"
STATUS_BRANCH="${PUSH_PREFIX}status" # local == remote name (bootstrap clones it as-is); remote linuxdev-status-rpardini
STATUS_REMOTE="linuxdev-status-rpardini"
TOPICS_TSV="$STATUS_DIR/topics.tsv"
REMOTES_TSV="$STATUS_DIR/remotes.tsv"

if [[ -t 1 ]]; then
	_c_info=$'\e[36m' _c_warn=$'\e[33m' _c_err=$'\e[31m' _c_ok=$'\e[32m' _c_cmd=$'\e[2m' _c_off=$'\e[0m'
else
	_c_info="" _c_warn="" _c_err="" _c_ok="" _c_cmd="" _c_off=""
fi
info() { echo "${_c_info}[info]${_c_off} $*" >&2; }
warn() { echo "${_c_warn}[warn]${_c_off} $*" >&2; }
err() { echo "${_c_err}[err ]${_c_off} $*" >&2; }
ok() { echo "${_c_ok}[ ok ]${_c_off} $*" >&2; }
die() { err "$*"; exit 1; }

# run <cmd...>: mutating command; printed always, executed only when DRY_RUN=0.
run() {
	echo "${_c_cmd}+ $*${_c_off}" >&2
	[[ "$DRY_RUN" == "0" ]] || return 0
	"$@"
}

dry_run_banner() {
	if [[ "$DRY_RUN" == "0" ]]; then
		warn "DRY_RUN=0: commands WILL be executed"
	else
		info "dry-run: printing commands only; re-run with DRY_RUN=0 to execute"
	fi
}

# repo_dir <kernel|u-boot>: path of the main tree.
repo_dir() { echo "$LINUXDEV_ROOT/$1"; }

# g <repo> <git args...>: read-only git in a main tree.
g() { local r="$1"; shift; git -C "$(repo_dir "$r")" "$@"; }

# each_topic <callback>: calls callback id repo branch source mode base picks remote b4 slug
# for every non-comment row of topics.tsv ('-' fields become empty), honoring $ONLY.
each_topic() {
	local cb="$1" id repo branch src mode base picks remote b4 slug
	while IFS=$'\t' read -r id repo branch src mode base picks remote b4 slug; do
		[[ -z "$id" || "$id" == \#* ]] && continue
		[[ -n "$ONLY" && ! "$id" =~ $ONLY ]] && continue
		[[ "$src" == "-" ]] && src=""
		[[ "$base" == "-" ]] && base=""
		[[ "$picks" == "-" ]] && picks=""
		[[ "$remote" == "-" ]] && remote=""
		[[ "$b4" == "-" ]] && b4=""
		[[ "$slug" == "-" ]] && slug=""
		"$cb" "$id" "$repo" "$branch" "$src" "$mode" "$base" "$picks" "$remote" "$b4" "$slug"
	done < "$TOPICS_TSV"
}

# topic_row <id-or-branch>: prints the matching tab-separated row (first match).
topic_row() {
	awk -F'\t' -v k="$1" '!/^#/ && ($1 == k || $3 == k) { print; exit }' "$TOPICS_TSV"
}

# each_remote <repo> <callback>: calls callback name url fetch for repo's rows of remotes.tsv.
each_remote() {
	local want="$1" cb="$2" repo name url fetch
	while IFS=$'\t' read -r repo name url fetch; do
		[[ -z "$repo" || "$repo" == \#* || "$repo" != "$want" ]] && continue
		"$cb" "$name" "$url" "$fetch"
	done < "$REMOTES_TSV"
}

has_branch() { g "$1" rev-parse -q --verify "refs/heads/$2" > /dev/null; }

# remote_branch <local>: name of the branch on the fork.  local_branch <remote>: inverse.
remote_branch() { echo "${PUSH_PREFIX}$1"; }
local_branch() { echo "${1#"$PUSH_PREFIX"}"; }

# b4_tracking <id|branch>: sets TOPIC_ID, TOPIC_REPO, TOPIC_BRANCH, TOPIC_JSON (b4 tracking JSON).
b4_tracking() {
	local key row id repo branch
	key="$(local_branch "$1")"
	if row="$(topic_row "$key")" && [[ -n "$row" ]]; then
		IFS=$'\t' read -r id repo branch _ <<< "$row"
	else
		die "$key not in topics.tsv"
	fi
	has_branch "$repo" "$branch" || die "$id: branch $branch not present in $(repo_dir "$repo"); run 11-vm-checkout.sh $id first"
	TOPIC_ID="$id" TOPIC_REPO="$repo" TOPIC_BRANCH="$branch"
	TOPIC_JSON="$(g "$repo" log -1 --format=%B --grep='^--- b4-submit-tracking ---$' "$branch" |
		sed -n '/^--- b4-submit-tracking ---$/,$p' | sed '1,/^# /d')"
	[[ -n "$TOPIC_JSON" ]] || die "$id: no b4 tracking (cover commit) on $branch; not a b4 prep branch?"
}

# json_get <expr>: evaluate a python expression over the tracking JSON 's' (series dict).
json_get() {
	python3 -I -c 'import json,sys; s=json.loads(sys.stdin.read())["series"]; r=eval(sys.argv[1]); print("\n".join(r) if isinstance(r,list) else r)' "$1" <<< "$TOPIC_JSON"
}

# sent_versions: "vN msgid" lines for every sent version (first msgid of each).
sent_versions() { json_get '[f"{k} {v[0]}" for k, v in sorted(s.get("history", {}).items(), key=lambda kv: int(kv[0][1:]))]'; }
