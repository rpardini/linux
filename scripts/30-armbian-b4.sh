#!/usr/bin/env bash
# Armbian patch files as untouched `b4 am` dumps from lore (one mbox file per series).
#
# Usage: [DRY_RUN=0] scripts/30-armbian-b4.sh <command> [args]
#   <id|branch>                 my series: dump its latest sent version into every file of its armbian.tsv row
#                               (b4 am -o- -l -S -t). A {v} in the file name becomes vN, and older -v* siblings
#                               are git rm'ed.
#   all                         the above for every armbian.tsv row (honors ONLY)
#   ext <msgid|url> <dir> <file> [b4 am args]  someone else's series: dump into armbian-build/patch/<dir>/<file>
#                               (extra args go to b4 am, eg. -P 3 to take only patch 3 of the series)
#                               (b4 am -o- -l -S -s: adds my Signed-off-by)
#
# Never commits. Check the result applies to the Armbian trees before committing.
# Requires: b4, git, python3.
source "$(dirname "$0")/lib.sh"

ARMBIAN_DIR="${ARMBIAN_DIR:-$LINUXDEV_ROOT/armbian-build}"
ARMBIAN_TSV="$STATUS_DIR/armbian.tsv"

usage() { sed -n '2,/^# Requires/p' "$0" | sed 's/^# \{0,1\}//' >&2; exit 1; }

# dump <dest-file> <b4 am args...>: b4 am -o- into dest (via a temp file, so a failure leaves dest alone).
dump() {
	local dest="$1"
	shift
	echo "${_c_cmd}+ b4 -q am -o- $* > $dest${_c_off}" >&2
	[[ "$DRY_RUN" == "0" ]] || return 0
	mkdir -p "$(dirname "$dest")"
	local tmp
	tmp="$(mktemp "$dest.XXXXXX")"
	if ! b4 -q am -o- "$@" > "$tmp" || ! grep -q '^From ' "$tmp"; then
		rm -f "$tmp"
		die "b4 am failed for $dest"
	fi
	mv "$tmp" "$dest"
	ok "$dest ($(grep -c '^From ' "$dest") patches)"
}

# armbian_row <id>: prints "dirs<TAB>file" for id.
armbian_row() { awk -F'\t' -v k="$1" '!/^#/ && $1 == k { print $2 "\t" $3; exit }' "$ARMBIAN_TSV"; }

cmd_topic() {
	b4_tracking "$1"
	local row dirs file ver msgid dir dest name old
	row="$(armbian_row "$TOPIC_ID")"
	[[ -n "$row" ]] || die "$TOPIC_ID not in armbian.tsv"
	IFS=$'\t' read -r dirs file <<< "$row"
	read -r ver msgid < <(sent_versions | tail -n1)
	[[ -n "$msgid" ]] || die "$TOPIC_ID: no sent version in b4 tracking"
	info "$TOPIC_ID: $ver $msgid"
	name="${file//\{v\}/$ver}"
	IFS=',' read -ra dirs <<< "$dirs"
	for dir in "${dirs[@]}"; do
		dest="$ARMBIAN_DIR/patch/$dir/$name"
		dump "$dest" -l -S -t "$msgid"
		[[ "$file" == *"{v}"* ]] || continue
		for old in "$ARMBIAN_DIR/patch/$dir/${file//\{v\}/v}"*; do
			[[ -e "$old" && "$old" != "$dest" ]] || continue
			# only exact <stem>v<N><suffix> siblings
			[[ "$(basename "$old")" =~ ^${file%%\{v\}*}v[0-9]+${file#*\{v\}}$ ]] || continue
			run git -C "$ARMBIAN_DIR" rm -q -- "${old#"$ARMBIAN_DIR/"}"
		done
	done
}

cmd_all() {
	local id
	while IFS=$'\t' read -r id _; do
		[[ -z "$id" || "$id" == \#* ]] && continue
		[[ -n "$ONLY" && ! "$id" =~ $ONLY ]] && continue
		cmd_topic "$id"
	done < "$ARMBIAN_TSV"
}

cmd_ext() {
	[[ $# -ge 3 ]] || usage
	local msgid="$1" dir="$2" file="$3"
	shift 3
	dump "$ARMBIAN_DIR/patch/$dir/$file" -l -S -s "$@" "$msgid"
}

[[ $# -ge 1 ]] || usage
dry_run_banner
case "$1" in
	-h | --help) usage ;;
	all) cmd_all ;;
	ext) shift; cmd_ext "$@" ;;
	*) cmd_topic "$1" ;;
esac
