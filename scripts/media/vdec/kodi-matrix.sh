#!/bin/bash
# kodi-matrix.sh [clips...]: kodi-test.sh per clip, EGL (1) then DirectToPlane (0); stops if the board drops.
cd "$(dirname "$0")"
CLIPS=${*:-h264-1080.mp4 hevc-1080.mkv vp9-1080.webm av1-1080.mkv h264-2160.mp4 hevc-2160.mkv vp9-2160.webm av1-2160.mkv hevc10-1080.mkv}
for c in $CLIPS; do for r in 1 0; do
	echo "=== $c r=$r"; ./kodi-test.sh "$c" $r 15 | grep -E "props A|capture:|iommu|FAIL|window"
	ssh -o BatchMode=yes -o ConnectTimeout=8 root@192.168.66.83 true || { echo "BOARD UNREACHABLE after $c r=$r"; exit 3; }
done; done
