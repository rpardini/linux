#!/bin/bash
# kodi-test.sh <clip> <renderer: 1=EGL 0=DirectToPlane> [play-seconds]
# Fresh Kodi container on the NIO (seeded kodi-home), plays /media/<clip> via JSON-RPC, grabs 60 frames of the
# NIO's HDMI on the Blade3 HDMI-RX, collects the Kodi log + kernel log. Results in results/kodi-<clip>-r<renderer>/.
set -u
CLIP=$1; R=$2; PLAY=${3:-15}
NIO=root@192.168.66.83; BLADE=root@192.168.66.145; IMG=kodi-rockchip-gbm:trixie-v4l2requests
HERE=$(cd "$(dirname "$0")" && pwd); OUT=$HERE/results/kodi-${CLIP%.*}-r$R; rm -rf "${OUT:?}"; mkdir -p "$OUT"
ssh_nio() { timeout 120 ssh -o BatchMode=yes -o ConnectTimeout=8 $NIO "$@"; }
rpc() { curl -s -m 10 -H 'Content-Type: application/json' -d "$1" http://192.168.66.83:8080/jsonrpc; echo; }
log() { echo "$(date +%T) $*" | tee -a "$OUT/summary.txt"; }

# fresh kodi-home from the seed, renderer set in guisettings
tar -C "$HERE/kodi-home" -cf - userdata | ssh_nio "nerdctl rm -f kodi >/dev/null 2>&1; rm -rf /root/vdec/kodi-home; mkdir -p /root/vdec/kodi-home && tar -C /root/vdec/kodi-home -xf - && sed -i 's|\"videoplayer.useprimerenderer\">[01]<|\"videoplayer.useprimerenderer\">$R<|' /root/vdec/kodi-home/userdata/guisettings.xml"
T0=$(ssh_nio 'date +%s')
ssh_nio "nerdctl run -d --name kodi --privileged --net=host -v /dev:/dev -v /run:/run -v /root/vdec/kodi-home:/root/.kodi -v /root/vdec/clips:/media:ro -v /root/vdec/asound.conf:/etc/asound.conf:ro $IMG kodi --logging=console --windowing=gbm --audio-backend=alsa" >/dev/null || { log "FAIL nerdctl run"; exit 1; }
for i in $(seq 1 45); do rpc '{"jsonrpc":"2.0","id":1,"method":"JSONRPC.Ping"}' | grep -q pong && break; sleep 2; done
rpc '{"jsonrpc":"2.0","id":1,"method":"JSONRPC.Ping"}' | grep -q pong || { log "FAIL no JSON-RPC after 90 s"; ssh_nio 'nerdctl logs kodi 2>&1' > "$OUT/kodi.log"; exit 1; }
log "kodi up; renderer=$(rpc '{"jsonrpc":"2.0","id":1,"method":"Settings.GetSettingValue","params":{"setting":"videoplayer.useprimerenderer"}}')"
# first start queues several "Disabled add-ons" Yes/No dialogs (RTMP, IPTV Simple, ...): answer each with Back
W='{"jsonrpc":"2.0","id":1,"method":"GUI.GetProperties","params":{"properties":["currentwindow"]}}'
sleep 5; for i in $(seq 1 20); do rpc "$W" | grep -q '"id":10000' && break; rpc '{"jsonrpc":"2.0","id":1,"method":"Input.Back"}' >/dev/null; sleep 2; done
log "window before play: $(rpc "$W" | grep -o '"label":"[^"]*"')"
rpc '{"jsonrpc":"2.0","id":1,"method":"GUI.ActivateWindow","params":{"window":"home"}}' >/dev/null; sleep 4
log "open $CLIP: $(rpc "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"Player.Open\",\"params\":{\"item\":{\"file\":\"/media/$CLIP\"}}}")"
sleep "$PLAY"
P='{"jsonrpc":"2.0","id":1,"method":"Player.GetProperties","params":{"playerid":1,"properties":["time","speed","percentage"]}}'
log "props A: $(rpc "$P")"
# 60 frames on the Blade3 HDMI-RX; per-frame md5 tells whether the picture moves
timeout 60 ssh -o BatchMode=yes $BLADE 'set -e; d=/dev/video3; v4l2-ctl -d $d --set-dv-bt-timings query >/dev/null
  read W H < <(v4l2-ctl -d $d --get-fmt-video | awk "/Width\/Height/ {split(\$3,a,\"/\"); print a[1], a[2]}")
  echo "capture ${W}x${H}"; rm -rf /tmp/kc; mkdir /tmp/kc
  v4l2-ctl -d $d --stream-mmap=4 --stream-skip=3 --stream-count=60 --stream-to=/tmp/kc/f.raw
  ffmpeg -v error -f rawvideo -pix_fmt bgr24 -s ${W}x${H} -i /tmp/kc/f.raw -f framemd5 - | grep -v "^#" | awk -F, "{print \$6}" | sort -u | wc -l | sed "s/^/distinct frames: /"
  ffmpeg -v error -f rawvideo -pix_fmt bgr24 -s ${W}x${H} -i /tmp/kc/f.raw -vf "select=eq(n\,0)+eq(n\,30)+eq(n\,59),scale=960:-2" -vsync 0 /tmp/kc/f%d.png
  rm /tmp/kc/f.raw' > "$OUT/capture.txt" 2>&1
log "capture: $(tr '\n' ' ' < "$OUT/capture.txt")"
scp -q "$BLADE:/tmp/kc/*.png" "$OUT/" 2>/dev/null
log "props B: $(rpc "$P")"
rpc '{"jsonrpc":"2.0","id":1,"method":"Player.Stop","params":{"playerid":1}}' >/dev/null; sleep 2
rpc '{"jsonrpc":"2.0","id":1,"method":"Application.Quit"}' >/dev/null; sleep 5
ssh_nio 'nerdctl logs kodi 2>&1' > "$OUT/kodi.log"
ssh_nio "nerdctl rm -f kodi >/dev/null 2>&1; journalctl -k --since @$T0 --no-pager" > "$OUT/dmesg.txt"
log "iommu faults: $(grep -c 'iommu.*fault' "$OUT/dmesg.txt"); kodi log: $(grep -ciE 'error' "$OUT/kodi.log") error lines"
grep -E 'CDVDVideoCodecDRMPRIME::Open|CRendererDRMPRIME|RendererDRMPRIMEGLES|VideoLayerBridge|scale_v4l2m2m|hw_device|EGL.*(modifier|import)|ENOBUFS|ETIMEDOUT|Creating video codec' "$OUT/kodi.log" | head -40 > "$OUT/kodi-key.txt"
log "done -> $OUT"
