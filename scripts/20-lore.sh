#!/usr/bin/env bash
# lore.kernel.org mail via lei (public-inbox) + Sashiko AI reviews, kept under $LORE_DIR.
# See notes/lore-lei.md for the how-to (reading the Maildirs, useful queries).
#
# Usage: [DRY_RUN=0] scripts/20-lore.sh <command> [args]
#   init              lei store in $LORE_DIR/lei-store + lore.kernel.org/all as remote external (idempotent)
#   mine              saved search $LORE_DIR/mine: all threads I posted in (direct + B4 Relay) or
#                     was To/Cc'd on, so later replies to my patches are caught too
#   topic <id|branch> saved search $LORE_DIR/topics/<id>/maildir: all threads of a b4 series
#                     (matched by its b4 change-id, so future versions are picked up by `up`), plus
#                     one b4 mbox per sent version in .../mbox/vN.mbx
#   sashiko <id|branch>  Sashiko review per sent version: .../sashiko/vN.json + vN.md
#   all <id|branch>   topic + sashiko
#   up                lei up --all (refresh every saved search), then re-fetch the b4 mbox of every
#                     sent version of each topic in $LORE_DIR/topics (the b: change-id search only
#                     matches the cover letter, so it never sees replies that arrive later)
#
# Series info (change-id, sent versions' message-ids) comes from the b4 tracking JSON in the
# branch's cover commit (b4 cover-strategy commit), so only b4/* topics work for topic/sashiko.
# Requires: lei (Debian: apt install lei), b4, curl, python3.
source "$(dirname "$0")/lib.sh"

LORE_DIR="${LORE_DIR:-$LINUXDEV_ROOT/lore}"
LORE_URL="${LORE_URL:-https://lore.kernel.org/all/}"
SASHIKO_URL="${SASHIKO_URL:-https://sashiko.dev}"
# My From: addresses; B4 Relay sends as devnull+<local>.<domain>@kernel.org.
MY_FROM="${MY_FROM:-ricardo@pardini.net devnull+ricardo.pardini.net@kernel.org}"

usage() { sed -n '2,/^# Requires/p' "$0" | sed 's/^# \{0,1\}//' >&2; exit 1; }

# saved_search <dir> <query terms...>: lei q into a Maildir, or lei up if that output is already a
# saved search with the same query. A changed query re-creates the search (lei forget-search; the
# Maildir is rebuilt). Pass terms as separate words (lei turns a single arg with spaces into a phrase).
saved_search() {
	local out="$1" old
	shift
	if lei ls-search 2> /dev/null | grep -qxF "$out"; then
		old="$(lei ls-search -l 2> /dev/null | python3 -I -c 'import json, sys
print(" ".join(next((s["q"] for s in json.load(sys.stdin) if s["output"] == "maildir:" + sys.argv[1]), [])))' "$out")"
		if [[ "$old" == "$*" ]]; then
			info "lei up $out"
			run lei up "$out"
			return
		fi
		warn "query of $out changed (was: $old); re-creating the saved search"
		run lei forget-search "$out"
	fi
	{
		run mkdir -p "$(dirname "$out")"
		run lei q -O "$LORE_URL" -t -o "$out" "$@"
	}
}

cmd_init() {
	command -v lei > /dev/null || die "lei not found (Debian: apt install lei)"
	if [[ -n "$(lei config leistore.dir 2> /dev/null)" ]]; then
		ok "lei store already at $(lei config leistore.dir)"
	else
		run mkdir -p "$LORE_DIR"
		run lei init "$LORE_DIR/lei-store"
	fi
	if lei ls-external 2> /dev/null | grep -q "^$LORE_URL "; then
		ok "external $LORE_URL already added"
	else
		run lei add-external "$LORE_URL"
	fi
}

cmd_mine() {
	local q=() a
	for a in $MY_FROM; do q+=(${q[@]:+OR} "f:$a" OR "t:$a" OR "c:$a"); done
	saved_search "$LORE_DIR/mine" "${q[@]}"
}

