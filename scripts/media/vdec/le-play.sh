#!/bin/bash
# le-play.sh <clip-file-name> [seconds]: play one clip in Kodi on the LE NIO, collect state, stop.
set -u
CLIP="$1"; SECS="${2:-20}"
H=192.168.66.83
DIR=/var/media/root/root/vdec/clips/real
O="-o ConnectTimeout=5 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=error"
J(){ curl -s -m 10 -u kodi:kodi -H "Content-Type: application/json" -d "$1" http://$H:8080/jsonrpc; echo; }

# mark log/dmesg positions
read -r LOGL DM < <(ssh $O root@$H 'echo $(wc -l < /storage/.kodi/temp/kodi.log) $(dmesg | wc -l)')
echo "== $CLIP (play ${SECS}s)"
J "{\"jsonrpc\":\"2.0\",\"method\":\"Player.Open\",\"params\":{\"item\":{\"file\":\"$DIR/$CLIP\"}},\"id\":1}"
sleep "$SECS"
J '{"jsonrpc":"2.0","method":"Player.GetProperties","params":{"playerid":1,"properties":["time","totaltime","speed","currentvideostream","currentaudiostream"]},"id":2}' \
  | python3 -c 'import sys,json; r=json.load(sys.stdin).get("result",{}); v=r.get("currentvideostream",{}); a=r.get("currentaudiostream",{}); t=r.get("time",{}); print("player: speed=%s time=%02d:%02d video=%s %sx%s audio=%s %sch" % (r.get("speed"), t.get("minutes",0), t.get("seconds",0), v.get("codec"), v.get("width"), v.get("height"), a.get("codec"), a.get("channels")))' 2>/dev/null || echo "player: (no player / error)"
ssh $O root@$H "
tail -n +$((LOGL+1)) /storage/.kodi/temp/kodi.log | grep -aE 'DRMPRIME|PRIME|Creating video codec|CDVDVideoCodec|software|scale_v4l2m2m|v4l2|hwaccel|VideoPlayer::OpenStream|Display resolution|SetVideoMode|ENOBUFS|ERROR|error|fail|Opened device' | grep -vE 'Numerical result' | cut -c25-210 | awk '!seen[\$0]++' | head -25
echo '-- dmesg'
dmesg | tail -n +$((DM+1)) | grep -vE 'irq 116|nobody cared' | tail -12
"
J '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":3}' >/dev/null
