#!/usr/bin/env bash
# Incremental native FFmpeg build for the MediaTek vdec work, in a trixie container on this VM (arm64).
#
# Usage: 50-media-ffmpeg-build.sh [--reconfigure] [--ship]
#   source   le-media-kodi-vdec/ffmpeg (whatever is checked out)
#   build    le-media-kodi-vdec/out/ffmpeg-build (out of tree, kept between runs)
#   install  le-media-kodi-vdec/out/ffmpeg-vdec/opt/ffmpeg-vdec (prefix /opt/ffmpeg-vdec, shared libs)
#   --ship   then tar it to $BOARD:/opt/ffmpeg-vdec (default root@192.168.66.83)
# Configure flags = kodi-rockchip-deb v4l2requests stage + explicit v4l2-request/libudev (fail instead of autodetect-off).
# DRY_RUN=1 (default) only prints the commands. Run long builds via 40-tmux-run.sh (window ffmpeg-vdec-build).
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

reconf=0 ship=0
for a in "$@"; do
	case "$a" in
		--reconfigure) reconf=1 ;;
		--ship) ship=1 ;;
		*) die "unknown arg $a" ;;
	esac
done
BOARD="${BOARD:-root@192.168.66.83}"
MEDIA="$LINUXDEV_ROOT/le-media-kodi-vdec"
SRC="$MEDIA/ffmpeg"
OUT="$MEDIA/out"
IMG="vdec/ffmpeg-dev:latest"
PREFIX=/opt/ffmpeg-vdec
CONF="--prefix=$PREFIX --enable-gpl --enable-version3 --enable-shared --disable-static --disable-doc \
--enable-libdrm --enable-libudev --enable-v4l2-request --enable-v4l2_m2m --enable-libdav1d --enable-gnutls \
--extra-ldflags=-Wl,-rpath,$PREFIX/lib --cc='ccache gcc'"

run mkdir -p "$OUT/ffmpeg-build" "$OUT/ffmpeg-vdec" "$OUT/ccache"
if ! docker image inspect "$IMG" > /dev/null 2>&1; then
	run docker build -f "$STATUS_DIR/scripts/media/ffmpeg-dev.Dockerfile" -t "$IMG" "$STATUS_DIR/scripts/media"
fi

inner="set -e; cd /out/ffmpeg-build
if [ $reconf = 1 ] || [ ! -f ffbuild/config.mak ]; then /src/configure $CONF; fi
make -j\$(nproc)
rm -rf /out/ffmpeg-vdec/*; make install DESTDIR=/out/ffmpeg-vdec
LD_LIBRARY_PATH=/out/ffmpeg-vdec$PREFIX/lib /out/ffmpeg-vdec$PREFIX/bin/ffmpeg -hide_banner -hwaccels | grep -q v4l2request
LD_LIBRARY_PATH=/out/ffmpeg-vdec$PREFIX/lib /out/ffmpeg-vdec$PREFIX/bin/ffmpeg -hide_banner -filters | grep -E 'scale_v4l2m2m|deinterlace_v4l2m2m'
echo BUILD-OK"

run docker run --rm --user "$(id -u):$(id -g)" -e CCACHE_DIR=/out/ccache \
	-v "$SRC:/src:ro" -v "$OUT:/out" "$IMG" bash -c "$inner"

if ((ship)); then
	info "shipping $PREFIX to $BOARD"
	if ((DRY_RUN)); then
		echo "tar -C $OUT/ffmpeg-vdec -cf - . | ssh $BOARD 'rm -rf $PREFIX && tar -C / -xf -'"
	else
		tar -C "$OUT/ffmpeg-vdec" -cf - . | ssh -o BatchMode=yes "$BOARD" "rm -rf $PREFIX && tar -C / -xf -"
	fi
fi
