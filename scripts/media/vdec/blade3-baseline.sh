#!/bin/bash
# blade3-baseline.sh: Rockchip RK3588 (mainline hantro/rkvdec) baseline with the same FFmpeg and GStreamer as the NIO.
# FFmpeg md5 -> results/blade3-ffmpeg-<suite>.txt; GStreamer fluster -> results/blade3-gst-<suite>.md
cd "$(dirname "$0")"; export BOARD=root@192.168.66.145
for j in vp8/VP8-TEST-VECTORS h.264/JVT-AVC_V1 h.265/JCT-VC-HEVC_V1 vp9/VP9-TEST-VECTORS av1/AV1-TEST-VECTORS av1/CHROMIUM-8bit-AV1-TEST-VECTORS av1/CHROMIUM-10bit-AV1-TEST-VECTORS; do
	echo "=== ffmpeg $j"
	python3 board-ffmpeg-md5.py fluster/test_suites/$j.json > results/blade3-ffmpeg-$(basename $j).txt; rc=$?
	tail -1 results/blade3-ffmpeg-$(basename $j).txt
	[ $rc = 2 ] && { echo "ABORT: board dropped"; exit 2; }
done
run() { local dec=$1; shift; for ts in "$@"; do echo "=== gst $dec $ts"
	ssh -o BatchMode=yes $BOARD "nerdctl run --rm --net=host --privileged -v /dev:/dev -v /root/vdec/vectors:/vectors -v /root/vdec/results:/results vdec/gst-fluster -ne run -j1 -t 60 -d $dec -ts $ts -s -so /results/blade3-gst-$ts.md" 2>&1 | grep -E "Ran|Success|Fail" | tail -2
done; }
run GStreamer-VP8-V4L2SL VP8-TEST-VECTORS
run GStreamer-H.264-V4L2SL JVT-AVC_V1
run GStreamer-H.265-V4L2SL JCT-VC-HEVC_V1
run GStreamer-VP9-V4L2SL VP9-TEST-VECTORS
run GStreamer-AV1-V4L2SL AV1-TEST-VECTORS CHROMIUM-8bit-AV1-TEST-VECTORS CHROMIUM-10bit-AV1-TEST-VECTORS
scp -q "$BOARD:/root/vdec/results/blade3-gst-*.md" results/
