#!/usr/bin/env bash
# Check out a topic (id or branch from topics.tsv, or any $PUSH_PREFIX branch on a fork) on a VM /
# remote host, either in the main tree or in its own worktree. Creates the main tree first if missing.
# The fork's linuxdev-work/<x> becomes local branch <x> (so b4 branches are b4/* locally, as b4 expects).
# Never resets an existing local branch; reports ahead/behind instead.
#
# Usage: [DRY_RUN=0] scripts/11-vm-checkout.sh <topic-id|branch> [--repo kernel|u-boot] [--worktree [path]]
#   default         git switch <branch> in the main tree (refuses if tracked files are dirty)
#   --worktree      git worktree add <path> <branch>; path defaults to $LINUXDEV_ROOT/<repo>-<id|branch>
#   --repo          only needed for branches not listed in topics.tsv (default: kernel)
source "$(dirname "$0")/lib.sh"

key="$(local_branch "${1:-}")"
[[ -n "$key" && "$key" != -* ]] || die "usage: $0 <topic-id|branch> [--repo kernel|u-boot] [--worktree [path]]"
shift
WORKTREE=0 WT_PATH="" REPO_OPT=""
while (($#)); do
	case "$1" in
		--worktree)
			WORKTREE=1
			if [[ $# -gt 1 && "$2" != -* ]]; then WT_PATH="$2"; shift; fi
			;;
		--repo) REPO_OPT="$2"; shift ;;
		*) die "unknown option $1" ;;
	esac
	shift
done
dry_run_banner

id="" repo="" branch="" remote="" b4=""
if row="$(topic_row "$key")" && [[ -n "$row" ]]; then
	IFS=$'\t' read -r id repo branch _ _ _ _ remote b4 <<< "$row"
	[[ "$remote" == "-" ]] && remote=""
	[[ "$b4" == "-" ]] && b4=""
else
	repo="${REPO_OPT:-kernel}" branch="$key"
	warn "$key not in topics.tsv; treating as a branch of $repo"
fi
dir="$(repo_dir "$repo")"

if [[ ! -e "$dir/.git" ]]; then
	info "main tree $dir missing; creating it"
	"$(dirname "$0")/10-vm-clone-main.sh" "$repo"
	[[ -e "$dir/.git" ]] || die "dry-run: main tree not created; re-run with DRY_RUN=0"
fi

# Branch not in topics.tsv: find the first fork (fetch=y remote) that has it.
if [[ -z "$remote" ]]; then
	find_remote() { [[ -z "$remote" && "$3" == "y" ]] && g "$repo" ls-remote --exit-code --heads "$1" "refs/heads/$(remote_branch "$branch")" > /dev/null 2>&1 && remote="$1"; return 0; }
	each_remote "$repo" find_remote
	[[ -n "$remote" ]] || die "$branch not found on any fetched remote of $repo"
fi

rb="$(remote_branch "$branch")"
info "${id:+$id: }$repo $branch (from $remote $rb)"
run git -C "$dir" fetch "$remote" "refs/heads/$rb:refs/remotes/$remote/$rb"

if has_branch "$repo" "$branch"; then
	if g "$repo" rev-parse -q --verify "refs/remotes/$remote/$rb" > /dev/null; then
		read -r behind ahead < <(g "$repo" rev-list --left-right --count "refs/remotes/$remote/$rb...refs/heads/$branch")
		((ahead || behind)) && warn "local $branch is ahead $ahead / behind $behind of $remote; not touching it"
	fi
else
	run git -C "$dir" branch --track "$branch" "refs/remotes/$remote/$rb"
fi

if [[ "$b4" == "y" ]]; then
	run git -C "$dir" config "branch.$branch.b4-prep-cover-strategy" commit
fi

if ((WORKTREE)); then
	[[ -n "$WT_PATH" ]] || WT_PATH="$LINUXDEV_ROOT/$repo-${id:-${branch//\//-}}"
	if [[ -e "$WT_PATH" ]]; then
		die "$WT_PATH already exists"
	fi
	run git -C "$dir" worktree add "$WT_PATH" "$branch"
	ok "worktree: $WT_PATH"
else
	if [[ -n "$(g "$repo" status --porcelain --untracked-files=no 2> /dev/null)" ]]; then
		die "main tree $dir has uncommitted changes; commit/stash first or use --worktree"
	fi
	run git -C "$dir" switch "$branch"
	ok "main tree $dir on $branch"
fi
