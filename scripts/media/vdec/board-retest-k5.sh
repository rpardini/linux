#!/bin/bash
# FFmpeg conformance after the MT2110 P010 detile (10-bit vectors now checkable)
cd "$(dirname "$0")"
for j in av1/AV1-TEST-VECTORS av1/CHROMIUM-10bit-AV1-TEST-VECTORS h.265/JCT-VC-HEVC_V1 vp9/VP9-TEST-VECTORS; do
	echo "=== $j"
	python3 board-ffmpeg-md5.py fluster/test_suites/$j.json > results/k5-ffmpeg-$(basename $j).txt; rc=$?
	tail -1 results/k5-ffmpeg-$(basename $j).txt
	[ $rc = 2 ] && { echo "ABORT: board dropped"; exit 2; }
done