cmd_topic() {
	b4_tracking "$1"
	local cid dir v mid
	cid="$(json_get 's["change-id"]')"
	dir="$LORE_DIR/topics/$TOPIC_ID"
	info "$TOPIC_ID: $TOPIC_BRANCH change-id $cid"
	run mkdir -p "$dir/mbox"
	[[ "$DRY_RUN" == "0" ]] && printf '%s\n' "id: $TOPIC_ID" "branch: $TOPIC_BRANCH" "change-id: $cid" > "$dir/INFO"
	saved_search "$dir/maildir" "b:$cid"
	topic_mboxes "$dir"
	ok "$TOPIC_ID: $dir"
}

# topic_mboxes <dir>: (re-)fetch the b4 mbox of each sent version's thread into <dir>/mbox
# (b4 overwrites, so this always has the whole thread). Needs b4_tracking first.
topic_mboxes() {
	local v mid
	while read -r v mid; do
		[[ -n "$v" ]] || continue
		run b4 -q mbox -n "$v.mbx" -o "$1/mbox" "$mid"
		if [[ "$DRY_RUN" == "0" ]]; then info "$TOPIC_ID $v: $(grep -c '^From ' "$1/mbox/$v.mbx") messages"; fi
	done < <(sent_versions)
}

# up: refresh every saved search, then every topic's per-version mboxes (topics with an INFO file).
cmd_up() {
	local info id
	run lei up --all
	for info in "$LORE_DIR"/topics/*/INFO; do
		[[ -f "$info" ]] || continue
		id="$(sed -n 's/^id: //p' "$info")"
		[[ -n "$ONLY" && ! "$id" =~ $ONLY ]] && continue
		# subshell: b4_tracking dies when the branch isn't checked out here
		(b4_tracking "$id" && topic_mboxes "$(dirname "$info")") || warn "$id: mbox refresh skipped"
	done
}

cmd_sashiko() {
	b4_tracking "$1"
	local dir v mid
	dir="$LORE_DIR/topics/$TOPIC_ID/sashiko"
	run mkdir -p "$dir"
	while read -r v mid; do
		[[ -n "$v" ]] || continue
		run curl -sSf -o "$dir/$v.json" "$SASHIKO_URL/api/patchset?id=${mid//@/%40}" || { warn "$TOPIC_ID $v: no Sashiko patchset for $mid"; continue; }
		[[ "$DRY_RUN" == "0" ]] || continue
		sashiko_md "$dir/$v.json" "$SASHIKO_URL/#/patchset/${mid//@/%40}" > "$dir/$v.md"
		info "$TOPIC_ID $v: $(grep -c '^### ' "$dir/$v.md") patches, $(grep -c '^#### finding' "$dir/$v.md" || true) with findings -> $dir/$v.md"
	done < <(sent_versions)
	ok "$TOPIC_ID: $dir"
}

# sashiko_md <json> <web-url>: readable dump of a Sashiko patchset (per-patch inline reviews).
sashiko_md() {
	python3 -I - "$1" "$2" << 'EOF'
import json, sys
d = json.load(open(sys.argv[1]))
print(f"# Sashiko: {d.get('subject')}\n")
print(f"- web: {sys.argv[2]}")
print(f"- status: {d.get('status')}; model: {d.get('provider')}/{d.get('model_name')}; baseline: {(d.get('baseline') or {}).get('commit')}")
patches = {p["id"]: p for p in d.get("patches", [])}
for r in sorted(d.get("reviews", []), key=lambda r: patches.get(r.get("patch_id"), {}).get("part_index", 0)):
    p = patches.get(r.get("patch_id"), {})
    print(f"\n### {p.get('subject', r.get('patch_id'))}\n")
    print(f"- review status: {r.get('status')}; {r.get('result')}")
    if r.get("summary"):
        print(f"- summary: {r['summary']}")
    body = (r.get("inline_review") or "").strip()
    if len(body) > 40:
        print("\n#### finding\n")
        print(body)
    else:
        print("- no findings" + (f" ({body})" if body else ""))
EOF
}

cmd="${1:-}"
shift || true
[[ "$cmd" != "up" && "$cmd" != "init" && "$cmd" != "mine" ]] && [[ -n "$cmd" && -z "${1:-}" ]] && usage
dry_run_banner
case "$cmd" in
	init) cmd_init ;;
	mine) cmd_mine ;;
	topic) cmd_topic "$1" ;;
	sashiko) cmd_sashiko "$1" ;;
	all) cmd_topic "$1" && cmd_sashiko "$1" ;;
	up) cmd_up ;;
	*) usage ;;
esac
