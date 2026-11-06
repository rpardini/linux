#!/usr/bin/env bash
# Push every topics.tsv branch to its remote as $PUSH_PREFIX<branch> (never forced), the b4 sent/*
# tags, and this status branch (as ${PUSH_PREFIX}status). Sets each branch's upstream to the pushed ref.
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
	local rb
	rb="$(remote_branch "$branch")"
	info "$id $branch -> $remote $rb"
	run git -C "$(repo_dir "$repo")" push -u "$remote" "refs/heads/$branch:refs/heads/$rb"
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
	info "$STATUS_BRANCH branch -> rpardini-linux $(remote_branch "$STATUS_BRANCH")"
	run git -C "$STATUS_DIR" push -u rpardini-linux "refs/heads/$STATUS_BRANCH:refs/heads/$(remote_branch "$STATUS_BRANCH")"
fi

((${#SKIPPED[@]})) && warn "skipped (missing locally): ${SKIPPED[*]}"
ok "done"
