#!/usr/bin/env bash
# Build a media test image on this VM (docker, arm64) and load it into the board's containerd (nerdctl, no buildkit there).
#
# Usage: 51-media-image.sh <name> [--no-ship]
#   <name>  scripts/media/<name>.Dockerfile; build context per name below. Image tag: vdec/<name>:latest
#   BOARD   ssh target (default root@192.168.66.83, the NIO-12L CaptainOS node)
# DRY_RUN=1 (default) only prints the commands.
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

name="${1:-}"
[[ -n "$name" ]] || die "usage: $0 <name> [--no-ship]"
ship=1
[[ "${2:-}" == "--no-ship" ]] && ship=0
BOARD="${BOARD:-root@192.168.66.83}"
dockerfile="$STATUS_DIR/scripts/media/$name.Dockerfile"
[[ -f "$dockerfile" ]] || die "no $dockerfile"

case "$name" in
	gst-fluster) context="$LINUXDEV_ROOT/le-media-kodi-vdec/fluster" ;;
	*) context="$STATUS_DIR/scripts/media" ;;
esac
tag="vdec/$name:latest"

run docker build -f "$dockerfile" -t "$tag" "$context"
if ((ship)); then
	info "loading $tag into $BOARD containerd"
	if ((DRY_RUN)); then
		echo "docker save $tag | ssh $BOARD nerdctl load"
	else
		docker save "$tag" | ssh -o BatchMode=yes "$BOARD" nerdctl load
	fi
fi
