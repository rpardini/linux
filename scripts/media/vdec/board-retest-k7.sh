#!/bin/bash
# FFmpeg conformance after the AV1 sizeup and min-framesize fixes
cd "$(dirname "$0")"
for j in vp9/VP9-TEST-VECTORS h.264/JVT-AVC_V1 h.265/JCT-VC-HEVC_V1 av1/AV1-TEST-VECTORS vp8/VP8-TEST-VECTORS; do
	echo "=== $j"
	python3 board-ffmpeg-md5.py fluster/test_suites/$j.json > results/k7-ffmpeg-$(basename $j).txt; rc=$?
	tail -1 results/k7-ffmpeg-$(basename $j).txt
	[ $rc = 2 ] && { echo "ABORT: board dropped"; exit 2; }
done
