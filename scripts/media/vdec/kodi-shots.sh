#!/bin/bash
# kodi-shots.sh <clip> <renderer> <prefix>: PR screenshots (full-res PNG via the Blade3 HDMI-RX) into linuxdev-status/notes/media/img/
set -u
CLIP=$1; R=$2; PFX=$3
NIO=root@192.168.66.83; BLADE=root@192.168.66.145; IMG=kodi-rockchip-gbm:trixie-v4l2requests
HERE=$(cd "$(dirname "$0")" && pwd); OUT=/opt/linuxdev/linuxdev-status/notes/media/img; mkdir -p "$OUT"
rpc() { curl -s -m 10 -H 'Content-Type: application/json' -d "$1" http://192.168.66.83:8080/jsonrpc; echo; }
act() { rpc "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"Input.ExecuteAction\",\"params\":{\"action\":\"$1\"}}" >/dev/null; }
win() { rpc "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"GUI.ActivateWindow\",\"params\":{\"window\":\"$1\"}}" >/dev/null; }
shot() { timeout 60 ssh -o BatchMode=yes $BLADE 'd=/dev/video3; v4l2-ctl -d $d --set-dv-bt-timings query >/dev/null
  read W H < <(v4l2-ctl -d $d --get-fmt-video | awk "/Width\/Height/ {split(\$3,a,\"/\"); print a[1], a[2]}")
  v4l2-ctl -d $d --stream-mmap=4 --stream-skip=3 --stream-count=1 --stream-to=/tmp/s.raw &&
  ffmpeg -v error -y -f rawvideo -pix_fmt bgr24 -s ${W}x${H} -i /tmp/s.raw -frames:v 1 /tmp/s.png' &&
  scp -q $BLADE:/tmp/s.png "$OUT/$PFX-$1.png" && echo "shot $OUT/$PFX-$1.png"; }
tar -C "$HERE/kodi-home" -cf - userdata | ssh $NIO "nerdctl rm -f kodi >/dev/null 2>&1; rm -rf /root/vdec/kodi-home; mkdir -p /root/vdec/kodi-home && tar -C /root/vdec/kodi-home -xf - && sed -i 's|\"videoplayer.useprimerenderer\">[01]<|\"videoplayer.useprimerenderer\">$R<|' /root/vdec/kodi-home/userdata/guisettings.xml"
ssh $NIO "nerdctl run -d --name kodi --privileged --net=host -v /dev:/dev -v /run:/run -v /root/vdec/kodi-home:/root/.kodi -v /root/vdec/clips:/media:ro -v /root/vdec/asound.conf:/etc/asound.conf:ro $IMG kodi --logging=console --windowing=gbm --audio-backend=alsa" >/dev/null
for i in $(seq 1 45); do rpc '{"jsonrpc":"2.0","id":1,"method":"JSONRPC.Ping"}' | grep -q pong && break; sleep 2; done
W='{"jsonrpc":"2.0","id":1,"method":"GUI.GetProperties","params":{"properties":["currentwindow"]}}'
sleep 5; for i in $(seq 1 20); do rpc "$W" | grep -q '"id":10000' && break; rpc '{"jsonrpc":"2.0","id":1,"method":"Input.Back"}' >/dev/null; sleep 2; done
if [ "${SYSINFO:-1}" = 1 ]; then
	win systeminfo; sleep 4; shot sysinfo-summary
	for p in 1 2 3 4 5 6; do act down; sleep 2; shot sysinfo-$p; done
	win home; sleep 2
fi
rpc "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"Player.Open\",\"params\":{\"item\":{\"file\":\"/media/$CLIP\"}}}" >/dev/null; sleep 8
[ -n "${SEEK:-}" ] && { rpc "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"Player.Seek\",\"params\":{\"playerid\":1,\"value\":{\"percentage\":$SEEK}}}" >/dev/null; sleep 6; }
[ "${PLAIN:-0}" = 1 ] && shot plain
act playerprocessinfo; sleep 3; shot playerprocessinfo; act playerprocessinfo; sleep 1
[ "${OSD:-1}" = 1 ] && { act info; sleep 3; shot info; }
rpc '{"jsonrpc":"2.0","id":1,"method":"Application.Quit"}' >/dev/null; sleep 5; ssh $NIO 'nerdctl rm -f kodi >/dev/null 2>&1'
