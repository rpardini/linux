#!/bin/bash
# Retest on kernel build #3 (K26/K28/K29): FFmpeg (cache hints on) then GStreamer baseline. Sequential; aborts on board loss.
cd "$(dirname "$0")"
B=root@192.168.66.83
for j in vp8/VP8-TEST-VECTORS h.264/JVT-AVC_V1 h.265/JCT-VC-HEVC_V1 vp9/VP9-TEST-VECTORS; do
	echo "=== FFmpeg $j"
	python3 board-ffmpeg-md5.py fluster/test_suites/$j.json > results/k3-ffmpeg-$(basename $j).txt
	rc=$?; grep -E '^TOTAL|^ABORT' results/k3-ffmpeg-$(basename $j).txt; grep -c IOMMU results/k3-ffmpeg-$(basename $j).txt
	[ $rc = 2 ] && exit 2
done
for p in "VP8-V4L2SL VP8-TEST-VECTORS" "VP9-V4L2SL VP9-TEST-VECTORS" "AV1-V4L2SL AV1-TEST-VECTORS" "AV1-V4L2SL CHROMIUM-8bit-AV1-TEST-VECTORS" "AV1-V4L2SL CHROMIUM-10bit-AV1-TEST-VECTORS" "H.265-V4L2SL JCT-VC-HEVC_V1" "H.264-V4L2SL JVT-AVC_V1"; do
	set -- $p
	echo "=== GStreamer $1 $2"
	ssh -o BatchMode=yes $B "nerdctl run --rm --net=host --privileged -v /dev:/dev -v /root/vdec/vectors:/vectors -v /root/vdec/results:/results vdec/gst-fluster -ne run -j1 -t 60 -d GStreamer-$1 -ts $2 -s -so /results/k3-gst-$2.md" 2>&1 | grep -E "^Ran|rror" | tail -2
	[ ${PIPESTATUS[0]} = 255 ] && { echo "ABORT: board unreachable"; exit 2; }
done
scp -q "$B:/root/vdec/results/k3-gst-*.md" results/
ssh $B 'journalctl -k -b --no-pager | grep -c "iommu.*fault"'
