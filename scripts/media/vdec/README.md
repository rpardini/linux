# MediaTek vdec / Kodi test scripts (`le-media-kodi-vdec`)

Board-side test harness for the NIO-12L (MT8395) and the Blade3 (RK3588) work in `notes/media/le-media-kodi-vdec.md`.

The scripts are versioned here and symlinked from `/opt/linuxdev/le-media-kodi-vdec/` (same names, plus `kodi-home` and
`tools/h264ctl-dump.c`, `tools/norm.py`). They resolve paths with `dirname "$0"`, so **run them through the symlinks**
in `le-media-kodi-vdec/` (they expect `fluster/`, `fluster-vectors/`, `clips/`, `results/`, `out/` and `tools/` there).
To recreate the links on a new host: `for f in scripts/media/vdec/*.sh scripts/media/vdec/*.py scripts/media/vdec/kodi-home; do ln -s "$PWD/$f" ../le-media-kodi-vdec/; done`.

| Script | What |
|---|---|
| `board-ffmpeg-md5.py <suite.json> [max]` | FFmpeg v4l2-request conformance (hwdownload md5 vs fluster; `SW` = matches FFmpeg software); `BOARD=`, `SKIP=` |
| `board-fluster-gst.sh` | GStreamer v4l2codecs fluster runs on the board (`BOARD=`) |
| `board-watch.sh <rc> [min]` | watcher: checks the board every 8 min (unreachable, rebooted, D-state) until the run's RC file appears (`BOARD=`) |
| `board-retest-k*.sh`, `board-h264-and-rest.sh`, `board-ffmpeg-all.sh`, `board-av1-k3.sh` | conformance batches, kept as run |
| `board-mdp3-soak.sh` | MDP3 m2m soak (the K29 test) |
| `make-clips.sh` | generated testsrc2 clips (1080p/4K, H.264/HEVC/VP9/AV1, one 10-bit), copied to the NIO |
| `kodi-test.sh <clip> <1=EGL\|0=plane> [s]` | one Kodi run on the NIO: seeded `kodi-home`, JSON-RPC play, 60-frame Blade3 HDMI-RX capture, logs |
| `kodi-matrix.sh [clips]` | `kodi-test.sh` per clip on both paths |
| `kodi-shots.sh <clip> <r> <prefix>` | PR screenshots (System Information, player process info, OSD) into `notes/media/img/`; `SYSINFO`, `OSD`, `PLAIN`, `SEEK` |
| `kodi-realuse.sh <clip> <r> [min]` | refresh-rate switching, 5.1, seeks, long play |
| `blade3-setup.sh`, `blade3-baseline*.sh`, `blade3-kodi.sh` | Rockchip (Blade3) baseline: setup, conformance, headless Kodi (crashes without a display) |
| `kodi-home/` | Kodi seed (`guisettings.xml`: web server, DRM PRIME, 1080p60, `ALSA:default`; `asound.conf`: default = NIO HDMI `hw:0,5`) |
| `tools/h264ctl-dump.c` | `LD_PRELOAD` V4L2 dumper (H.264/AV1 controls, S_FMT/REQBUFS/STREAM/QBUF); build in a trixie container with backports `linux-libc-dev` |
| `tools/norm.py` | normalises H.264 dumps for diffing FFmpeg vs GStreamer |
