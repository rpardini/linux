#!/bin/bash
# FFmpeg v4l2request md5 conformance on the NIO-12L, all downloaded suites. Results -> results/ffmpeg-<suite>.txt
cd "$(dirname "$0")"
for j in vp8/VP8-TEST-VECTORS vp9/VP9-TEST-VECTORS av1/AV1-TEST-VECTORS av1/CHROMIUM-8bit-AV1-TEST-VECTORS h.265/JCT-VC-HEVC_V1; do
	python3 board-ffmpeg-md5.py fluster/test_suites/$j.json | tee results/ffmpeg-$(basename $j).txt | grep -E '^(KO|TOTAL)'
done
