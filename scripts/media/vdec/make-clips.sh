#!/bin/bash
# Generated Kodi test clips: testsrc2 + burned frame counter, 30 s, 30 fps. Output: clips/, then tar to the NIO /root/vdec/clips.
set -e
cd "$(dirname "$0")/clips"
docker run --rm -v "$PWD:/out" -w /out debian:trixie bash -c '
set -e
apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ffmpeg fonts-dejavu-core >/dev/null
T="drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text=%{n}:fontsize=h/8:fontcolor=white:box=1:boxcolor=black@0.7:x=(w-tw)/2:y=h/2-th"
for r in 1920x1080 3840x2160; do
  h=${r#*x}; src="-f lavfi -i testsrc2=size=$r:rate=30:duration=30"
  [ -f h264-$h.mp4 ] || ffmpeg -loglevel error $src -vf "$T,format=yuv420p" -c:v libx264 -profile:v high -preset veryfast -b:v 8M h264-$h.mp4
  [ -f hevc-$h.mkv ] || ffmpeg -loglevel error $src -vf "$T,format=yuv420p" -c:v libx265 -preset veryfast -b:v 8M -x265-params log-level=error hevc-$h.mkv
  [ -f vp9-$h.webm ] || ffmpeg -loglevel error $src -vf "$T,format=yuv420p" -c:v libvpx-vp9 -deadline realtime -cpu-used 8 -row-mt 1 -b:v 8M vp9-$h.webm
  [ -f av1-$h.mkv ] || ffmpeg -loglevel error $src -vf "$T,format=yuv420p" -c:v libsvtav1 -preset 10 -b:v 8M av1-$h.mkv
done
[ -f hevc10-1080.mkv ] || ffmpeg -loglevel error -f lavfi -i testsrc2=size=1920x1080:rate=30:duration=30 -vf "$T,format=yuv420p10le" -c:v libx265 -preset veryfast -b:v 8M -x265-params log-level=error hevc10-1080.mkv
chown -R '"$(id -u):$(id -g)"' /out
'
ls -la
ssh -o BatchMode=yes root@192.168.66.83 'mkdir -p /root/vdec/clips /root/vdec/kodi-home'
tar -cf - . | ssh -o BatchMode=yes root@192.168.66.83 'tar -C /root/vdec/clips -xf -'
echo "=== loading Kodi image on the NIO"
docker save kodi-rockchip-gbm:trixie-v4l2requests | ssh -o BatchMode=yes root@192.168.66.83 nerdctl load
ssh root@192.168.66.83 'ls -la /root/vdec/clips; nerdctl images | grep kodi'
