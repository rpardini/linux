#!/bin/bash
# blade3-kodi.sh: headless Kodi playback on the Blade3 (no display connected): per clip, time progress + decoder/renderer from the log.
B=root@192.168.66.145; H=http://192.168.66.145:8080/jsonrpc
rpc() { curl -s -m 10 -H 'Content-Type: application/json' -d "$1" $H; echo; }
P='{"jsonrpc":"2.0","id":1,"method":"Player.GetProperties","params":{"playerid":1,"properties":["time","speed"]}}'
t() { rpc "$P" | python3 -c "import sys,json; r=json.load(sys.stdin).get('result',{}); t=r.get('time',{}); print(f\"{t.get('minutes',0)*60+t.get('seconds',0)+t.get('milliseconds',0)/1000:.1f}s speed={r.get('speed')}\")" 2>/dev/null || echo none; }
for c in ${*:-h264-1080.mp4 hevc-1080.mkv vp9-1080.webm av1-1080.mkv h264-2160.mp4 hevc-2160.mkv vp9-2160.webm av1-2160.mkv hevc10-1080.mkv real/bbb-1080p24-h264.mov real/jf-hevc10-2160-40M.mp4 real/jf-av1-10-2160-40M.mp4}; do
	ssh $B 'nerdctl logs kodi 2>&1 | wc -l' > /tmp/claude-501/b3k.n
	rpc "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"Player.Open\",\"params\":{\"item\":{\"file\":\"/media/$c\"}}}" >/dev/null
	sleep 8; a=$(t); sleep 10; b=$(t)
	rpc '{"jsonrpc":"2.0","id":1,"method":"Player.Stop","params":{"playerid":1}}' >/dev/null; sleep 3
	n=$(cat /tmp/claude-501/b3k.n)
	info=$(ssh $B "nerdctl logs kodi 2>&1 | tail -n +$n | grep -oE 'using decoder [^,]*|Using codec: [^ ]*|creating v4l2request hwdevice|falling back to software[^,]*|Video decoder:? [^ ]*|CRenderer[A-Za-z]*::Configure|RendererDRMPRIME[A-Za-z]*|LinuxRendererGLES::Configure' | sort -u | tr '\n' ';'")
	echo "$c | $a -> $b | $info"
done
