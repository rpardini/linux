#!/bin/bash
# blade3-setup.sh: prepare the Blade3 (RK3588, mainline) as a second, headless test board:
# FFmpeg build, the vdec images + Kodi image, fluster vectors and clips. Same layout as the NIO (/opt/ffmpeg-vdec, /root/vdec).
set -e
B=${BOARD:-root@192.168.66.145}; HERE=$(cd "$(dirname "$0")" && pwd)
ssh $B 'mkdir -p /root/vdec/vectors /root/vdec/clips /root/vdec/results /root/vdec/tools'
echo "== ffmpeg-vdec"; tar -C "$HERE/out/ffmpeg-vdec" -cf - . | ssh $B 'rm -rf /opt/ffmpeg-vdec && tar -C / -xf -'
for img in vdec/ffmpeg-run vdec/gst-fluster kodi-rockchip-gbm:trixie-v4l2requests; do echo "== $img"; docker save $img | ssh $B nerdctl load | tail -1; done
echo "== vectors"; tar -C "$HERE/fluster-vectors" -cf - . | ssh $B 'tar -C /root/vdec/vectors -xf -'
echo "== clips"; tar -C "$HERE/clips" -cf - . | ssh $B 'tar -C /root/vdec/clips -xf -'
scp -q "$HERE/tools/h264ctl-dump.so" $B:/root/vdec/tools/
ssh $B 'du -sh /root/vdec/* /opt/ffmpeg-vdec; nerdctl images | grep -E "vdec|kodi"'
