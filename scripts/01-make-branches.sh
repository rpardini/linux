#!/usr/bin/env bash
# Create the canonical branches listed in topics.tsv. Never modifies existing branches.
#   mode=keep : nothing to do (just checks the branch exists)
#   mode=copy : git branch <branch> <source>
#   mode=pick : <branch> := <base> + cherry-picked <picks>, built in a throw-away detached worktree;
#               on conflict the pick is aborted, the branch is not created, and the topic is reported.
# Usage: [DRY_RUN=0] [ONLY=regex] scripts/01-make-branches.sh
source "$(dirname "$0")/lib.sh"
dry_run_banner

declare -a FAILED=()

make_one() {
	local id="$1" repo="$2" branch="$3" src="$4" mode="$5" base="$6" picks="$7"
	case "$mode" in
		keep)
			has_branch "$repo" "$branch" && ok "$id keep $branch" || { err "$id keep: $branch missing in $repo"; FAILED+=("$id"); }
			;;
		copy)
			if has_branch "$repo" "$branch"; then
				if [[ "$(g "$repo" rev-parse "refs/heads/$branch")" == "$(g "$repo" rev-parse "refs/heads/$src")" ]]; then
					ok "$id $branch already at $src"
				else
					warn "$id $branch exists but differs from $src; leaving it alone"
				fi
				return 0
			fi
			info "$id copy $src -> $branch"
			run git -C "$(repo_dir "$repo")" branch "$branch" "refs/heads/$src"
			;;
		pick)
			if has_branch "$repo" "$branch"; then
				ok "$id $branch already exists; leaving it alone"
				return 0
			fi
			info "$id pick $(tr ',' '\n' <<< "$picks" | wc -l | tr -d ' ') commit(s) onto $base -> $branch"
			local wt
			wt="$(mktemp -d "$LINUXDEV_ROOT/.linuxdev-pick-$id.XXXXXX")" # same volume as the repo
			rmdir "$wt" # git worktree add wants to create it
			run git -C "$(repo_dir "$repo")" worktree add --detach "$wt" "$base^{commit}"
			# shellcheck disable=SC2046
			if run git -C "$wt" cherry-pick --empty=drop $(tr ',' ' ' <<< "$picks"); then
				run git -C "$wt" branch "$branch" HEAD
				[[ "$DRY_RUN" == "0" ]] && ok "$id created $branch"
			else
				err "$id cherry-pick onto $base failed; branch not created (resolve manually: see STATUS.md)"
				git -C "$wt" cherry-pick --abort || true
				FAILED+=("$id")
			fi
			run git -C "$(repo_dir "$repo")" worktree remove --force "$wt"
			;;
		*) err "$id: unknown mode '$mode'"; FAILED+=("$id") ;;
	esac
}

each_topic make_one

if ((${#FAILED[@]})); then
	err "failed: ${FAILED[*]}"
	exit 1
fi
ok "all done"
