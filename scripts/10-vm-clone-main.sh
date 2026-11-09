#!/usr/bin/env bash
# Create (or refresh) a main tree on a VM / remote host, with the remotes from remotes.tsv.
# Idempotent: existing trees only get missing remotes added, changed URLs fixed, and a fetch.
#
# Bootstrap on a new host:
#   mkdir -p ~/linuxdev && cd ~/linuxdev
#   git clone -o linuxdev-status-rpardini -b linuxdev-work/status --single-branch git@github.com:rpardini/linux.git linuxdev-status
#   DRY_RUN=0 linuxdev-status/scripts/10-vm-clone-main.sh kernel --blobless
#   DRY_RUN=0 linuxdev-status/scripts/10-vm-clone-main.sh u-boot
#
# Usage: [DRY_RUN=0] scripts/10-vm-clone-main.sh <kernel|u-boot> [--blobless] [--no-checkout]
#   --blobless     first fetch uses --filter=blob:none (blobs fetched on demand)
#   --no-checkout  leave HEAD unborn instead of detaching at the upstream default branch
source "$(dirname "$0")/lib.sh"

repo="${1:-}"
[[ "$repo" == "kernel" || "$repo" == "u-boot" ]] || die "usage: $0 <kernel|u-boot> [--blobless] [--no-checkout]"
shift
BLOBLESS=0 CHECKOUT=1
for a in "$@"; do
	case "$a" in
		--blobless) BLOBLESS=1 ;;
		--no-checkout) CHECKOUT=0 ;;
		*) die "unknown option $a" ;;
	esac
done
dry_run_banner

dir="$(repo_dir "$repo")"
FRESH=0
if [[ ! -e "$dir/.git" ]]; then
	info "creating main tree $dir"
	run git init -q "$dir"
	FRESH=1
fi

# In dry-run on a fresh host there is no repo to inspect; just print what would happen.
gx() { if [[ -e "$dir/.git" ]]; then git -C "$dir" "$@"; else return 1; fi; }

add_remote() {
	local name="$1" url="$2" cur
	cur="$(gx remote get-url "$name" 2> /dev/null || true)"
	if [[ -z "$cur" ]]; then
		run git -C "$dir" remote add "$name" "$url"
	elif [[ "$cur" != "$url" ]]; then
		warn "remote $name: $cur -> $url"
		run git -C "$dir" remote set-url "$name" "$url"
	fi
}
each_remote "$repo" add_remote

declare -a FETCH_OPTS=()
((FRESH && BLOBLESS)) && FETCH_OPTS=(--filter=blob:none)
fetch_remote() {
	local name="$1" fetch="$3"
	[[ "$fetch" == "y" ]] || return 0
	info "fetching $name"
	run git -C "$dir" fetch ${FETCH_OPTS[@]+"${FETCH_OPTS[@]}"} --prune "$name"
	if [[ "$name" == *-rpardini-* ]]; then # b4 bookkeeping tags live on the forks
		run git -C "$dir" fetch "$name" 'refs/tags/sent/*:refs/tags/sent/*' || warn "no sent/* tags on $name"
	fi
}
each_remote "$repo" fetch_remote

if ((CHECKOUT)) && ! gx rev-parse -q --verify HEAD > /dev/null 2>&1; then
	case "$repo" in
		kernel) start="kernel-torvalds/master" ;;
		u-boot) start="uboot-upstream/main" ;;
	esac
	info "detaching main tree at $start"
	run git -C "$dir" switch --detach "$start"
fi
ok "$repo main tree ready at $dir (use 11-vm-checkout.sh to check out topics)"
