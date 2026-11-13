#!/bin/bash
# MDP3 soak (K29): 20 short decode->scale_v4l2m2m runs with idle gaps (GCE autosuspend between jobs),
# then one long looped run. Stops at the first stuck/failed run. Run only with the user at the board.
B=root@192.168.66.83
V=/vectors/VP9-TEST-VECTORS/vp90-2-02-size-lf-1920x1080.webm/vp90-2-02-size-lf-1920x1080.webm
F="nerdctl run --rm --net=host --privileged -v /dev:/dev -v /opt/ffmpeg-vdec:/opt/ffmpeg-vdec:ro -v /root/vdec/vectors:/vectors vdec/ffmpeg-run"
T0=$(ssh $B date +%s)
for i in $(seq 1 20); do
	out=$(timeout 60 ssh -o BatchMode=yes $B "timeout 30 $F ffmpeg -nostdin -hide_banner -loglevel error -stats -hwaccel v4l2request -hwaccel_output_format drm_prime -i $V -vf scale_v4l2m2m=format=uyvy:w=1280:h=720 -f null - 2>&1 | tr '\r' '\n' | grep frame= | tail -1")
	echo "run $i: $out"
	echo "$out" | grep -q "frame=  217" || { echo "STOP: run $i incomplete"; exit 1; }
	sleep 2
done
echo "=== long run (x100 loop)"
timeout 600 ssh -o BatchMode=yes $B "timeout 540 $F ffmpeg -nostdin -hide_banner -loglevel error -stats -stream_loop 99 -hwaccel v4l2request -hwaccel_output_format drm_prime -i $V -vf scale_v4l2m2m=format=uyvy -f null - 2>&1 | tr '\r' '\n' | grep frame= | tail -1"
ssh $B "journalctl -k --since @$T0 --no-pager | grep -c 'iommu.*fault'; ps -eo stat,comm | grep '^D' | grep -v mt6360"
