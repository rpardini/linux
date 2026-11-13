#!/bin/bash
# Run on the VM: GStreamer V4L2SL fluster baseline on the NIO-12L. Summary -> /root/vdec/results/gst-<suite>.md (board)
set -u
B=${BOARD:-root@192.168.66.83}
run() { # $1 decoder $2.. suites
	local dec=$1; shift
	for ts in "$@"; do
		echo "=== $dec $ts"
		ssh -o BatchMode=yes $B "nerdctl run --rm --net=host --privileged -v /dev:/dev -v /root/vdec/vectors:/vectors -v /root/vdec/results:/results vdec/gst-fluster -ne run -j1 -t 60 -d $dec -ts $ts -s -so /results/gst-$ts.md" 2>&1 | tail -4
	done
}
run GStreamer-VP8-V4L2SL VP8-TEST-VECTORS
run GStreamer-VP9-V4L2SL VP9-TEST-VECTORS
run GStreamer-AV1-V4L2SL AV1-TEST-VECTORS CHROMIUM-8bit-AV1-TEST-VECTORS CHROMIUM-10bit-AV1-TEST-VECTORS
run GStreamer-H.265-V4L2SL JCT-VC-HEVC_V1
ssh -o BatchMode=yes $B 'journalctl -k --since "-3h" --no-pager | grep -v audit | grep -i -E "vcodec|scp|mdp|iommu|timeout|error" | tail -30'
