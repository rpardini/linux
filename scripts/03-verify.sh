#!/usr/bin/env bash
# Compare every topics.tsv branch with $PUSH_PREFIX<branch> on its remote (one ls-remote per remote). Read-only.
#   OK          local == remote
#   AHEAD/BEHIND/DIVERGED  relative to the remote tip (when the remote commit is known locally)
#   NOT-PUSHED  missing on the remote
#   NO-LOCAL    missing locally
# Usage: [ONLY=regex] scripts/03-verify.sh
source "$(dirname "$0")/lib.sh"

CACHE="$(mktemp -d "${TMPDIR:-/tmp}/linuxdev-verify.XXXXXX")"
trap 'rm -rf "$CACHE"' EXIT
declare -i BAD=0

remote_heads() { # <repo> <remote> -> cached "sha<TAB>ref" lines
	local f="$CACHE/$1.$2"
	[[ -f "$f" ]] || g "$1" ls-remote --heads "$2" > "$f" || : > "$f"
	cat "$f"
}

verify_one() {
	local id="$1" repo="$2" branch="$3" remote="$8" state
	[[ -z "$remote" ]] && return 0
	local l r
	l="$(g "$repo" rev-parse -q --verify "refs/heads/$branch" 2> /dev/null || true)"
	r="$(remote_heads "$repo" "$remote" | awk -v ref="refs/heads/$(remote_branch "$branch")" '$2 == ref { print $1 }')"
	if [[ -z "$l" ]]; then
		state="NO-LOCAL"
	elif [[ -z "$r" ]]; then
		state="NOT-PUSHED"
	elif [[ "$l" == "$r" ]]; then
		state="OK"
	elif ! g "$repo" cat-file -e "$r^{commit}" 2> /dev/null; then
		state="DIFFERS(fetch $remote)"
	elif g "$repo" merge-base --is-ancestor "$r" "$l"; then
		state="AHEAD"
	elif g "$repo" merge-base --is-ancestor "$l" "$r"; then
		state="BEHIND"
	else
		state="DIVERGED"
	fi
	[[ "$state" == "OK" ]] || BAD+=1
	printf '%-5s %-11s %-8s %-40s %s\n' "$id" "$state" "$repo" "$remote" "$branch"
}

each_topic verify_one
((BAD == 0)) && ok "all topics in sync" || { warn "$BAD topic(s) not in sync"; exit 1; }
