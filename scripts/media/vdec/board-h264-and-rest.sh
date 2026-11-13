#!/bin/bash
# Sequential: copy JVT-AVC_V1 to the board, GStreamer V4L2SL fluster, then FFmpeg md5 for H.264 + VP9/AV1/HEVC.
cd "$(dirname "$0")"
B=root@192.168.66.83
tar -C fluster-vectors -cf - JVT-AVC_V1 | ssh $B 'tar -C /root/vdec/vectors -xf -'
echo "=== GStreamer-H.264-V4L2SL JVT-AVC_V1"
ssh $B "nerdctl run --rm --net=host --privileged -v /dev:/dev -v /root/vdec/vectors:/vectors -v /root/vdec/results:/results vdec/gst-fluster -ne run -j1 -t 60 -d GStreamer-H.264-V4L2SL -ts JVT-AVC_V1 -s -so /results/gst-JVT-AVC_V1.md" 2>&1 | tail -3
scp -q $B:/root/vdec/results/gst-JVT-AVC_V1.md results/
for j in h.264/JVT-AVC_V1 vp9/VP9-TEST-VECTORS av1/AV1-TEST-VECTORS av1/CHROMIUM-8bit-AV1-TEST-VECTORS h.265/JCT-VC-HEVC_V1; do
	python3 board-ffmpeg-md5.py fluster/test_suites/$j.json | tee results/ffmpeg-$(basename $j).txt | grep -E '^(KO|TOTAL)|IOMMU'
done
