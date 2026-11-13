#!/bin/bash
# FFmpeg AV1 retest on the K26 kernel (these panicked before). Aborts on board loss.
cd "$(dirname "$0")"
for j in av1/AV1-TEST-VECTORS av1/CHROMIUM-8bit-AV1-TEST-VECTORS; do
	echo "=== FFmpeg $j"
	python3 board-ffmpeg-md5.py fluster/test_suites/$j.json > results/k3-ffmpeg-$(basename $j).txt
	rc=$?; grep -E '^TOTAL|^ABORT' results/k3-ffmpeg-$(basename $j).txt; grep IOMMU results/k3-ffmpeg-$(basename $j).txt | awk '{print $2, $3}'
	[ $rc = 2 ] && exit 2
done
ssh root@192.168.66.83 'journalctl -k -b --no-pager | grep -i -E "Oops|BUG:|Unable to handle|cap_to_disp|MTK_V4L2.*ERROR" | tail -10'
