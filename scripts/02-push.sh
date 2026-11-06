#!/usr/bin/env bash
# Push every topics.tsv branch to its remote (never forced), the b4 sent/* tags, and this status branch.
# Sets upstream only for branches that don't already track something.
# Usage: [DRY_RUN=0] [ONLY=regex] scripts/02-push.sh
source "$(dirname "$0")/lib.sh"
dry_run_banner

declare -a SKIPPED=()

push_one() {
	local id="$1" repo="$2" branch="$3" remote="$8"
	[[ -z "$remote" ]] && { info "$id no remote; skipping"; return 0; }
	if ! has_branch "$repo" "$branch"; then
		warn "$id $branch missing locally (run 01-make-branches.sh first?)"
		SKIPPED+=("$id")
		return 0
	fi
	local -a u=()
	g "$repo" rev-parse -q --verify "$branch@{upstream}" > /dev/null 2>&1 || u=(-u)
	info "$id $branch -> $remote"
	run git -C "$(repo_dir "$repo")" push ${u[@]+"${u[@]}"} "$remote" "refs/heads/$branch:refs/heads/$branch"
}

each_topic push_one

if [[ -z "$ONLY" ]]; then
	if g kernel tag -l 'sent/*' | grep -q .; then
		info "b4 sent/* tags -> rpardini-linux"
		run git -C "$(repo_dir kernel)" push rpardini-linux 'refs/tags/sent/*:refs/tags/sent/*'
	fi
	if g u-boot tag -l 'sent/*' | grep -q .; then
		info "b4 sent/* tags -> rpardini-armbian"
		run git -C "$(repo_dir u-boot)" push rpardini-armbian 'refs/tags/sent/*:refs/tags/sent/*'
	fi
	info "status branch -> rpardini-linux"
	local_u=()
	git -C "$STATUS_DIR" rev-parse -q --verify 'status@{upstream}' > /dev/null 2>&1 || local_u=(-u)
	run git -C "$STATUS_DIR" push ${local_u[@]+"${local_u[@]}"} rpardini-linux refs/heads/status:refs/heads/status
fi

((${#SKIPPED[@]})) && warn "skipped (missing locally): ${SKIPPED[*]}"
ok "done"
