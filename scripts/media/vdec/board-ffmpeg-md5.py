#!/usr/bin/env python3
"""FFmpeg v4l2request conformance on the NIO-12L: decode each fluster vector with
-hwaccel v4l2request, hwdownload (MM21 CPU detile), compare the raw output md5 with
fluster's reference (SW = matches FFmpeg software instead). Usage: board-ffmpeg-md5.py <suite-json> [max] [extra -vf prefix]
Runs over ssh in the vdec/ffmpeg-run container; prints one line per vector and a total."""
import json, os, subprocess, sys

BOARD = os.environ.get("BOARD", "root@192.168.66.83")
suite = json.load(open(sys.argv[1]))
limit = int(sys.argv[2]) if len(sys.argv) > 2 else 10**9
name = suite["name"]
run = ("nerdctl run --rm --net=host --privileged -v /dev:/dev -v /opt/ffmpeg-vdec:/opt/ffmpeg-vdec:ro "
       "-v /root/vdec/vectors:/vectors vdec/ffmpeg-run")
ok = bad = 0
skip = set(filter(None, os.environ.get("SKIP", "").split(",")))  # vectors known to hang a board
for tv in suite["test_vectors"][:limit]:
    if tv["name"] in skip:
        print(f"SKIP {tv['name']} (known to hang the board)", flush=True)
        continue
    src = f"/vectors/{name}/{tv['name']}/{tv['input_file']}"
    fmt = tv.get("output_format", "yuv420p")
    dl = "p010le" if "10" in fmt else "nv12"  # MT2110 detiles to P010, MM21 to NV12
    cmd = (f"{run} sh -c \"ffmpeg -nostdin -hide_banner -loglevel error -hwaccel v4l2request "
           f"-hwaccel_output_format drm_prime -i '{src}' -vf hwdownload,format={dl},format={fmt} "
           f"-f rawvideo - | md5sum\"")
    t0 = subprocess.run(["ssh", BOARD, "date +%s"], capture_output=True, text=True).stdout.strip()
    p = subprocess.run(["ssh", "-o", "BatchMode=yes", BOARD, cmd], capture_output=True, text=True, timeout=300)
    if p.returncode == 255 or "closed by remote host" in p.stderr:
        print(f"ABORT {tv['name']}: board unreachable (crash?) - check UART", flush=True)
        sys.exit(2)
    got = p.stdout.split()[0] if p.stdout.strip() else "-"
    res = "OK" if got == tv["result"] else "KO"
    if res == "KO" and got != "-":
        # fluster's reference sometimes disagrees with FFmpeg itself; hw == FFmpeg sw is a pass for us
        sw = (f"{run} sh -c \"ffmpeg -nostdin -hide_banner -loglevel error -i '{src}' "
              f"-pix_fmt {fmt} -f rawvideo - | md5sum\"")
        q = subprocess.run(["ssh", "-o", "BatchMode=yes", BOARD, sw], capture_output=True, text=True, timeout=300)
        if q.stdout.split() and q.stdout.split()[0] == got:
            res = "SW"
    faults = subprocess.run(["ssh", BOARD, f"journalctl -k --since @{t0} --no-pager | grep -c 'iommu.*fault'"],
                            capture_output=True, text=True).stdout.strip()
    ok += res in ("OK", "SW")
    bad += res not in ("OK", "SW")
    err = p.stderr.strip().splitlines()[-1][:120] if p.stderr.strip() else ""
    print(f"{res} {tv['name']}{' IOMMU-FAULTS=' + faults if faults not in ('', '0') else ''} {err}", flush=True)
print(f"TOTAL {name}: {ok}/{ok + bad}")
