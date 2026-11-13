#!/bin/bash
# kodi-realuse.sh <clip> <renderer> [minutes]: refresh-rate switching, 5.1 audio, seeks and a long play; results in results/realuse-*
set -u
CLIP=$1; R=$2; MIN=${3:-3}
NIO=root@192.168.66.83; BLADE=root@192.168.66.145; IMG=kodi-rockchip-gbm:trixie-v4l2requests
HERE=$(cd "$(dirname "$0")" && pwd); OUT=$HERE/results/realuse-$(basename "${CLIP%.*}")-r$R; rm -rf "${OUT:?}"; mkdir -p "$OUT"
rpc() { curl -s -m 10 -H 'Content-Type: application/json' -d "$1" http://192.168.66.83:8080/jsonrpc; echo; }
log() { echo "$(date +%T) $*" | tee -a "$OUT/summary.txt"; }
P='{"jsonrpc":"2.0","id":1,"method":"Player.GetProperties","params":{"playerid":1,"properties":["time","speed","percentage"]}}'
timings() { ssh -o BatchMode=yes $BLADE 'v4l2-ctl -d /dev/video3 --query-dv-timings | grep -E "Active width|Active height|Pixelclock"' | tr -s ' \n' ' '; }
pcm() { ssh $NIO 'f=/proc/asound/card0/pcm5p/sub0; head -1 $f/status; grep -E "^(format|channels|rate)" $f/hw_params' | tr '\n' ' '; }
# seed: refresh switching on start/stop (2), 5.1 output (8)
tar -C "$HERE/kodi-home" -cf - userdata | ssh $NIO "nerdctl rm -f kodi >/dev/null 2>&1; rm -rf /root/vdec/kodi-home; mkdir -p /root/vdec/kodi-home && tar -C /root/vdec/kodi-home -xf - && cd /root/vdec/kodi-home/userdata && sed -i 's|\"videoplayer.useprimerenderer\">[01]<|\"videoplayer.useprimerenderer\">$R<|; s|\"videoplayer.adjustrefreshrate\">0<|\"videoplayer.adjustrefreshrate\">2<|; s|\"audiooutput.channels\">1<|\"audiooutput.channels\">8<|' guisettings.xml"
T0=$(ssh $NIO 'date +%s')
ssh $NIO "nerdctl run -d --name kodi --privileged --net=host -v /dev:/dev -v /run:/run -v /root/vdec/kodi-home:/root/.kodi -v /root/vdec/clips:/media:ro -v /root/vdec/asound.conf:/etc/asound.conf:ro $IMG kodi --logging=console --windowing=gbm --audio-backend=alsa" >/dev/null
for i in $(seq 1 45); do rpc '{"jsonrpc":"2.0","id":1,"method":"JSONRPC.Ping"}' | grep -q pong && break; sleep 2; done
W='{"jsonrpc":"2.0","id":1,"method":"GUI.GetProperties","params":{"properties":["currentwindow"]}}'
sleep 5; for i in $(seq 1 20); do rpc "$W" | grep -q '"id":10000' && break; rpc '{"jsonrpc":"2.0","id":1,"method":"Input.Back"}' >/dev/null; sleep 2; done
log "GUI mode: $(timings)"
log "open: $(rpc "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"Player.Open\",\"params\":{\"item\":{\"file\":\"/media/$CLIP\"}}}")"
sleep 12; log "playing mode: $(timings)"; log "pcm: $(pcm)"; log "t: $(rpc "$P" | grep -o '"time":{[^}]*}')"
for pct in 25 60 90 10; do
	rpc "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"Player.Seek\",\"params\":{\"playerid\":1,\"value\":{\"percentage\":$pct}}}" >/dev/null; sleep 6
	a=$(rpc "$P" | grep -o '"time":{[^}]*}'); sleep 5; b=$(rpc "$P" | grep -o '"time":{[^}]*}'); log "seek $pct%: $a -> 5s later $b"
done
log "long play ${MIN} min"; for m in $(seq 1 "$MIN"); do sleep 60; log "  +${m}m $(rpc "$P" | grep -o '"time":{[^}]*}') $(pcm | cut -c1-40)"; done
rpc '{"jsonrpc":"2.0","id":1,"method":"Player.Stop","params":{"playerid":1}}' >/dev/null; sleep 5; log "after stop: $(timings)"
rpc '{"jsonrpc":"2.0","id":1,"method":"Application.Quit"}' >/dev/null; sleep 5
ssh $NIO 'nerdctl logs kodi 2>&1' > "$OUT/kodi.log"; ssh $NIO "nerdctl rm -f kodi >/dev/null 2>&1; journalctl -k --since @$T0 --no-pager" > "$OUT/dmesg.txt"
log "iommu faults: $(grep -c 'iommu.*fault' "$OUT/dmesg.txt"); skipped/dropped lines: $(grep -ciE 'drop|skip' "$OUT/kodi.log")"
