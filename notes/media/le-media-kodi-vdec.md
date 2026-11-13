# MediaTek Genio (MT8195/MT8395) HW video decode → Kodi (Armbian, then LibreELEC)

Started 2026-11-12. Board: Radxa NIO-12L (Genio 1200 / MT8395, Mali-G57).
- Goal: HW decode in Kodi (GBM/GLES, DRM PRIME) via the kodi-rockchip-deb container/deb on Armbian kernels, then port to LibreELEC.
- Plan and next steps: [le-media-kodi-vdec-plan.md](le-media-kodi-vdec-plan.md). Origin: [libreelec-pr-10891.md](libreelec-pr-10891.md).
- Kernel topics in `STATUS.md`:
  - K26: vcodec `cap_to_disp` NULL guard
  - K27: MDP3 MT2110 input (research)
  - K28: vb2 dma-contig cache sync
  - K29: mtk-mdp3 GCE pm_runtime, **the MDP3 hang fix**
- Userspace work has no IDs and is tracked here.

## Status (2026-11-13 ~00:30)

- **Board**: Armbian genio edge 7.3.4 build #3 with patches 3200 (K29), 3201 (K26) and 3202 (K28), plus `scp.img`. Decoder and MDP3 work.
- **Decoding (hardware, through FFmpeg and GStreamer)**: H.264, HEVC, VP8, VP9 and AV1 decode correctly on the hardware, apart from the open FFmpeg issues below. Conformance tables are under "Results".
- **"One frame then hang" (DirectToPlane): fixed.** Root cause was a mainline regression: the MDP3 part (3/3) of the GCE pm_runtime series never merged while 1/3 did (v6.18). That's K29. MDP3 now converts 1080p at about 210 fps (FFmpeg `scale_v4l2m2m`) and GStreamer `v4l2convert` works too.
- **FFmpeg on Debian trixie decoded nothing in hardware**: libdrm 2.4.124 lacks the MTK modifiers, which compiled MM21 out. Fixed in FFmpeg and Kodi with `#ifndef` fallbacks.
- **Open issues (FFmpeg vs. the MTK driver)**:
  - VP8 `segmentation-1425`/`1436` decode wrong (1425 also IOMMU-faults the decoder)
  - AV1 tile and SVC vectors IOMMU-fault the decoder; before K26 one panicked the kernel (with K26: no panic; lead = tiny 16–17 byte OUTPUT buffers, EBUSY)
  - HEVC `CONFWIN_A` mismatch (H.264 `CAWP5`/`CVWP5`/`MR1_BT_A` fixed by the pic_num fix)
  - GStreamer passes all of these, so FFmpeg's controls differ from what the driver/firmware expects.
- **H.264 B-frame corruption in FFmpeg: fixed** (2026-11-12, 2 FFmpeg commits). It showed up with real libx264 clips. FFmpeg H.264 conformance is now 100/135 (GStreamer 95).
- **Kodi on the board: both paths work** (EGL and DirectToPlane via MDP3 + plane, UYVY LINEAR): hardware decode, 1080p fullscreen, real time, no faults or hangs. Kodi matrix with the fixed FFmpeg (image rebuilt with kodi-rockchip-deb `6a72109`): **16/16 runs on 8-bit clips OK** (H.264/HEVC/VP9/AV1 × 1080p/4K × EGL/plane). 10-bit HEVC now plays on both paths through the software fallback (3 Kodi fixes, below).
- **2026-11-13 summary**: Kodi plays 8-bit H.264/HEVC/VP9/AV1 up to 4K60 (150 Mbps) in HW on both paths. 10-bit = HW decode + CPU MT2110 detile → P010 (4K60 HEVC 10-bit/HDR10/DV8.1 at full rate, AV1 10-bit 4K at 44/60). Audio over HDMI works (SOF fw). Refresh switching, seeking and long play OK. FFmpeg fixes: H.264 pic_num/marking, AV1 tile MI units, MT2110 detile. Conformance: H.264 100/135, HEVC 142/147, AV1 201/242, Chromium AV1 8-bit 10/13, 10-bit 22/23. K27 (MDP3 10-bit) parked: the SCP fw can't do it.
- **Branches** (nothing pushed):
  - FFmpeg `mediatek-mm21-armsoc-9.0.2` (incl. the H.264 fixes `03849804f8`, `34de8f4aa7`)
  - Kodi `mediatek-piers` (8 MTK commits incl. the 10-bit fallback `7e9b59cb0f`, `ee3a4f3339`, `1b94bc79cd`)
  - kodi-rockchip-deb `mediatek-genio` (`941ec9b`; image `kodi-rockchip-gbm:trixie-v4l2requests` loaded on the NIO)
  - LibreELEC `mediatek-genio` (`424ce54491`; patches refreshed; kernel still 7.2)
  - armbian-build `extensions` (`8c93af5e2`)

## Usability assessment (2026-11-12): how usable is it for regular Kodi use?

First pass: generated testsrc2 clips (30 fps, no audio). **Updated with real clips (2026-11-12 ~22:15)**: the Jellyfin test videos (60 fps, 3–150 Mbps, SDR/HDR10/DV, 1080p–8K, no audio) and Big Buck Bunny 1080p24 (AAC 5.1). Table in "Real clips" below.

**Works (verified)**
- 8-bit H.264, HEVC, VP9 and AV1, 1080p and 4K: hardware decode, real time, correct picture on both render paths (EGL and DirectToPlane/MDP3). No IOMMU faults, no hangs (MDP3 stable with K29).
- Real libx264 streams (B-frames) are bit-exact since the FFmpeg H.264 fix.
- FFmpeg conformance: H.264 100/135, HEVC 132/147, VP9 204/305. Most failures are features real movies don't use (interlaced/PAFF/MBAFF, Baseline FMO/ASO, Extended SP, VP9 resize vectors).
- 10-bit plays, through the CPU (software fallback).

**Risks for real movies (in order of impact)**
1. **Audio: works since 2026-11-12 ~21:45** (was: no ALSA card at all). See "Audio" below. Not yet heard by a human, since the Blade3's mainline HDMI-RX has no audio capture; the PCM runs at the right rate. Only 2.0 tested so far (multichannel and passthrough not yet).
2. **10-bit: hardware decode + CPU detile to P010 since 2026-11-12 ~23:15** (was: CPU decode). 4K60 HEVC 10-bit, HDR10 and DV 8.1 at 60/60; AV1 10-bit 4K60 at 44/60. Old text: Most 4K/HDR content is 10-bit (HEVC Main10, VP9 Profile 2, much AV1). The hardware decodes it, but neither Mesa/Panfrost nor MDP3 can read the MTK 10-bit tiled output (MT2110; MDP3 = K27; or an MT2110 detile). 1080p 10-bit probably keeps up on the CPU; 4K 10-bit very likely doesn't.
3. **No HDR.** Kodi shows "HDR passthrough: off" and the display has no HDR types, so HDR content would look washed out.
4. **Interlaced content** (TV/DVB recordings, some DVD rips): no hardware deinterlacer, and interlaced H.264 fails conformance (FFmpeg and GStreamer alike).
5. **AV1 tiles/SVC**: the conformance tile vectors still IOMMU-fault the decoder. The 4K libsvtav1 test clip played fine, but some real high-resolution or high-bitrate encodes might hit this.
6. **Not tested**: 23.976 fps and refresh-rate switching (disabled in the tests), seeking, long playback, subtitles, high-bitrate real files, real HDMI-CEC remote use with Kodi.
7. **Minor**: EGL vs. plane colour rendition differs slightly (range/matrix); faint mottling in the grey box on VP9/AV1 4K; display-driver kernel warnings on Kodi start/stop (`vblank wait timed out`, `Runtime PM usage count underflow` on `mdp-rdma`/`ethdr`); about 240 harmless HEVC reference errors after the mid-GOP 10-bit fallback, which also seems to skip ahead.

**Real-clip measurements**:
- **8-bit HW is solid**: AVC 1080p/4K up to **150 Mbps 4K60** and HEVC 8-bit 1080p 10/30 Mbps run at full 60 fps on both paths. BBB 1080p24 plays with 5.1 AAC to HDMI.
- **10-bit through the CPU**: HEVC 10-bit 1080p60 at full rate; 4K60 at about half rate (29–32/60 distinct; HDR10 clip 48–57). DV 8.1 plays as its HDR10 base layer, at half rate too.
- **HDR**: washed out (`HDR passthrough: off`, `tonemap method: off`, display reports no HDR static metadata). That's expected: the Blade3 HDMI-RX is the sink.
- **AV1 10-bit crashed Kodi** (segfault after the failed software reopen: the DRMPRIME software path needs a DR1 decoder, and libdav1d isn't one). Fixed with a VideoPlayer software codec switch (verified: libdav1d, 1080p60 48/60, 4K60 17/60, no crash).
- **8K** (AVC 4320p) isn't supported by the HW (`hwaccel initialisation returned error`); a software slideshow (13/60), no crash.

**Verdict**: for an 8-bit H.264/HEVC/VP9/AV1 library over HDMI it should already be pleasant to use, if audio works. For a 4K HDR library it isn't there yet (10-bit display path, HDR).

**Real-use check done (BBB)**: refresh switching, seeking, long play and audio work; multichannel is unverified (the sink has no audio EDID).

**Next to prove it**: a real-movie test: a 1080p H.264 file with 5.1 audio, a 4K HEVC 10-bit HDR file, and a VP9/AV1 web-style file. Enable refresh-rate switching, seek and play a few minutes. Before that, an ALSA check on the board (`aplay -l` on the host and in the container).

## Layout (`/opt/linuxdev/le-media-kodi-vdec/`)

Full clones made by `scripts/10-vm-clone-main.sh <repo>`. The remotes are in `remotes.tsv`; the prefix is the dir name.

| Dir | Remotes | Branches |
|---|---|---|
| `kodi-rockchip-deb` | `kodideb-armsurvivors` | **`mediatek-genio`** (work); `main` |
| `ffmpeg` | `ffmpeg-rpardini`, `ffmpeg-upstream`, `ffmpeg-kwiboo`, `ffmpeg-chewitt`, `ffmpeg-rpi` (jc-kynesim) | **`mediatek-mm21-armsoc-9.0.2`** (work, off chewitt `armsoc-9.0.2`); `backup/…-pre-trailers`; old `mediatek-mm21-v4l2requests-opus` |
| `libreelec` | `le-rpardini`, `le-upstream`, `le-chewitt` | **`mediatek-genio`** (work, off `le-upstream/master`); `mediatek-genio-wip` (PR head) |
| `kodi` | `kodi-rpardini`, `kodi-upstream` (xbmc) | **`mediatek-piers`** (work, off `kodi-upstream/Piers`); `backup/mediatek-piers-pre-msg`; old `with-librelec-patches-and-mediatek-opus` |
| `gstreamer` | `gst-upstream` (monorepo) | detached `main` |
| `mesa` | `mesa-upstream` | detached `main` |
| `fluster` | `fluster-upstream` | detached `master` |
| `linux-firmware` | `linuxfw-upstream`, `linuxfw-armbian` | detached `main` |

Also in `le-media-kodi-vdec/`:
- `out/`: `ffmpeg-build` (out-of-tree, incremental), `ffmpeg-vdec` (install tree), `ccache`
- `fluster-vectors/`
- `results/` (gst-*.md, ffmpeg-*.txt)
- board test scripts: `board-fluster-gst.sh`, `board-ffmpeg-md5.py`, `board-ffmpeg-all.sh`, `board-h264-and-rest.sh`

The FFmpeg working tree is clean again: the cache-hint test hack was reverted on 2026-11-12 once K28 was on the board, and the shipped build is the committed branch tip.

- **Kernel:** `kernel/` with worktrees `kernel-<slug>`. The useful remotes are:
  - `kernel-collabora-mediatek` (fetched 2026-11-12)
  - `kernel-mediatek-aiot` (vendor `mtk-v6.6`, worktree `kernel-genio-mtk`)
- K28 has a worktree at `kernel-vb2-dc-cache`.
- **Armbian:** `armbian-build`, branch `extensions`.
  - Genio edge = 7.3: `patch/kernel/archive/genio-7.3/` (3000 DT, 3100 CEC, **3200 media**).
  - Config `config/kernel/linux-genio-edge.config` (`VIDEO_MEDIATEK_VCODEC=y`, `MDP3=y`, `MTK_SCP=y`, `DRM_PANFROST=y`, `CEC_MTK=m`; all built in).
  - Kernel build: `PREFER_DOCKER=no ./compile.sh rpardini-generic kernel BOARD=radxa-nio-12l BRANCH=edge` (tmux window `radxa-nio-12l-edge`, about 1.5 min with ccache). The debs land in `output/debs/linux-{image,dtb}-edge-genio_*`.
  - 3200 and 3202 are flagged `needs_rebase` against 7.3.4; they apply with an offset. Refresh them sometime.

## How it connects

```
SCP firmware (mediatek/mt8195/scp.img) ─┐
mtk-vcodec-dec (stateless, LAT+core) ───┴→ CAPTURE MM21 (8-bit) / MT2110T|R (10-bit), 2 non-contiguous planes
  └→ FFmpeg v4l2request hwaccel (hwcontext_v4l2request: DRM PRIME, 2 objects, MTK modifier)
       ├→ Kodi EGL path: eglCreateImage(NV12 + DRM_FORMAT_MOD_MTK_16L_32S_TILE) → panfrost compute detile → GLES (external OES)
       └→ Kodi DirectToPlane: MDP3 m2m (vf_scale_v4l2m2m; GCE1 mailbox; needs K29) MM21 → UYVY/YUYV at dest size → KMS plane (LINEAR only, no scaling)
Packaging: kodi-rockchip-deb (Docker; v4l2requests flavor; container run via nerdctl on the board) → later LibreELEC project Mediatek/Genio
```

## Decisions

- **Board**: test on the current NIO-12L CaptainOS node (CAPI checks paused). The CEC session (K23) is done; the board is ours.
  - Kodi runs as a nerdctl container. FFmpeg CLI and fluster run in trixie containers (`--net=host --privileged -v /dev:/dev`). The host gets `scp.img` and our kernel.
  - **Ask the user before anything that might hang or crash the board.** Recovery means a long power-off (UART + power at the user's desk). Kernel installs and reboots also need the user's OK. Kernel installs were OK'd for the K29 test kernel.
- **FFmpeg**: base `ffmpeg-chewitt/armsoc-9.0.2`. Native build in a trixie container on this VM (`scripts/50-media-ffmpeg-build.sh --ship`).
- **Mesa**: trixie-backports 26.1.6 (`src:mesa` pin) in the Kodi container. Confirmed in the image.
- **kodi-rockchip-deb**: MediaTek goes into the existing `v4l2requests` flavor; FFmpeg patches are regenerated from our branch (n9.0.2..branch, 44 patches). Kodi base is `Piers`.
- **Stale cache readback**: fix it in the kernel (K28), not in FFmpeg.
- **IDs**: kernel only (K26–K29).
- **LibreELEC**: new branch off `le-upstream/master`.
- **Trailers**: reworked commits drop `Co-Authored-By`/`Claude-Session` and get `Assisted-by: Claude:claude-opus-5-5`. No push and nothing to lists without the user's OK.
- **Armbian patch names**: numbered series, `3200-…` for media.

## Board state

- `root@192.168.66.83`, CaptainOS (CAPT k8s node image, Debian trixie), Armbian `linux-image-edge-genio` 7.3.4, **build #3** (2026-11-12 15:17 UTC, with 3200/3201/3202).
  - `/boot/extlinux/extlinux.conf` pins the kernel version (`7.3.4-edge-genio`). Fix it after any kernel `dpkg -i` that changes the version, before rebooting.
- Video devices: `video0` jpeg-dec, `video1` jpeg-enc, `video2` vcodec-enc, `video3` vcodec-dec, `video4` mdp3 m2m; `media0`. HDMI-A-1 connected.
- `scp.img` from the linux-firmware clone is at `/usr/lib/firmware/mediatek/mt8195/` (plain file, sha256 `995bcf81…`, `cherry_scp_v2.0.23042-e27728578`).
  - It isn't in the initrd, so the early-boot load fails (-2) and the remoteproc boots on the first decoder open. That's harmless.
- Test dirs: `/root/vdec/{vectors,results}`, FFmpeg at `/opt/ffmpeg-vdec`.
  - Images (nerdctl, default namespace): `vdec/gst-fluster`, `vdec/ffmpeg-run`. The Kodi image is not loaded yet.
  - Containers need `--net=host` (no CNI bridge on the node).
- MT6360 USB-C PMIC: `irq 116 … mt6360_irq` storms and an `irq/116-mt6360-tcpc` thread in D state were seen. Unrelated to video; looks like the board's TCPC.
- containerd, nerdctl (`/usr/local/bin`), crictl and kubelet are present. `/` has 232 GB free. No buildkit and no rsync on the board; use `docker save | ssh nerdctl load` and `tar | ssh`.

## Tooling

- `scripts/51-media-image.sh <name>`: builds `scripts/media/<name>.Dockerfile` with docker on the VM, then `docker save | ssh board nerdctl load`. The images are `gst-fluster` (context = fluster clone) and `ffmpeg-run`.
- `scripts/50-media-ffmpeg-build.sh [--reconfigure] [--ship]`: incremental out-of-tree FFmpeg build in `vdec/ffmpeg-dev` (trixie + backports `linux-libc-dev`), ccache, about 90 s cold. `--ship` tars it to the board's `/opt/ffmpeg-vdec`.
- `scripts/30-armbian-b4.sh ext <msgid> <dir> <file> [b4 am args]`: extra args, eg. `-P 3`, take one patch of a series.
- `board-watch.sh <rc-file> [max-min]`: background watcher; ends when the run finishes, or the board is unreachable, rebooted, or has a task stuck in D for 15 s+; board checked every 8 min. `board-retest-k3.sh`: FFmpeg + GStreamer retest. `board-mdp3-soak.sh`: 20 short scale runs with idle gaps + a 21k-frame loop.
- `board-ffmpeg-md5.py <suite.json>`:
  - Pipeline: FFmpeg v4l2request → `hwdownload` (MM21 CPU detile) → md5 vs. the fluster reference.
  - Result codes: `OK`; `SW` = equals FFmpeg's own software decode while the reference differs (counted as a pass); `KO`.
  - Logs `IOMMU-FAULTS=n` per vector and aborts if the board drops.
- **ITU vectors**: fluster's parallel download (2x cores) gets "Request Rejected" from the ITU WAF, which shows up as checksum mismatches. `fluster.py -r <dir> download -j 1 -r 5 <suites>` works.
- **Never run two decode tests at once.** Concurrent runs muddled the early results.

## Results (2026-11-12)

### Conformance (board, kernel build #2 for these runs; FFmpeg with the cache-hints test hack)

| Suite | GStreamer 1.26.2 V4L2SL | FFmpeg v4l2request | Notes |
|---|---|---|---|
| JVT-AVC_V1 (H.264) | 95/135 | 96/135 | shared: interlaced (field/PAFF/MBAFF), Baseline FMO/ASO, Extended SP. FFmpeg-only: `CAWP5_TOSHIBA_E`, `CVWP5_TOSHIBA_E` (weighted pred), `MR1_BT_A`. GStreamer-only: `FM1_BT_B`, `FM2_SVA_C`, `MR4/MR5_TANDBERG_C` |
| JCT-VC-HEVC_V1 | 142/147 | 132/147 | shared: PICSIZE_A-D (limits). GStreamer: TSUNEQBD. FFmpeg: 10× Main10 (no MT2110 in my `hwdownload` detile, a tool gap), `CONFWIN_A_Sony_1` (crop after detile?) |
| VP8-TEST-VECTORS | 61/61 | 59/61 | 15 counted via `SW`; real: `segmentation-1425` (IOMMU faults), `segmentation-1436` |
| VP9-TEST-VECTORS | 276/305 | 205/305 | GStreamer: resize (24), svc, 422/444. FFmpeg also: sizes < 64 px (`ENUM_FRAMESIZES` check), 10-bit profile 2 (tool gap); 28 via `SW` |
| AV1-TEST-VECTORS | 240/242 | (unsafe, see below) | GStreamer: film grain (2) |
| CHROMIUM-8bit-AV1 | 11/13 | 6/13 | GStreamer: film grain. FFmpeg: tile vectors fault the decoder |
| CHROMIUM-10bit-AV1 | 22/23 | — | **10-bit (MT2110) works in GStreamer** (CPU unpack) |

- **Retest on kernel build #3 (K26/K28/K29), 2026-11-12 ~16:45–17:10 UTC; FFmpeg with chewitt's cache hints back on (hack reverted)**: results in `results/k3-*`.
  - FFmpeg H.264 96/135, HEVC 132/147, VP8 59/61, VP9 204/305. Identical to the hack-build numbers except one flaky VP9 resize vector (`resize-fp-tiles-4-16` failed once with EINVAL on submit; 3/3 OK on recheck).
  - **So K28 fixes the readback with chewitt's FFmpeg unchanged.**
  - GStreamer: VP8 61, VP9 276, AV1 240, Chromium 8-bit 11, Chromium 10-bit 22, HEVC 142, H.264 95. Identical to before; no regressions from 3200–3202.
  - IOMMU faults: only VP8 `segmentation-1425` (as before). 11 faults this boot in total; no hang, no reboot.
- Retest summary: low-risk (FFmpeg hints on + GStreamer) no regressions; soak passes; AV1 no panic.
- **Risky retests on build #3 (2026-11-12 ~17:13–17:30 UTC+1), under `board-watch.sh`**:
  - **MDP3 soak passed**: 20/20 short decode→`scale_v4l2m2m` runs with 2 s idle gaps (GCE autosuspend between jobs), 217/217 frames each at 210–216 fps, then one 21700-frame loop at 213 fps. 0 IOMMU faults. **K29 holds.**
  - **FFmpeg AV1, no panic (K26 works)**: AV1-TEST-VECTORS 137/242 (same as before), Chromium-8bit 6/13.
    - Still faulting the decoder IOMMU: `sizeup` (10), `svc-L1T2` (1), `svc-L2T1` (25), `svc-L2T2` (30, the one that panicked before), `nonuniformtiling` (50), `tile-rows-3-tile-cols-3` (50), `only-tile-cols-is-power-of-2` (11), `only-tile-rows-is-power-of-2` (1).
    - The kernel log shows the K26 guard firing: `CAPTURE buffer unavailable on decode completion`. Each one follows `decode src_buf[1] sz=0x10/0x11 pts=… ret=-16` (EBUSY) on **16–17 byte OUTPUT buffers**.
    - **Lead**: FFmpeg submits tiny AV1 temporal units (likely `show_existing_frame` / frame-header-only OBUs) to the hardware, and the MTK AV1 driver/firmware mishandles them. GStreamer presumably doesn't submit those to the decoder. Check that first in Phase C step 3.
- GStreamer's failures are known hardware/driver limits.
- The decoder supports 64x64–4096x2304 (stepwise 16). H.264/HEVC are FRAME_BASED + ANNEX_B.

### FFmpeg fixes and findings (branch `mediatek-mm21-armsoc-9.0.2`)

Commits on top of chewitt `armsoc-9.0.2` (`ad8c2e36ee`):
1. hwcontext MM21/MT2110 formats, with libdrm fallback defines
2. `vf_scale_v4l2m2m`, with libdrm fallback
3. deinterlace rejects non-linear modifiers (reworked; 2-object NV12M still works)
4. `scale_v4l2m2m`: 12 capture buffers, atomic queued count, wait for returned buffers (ENOBUFS), POLLERR/timeout split, NOPTS guard, `capture_buffers` and `timeout` options
5. MM21 CPU detile on `hwdownload`

- **libdrm**: Debian trixie's 2.4.124 `drm_fourcc.h` has no MTK modifiers (not even in backports), which silently compiled out every `#if defined(DRM_FORMAT_MOD_MTK_16L_32S_TILE)` block. The result was "Failed to select a CAPTURE format" and a software fallback. Fixed with `#ifndef` fallbacks; Kodi does the same in `utils/DRMHelpers.h`.
- **Stale cache readback (K28)**: chewitt's "use cached CAPTURE buffers when supported" allocates `V4L2_MEMORY_FLAG_NON_COHERENT` and queues with `NO_CACHE_CLEAN|NO_CACHE_INVALIDATE`. Mainline `vb2_dc_dmabuf_ops_begin_cpu_access` is a stub, so `hwdownload` reads stale lines once buffers are reused: the first ~12 frames are fine, then they go wrong. LE fixes it only for Amlogic (`amlogic-0116`). VP8 went from 20/61 to 59/61 with the hints off. The display path isn't affected.
- **VP8 1425/1436**: the MTK VP8 driver only takes the 3 ref timestamps, `flags>>1` and the bitstream (the firmware parses the header). So the difference is in the refs or buffer contents FFmpeg submits. 1425 diverges at frame 4, 1436 at frame 1. Next: dump the per-frame controls from FFmpeg and GStreamer and diff them.
- **AV1 (don't run FFmpeg AV1 conformance casually)**:
  - SVC `L1T2`/`L2T1`/`L2T2` → IOMMU faults → **kernel panic** (2026-11-12 ~14:55 UTC, before K26): NULL deref at 0x60, `vb2_buffer_done` ← `mtk_vdec_stateless_cap_to_disp` ← `vdec_av1_slice_core_decode`
  - After that: `nonuniformtiling` (50 faults), `tile-rows-3-tile-cols-3` (50), `sizeup` (10), `only-tile-*-power-of-2` (1 each)
  - GStreamer passes all of them. The theme is tiles and SVC (tile group entries / tile_info / operating point). With K26 these should now fail without a panic (untested).
  - Next: diff the FFmpeg and GStreamer AV1 controls on `nonuniformtiling`.

### Kodi on the board (2026-11-12; `le-media-kodi-vdec/kodi-test.sh`, results in `le-media-kodi-vdec/results/kodi-*`)

- Harness: a fresh container per run with a seeded `kodi-home` (`le-media-kodi-vdec/kodi-home/`: web server without auth, DRM PRIME, `useprimerenderer`, 1920x1080@60). Control is JSON-RPC (`Player.Open`/`GetProperties`); 60 frames are grabbed on the Blade3 HDMI-RX (per-frame md5 count + 3 PNGs). Kodi log and kernel log are collected per run.
  - The first start queues several "Disabled add-ons" Yes/No dialogs (RTMP, IPTV Simple). The script now answers them with `Input.Back`; they also dim the video behind them.
- **EGL (`useprimerenderer=1`)**:
  - `h264-1080.mp4` (libx264 High, default preset: B-frames): plays in real time with the right geometry, but the picture is **corrupted** (stale or ghosted macroblocks that persist).
  - `h264-1080-nowp-nob.mp4` (no B-frames): picture matches the software reference. The renderer is `RendererDRMPRIMEGLES`, the decoder `CDVDVideoCodecDRMPRIME` with v4l2request. No EGL import errors, no IOMMU faults.
  - The Kodi log shows `deinterlace_v4l2m2m … Could not find a valid device` / `FilterOpen … -22`: harmless (no deinterlacer on MTK).
  - The kernel log at Kodi start/stop shows `vblank wait timed out on crtc 0` (WARNING in `mtk_crtc_atomic_disable`), plus `Runtime PM usage count underflow!` on `mediatek-disp-ethdr` and on `mediatek-mdp-rdma 1c104000`–`1c10b000`. These are display-driver issues, not fatal; to look at later.
- **FFmpeg H.264 B-frame bug** (per-frame md5, `-hwaccel v4l2request … hwdownload` vs FFmpeg software, first 300 frames):
  - default x264 250/300 wrong (from frame 26); `weightp=0` 254/300 (from 24); `b-pyramid=none` 231/300 (from 40); `refs=1` 254/300 (from 24); **`-bf 0`: 0/300**
  - **GStreamer `v4l2slh264dec` on the default clip: 0/900 wrong**, so the cause is in FFmpeg's controls, not the driver or firmware.
  - Not the cause: weighted prediction, b-pyramid, multiple refs, DPB ordering (the driver remaps DPB slots by POC in `mtk_vdec_h264_update_dpb` and builds its own P/B0/B1 lists with `v4l2_h264_build_*_ref_list`).
  - Errors start at a B-frame mid-GOP, then propagate. Probably related to the conformance failures `MR1_BT_A` and `CAWP5`/`CVWP5`.
  - **Root cause** (found with the `LD_PRELOAD` control dumper `le-media-kodi-vdec/tools/h264ctl-dump.{c,so}`, `H264DUMP=<file>`; `tools/norm.py` normalises dumps for diffing): two FFmpeg bugs.
    - DPB `pic_num` came from `pic->pic_id`, which is stale. After `frame_num` wraps it isn't FrameNumWrap; GStreamer sends e.g. -5.
    - `dec_ref_pic_marking_bit_size` kept the previous reference slice's value on non-reference slices.
    - FFmpeg commits `03849804f8` (h264_slice: reset marking size) and `34de8f4aa7` (v4l2_request_h264: PicNum = FrameNumWrap). Not isolated which of the two the MTK firmware cares about; probably pic_num (corruption starts right after the wrap).
  - After the fix, all test clips are bit-exact. JVT-AVC_V1 went 96 → 100/135 (`results/k4-ffmpeg-JVT-AVC_V1.txt`): fixed `CAWP5`, `CVWP5`, `MR1_BT_A`, `MR3_TANDBERG_B`.
  - Other differences that remain, believed harmless: FFmpeg POCs carry a +65536 offset, and FFmpeg always sets `PPS_FLAG_SCALING_MATRIX_PRESENT` (with a flat matrix).
- **DirectToPlane (`useprimerenderer=0`)**, `h264-1080-nowp-nob.mp4`: correct picture, fullscreen. The plane is `UYVY`/`LINEAR` 1920x1080 (MDP3 via the convert filter). No hang, no IOMMU faults; the same display warnings as EGL. The dialogs from more add-ons (Shadertoy) still dim the picture; those add-ons need disabling in the seed.

- **Matrix (2026-11-12 ~20:30, `kodi-matrix.sh`)**: every run real time (speed 1), 31 distinct frames per 60 captured (30 fps content on 60 Hz), 0 IOMMU faults, no hangs.
  - Pictures checked visually against the pattern: all OK. VP9 and AV1 at 4K show faint mottling in the grey box (minor, maybe encoder or scaling).
  - EGL and plane render colours slightly differently (range/matrix); to check later.
  - `kodi-test.sh` now answers the add-on dialogs until `GUI.GetProperties currentwindow` is Home.
- **10-bit HEVC (`hevc10-1080.mkv`) freezes at 0% on both paths.** The decoder outputs NV15 with modifier `0x0b00000000010001` (MTK 10-bit).
  - EGL: `CEGLImage::SupportsFormatAndModifier … not supported for format (NV15)`, then `refusing unsupported pix_fmt drm_prime` / `failed to configure renderer`.
  - Plane: `scale_v4l2m2m Unsupported input layout, fourcc NV15`, then "falling back to software decoding". **Our software fallback is broken**: the reopened codec still has the drm_prime hw setup and loops on `Invalid setup for format drm_prime: missing configuration` / `GetFormat - no supported pixel formats: yuv420p10le` (25k log lines).
  - **Fixed** (Kodi `mediatek-piers` `7e9b59cb0f`, `ee3a4f3339`, `1b94bc79cd`; kodi-rockchip-deb `a08dda0`, `941ec9b`; LibreELEC `957538b1a0`, `424ce54491`):
    - DRMHelpers: fallback defines for `DRM_FORMAT_S0xx/S2xx/S4xx` (libdrm 2.4.125+). With 2.4.124, `yuv420p10` was compiled out of the software path. Also includes DRMHelpers in `VideoBufferPoolDMA.cpp`.
    - DRMPRIME codec: reopen in software as soon as a frame has an MTK 10-bit layout (`MTK_FMT_MOD_10BIT_LAYOUT_MASK`), on both paths; `GetFormat` skips `drm_prime` once forced to software.
    - RendererDRMPRIMEGLES: no longer gated on `useprimerenderer == 1`. `drm_prime` (plane) is tried first (map order), so GLES only takes the buffers no plane accepts. The MTK planes take neither S010 nor YUV420, so this also fixes 8-bit software fallback in plane mode.
  - Result: `hevc10-1080.mkv` plays (CPU decode, GLES render) on both settings, 0 IOMMU faults. Expected: ~240× `Could not find ref with POC` / `Error constructing the frame RPS` after the mid-GOP reopen. At the 15 s check it was already at 74% (others ~48%): the reopen seems to skip ahead; minor.
- **PR screenshots** (`notes/media/img/`): `kodi-sysinfo-{summary,video,hardware}.png` (kernel 7.3.4-edge-genio, Mali-G57 Panfrost / Mesa 26.1.6, Genio 1200 MT8395 / NIO 12L, Kodi 22.0-RC2), `kodi-hevc2160-plane-processinfo.png` (4K HEVC, `ff-hevc-drm_prime (HW)`, `scale_v4l2m2m=format=uyvy`), `kodi-hevc2160-plane-osd.png`; player process info: `kodi-av1-2160-plane-processinfo.png` (`ff-av1-drm_prime (HW)` + `scale_v4l2m2m`), `kodi-vp9-2160-egl-processinfo.png` (`ff-vp9-drm_prime (HW)`, 3840x2160 via EGL), `kodi-h264-1080-egl-processinfo.png` (`ff-h264-drm_prime (HW)`), `kodi-hevc10-1080-plane-swfallback-processinfo.png` (`ff-hevc-drm_prime (SW)`, `yuv420p10le`). Made with (`le-media-kodi-vdec/kodi-shots.sh <clip> <renderer> <prefix>`: System Information pages + player process info / codec info / OSD during playback).

### Real clips (2026-11-12 ~22:00; `clips/real/`, results `results/kodi-real/`)

| clip | EGL (r1) | plane (r0) | notes |
|---|---|---|---|
| bbb-1080p24-h264 (AAC 5.1) | OK-HW | OK-HW | 25/60 distinct (24 fps); audio to HDMI |
| jf-avc-1080-10M | OK-HW | OK-HW | 60/60 |
| jf-avc-2160-40M | OK-HW | OK-HW | 60/60 |
| jf-avc-2160-150M | OK-HW | OK-HW | 60/60 |
| jf-hevc8-1080-10M / 30M | OK-HW | OK-HW | 60/60 |
| jf-hevc10-1080-10M | OK-SW | OK-SW | 60/60 |
| jf-hevc10-2160-40M | SLOW-SW | SLOW-SW | 29/32 |
| jf-hevc-hdr10-2160-40M | SLOW-SW | SLOW-SW | 57/48; washed out (no HDR) |
| jf-dv81-2160 | SLOW-SW | SLOW-SW | 30/26; HDR10 base layer; `Multiple Dolby Vision RPUs found in one AU` |
| jf-av1-10-1080/2160, jf-av1-hdr10-2160 | CRASH → SW | CRASH → SW | was a Kodi segfault after `unable to find decoder for codec 222` / `failed to reopen`; after the fix, dav1d on the CPU: 1080p 48/60, 4K 17/60 |
| jf-avc-4320-150M (8K) | SLOW-SW | SLOW-SW | 13/14; HW refuses 8K |

- Kernel: 0 IOMMU faults, no vcodec/MDP3 errors. Display noise as before (rdma/ethdr runtime-PM underflow, vblank timeout on crtc disable); also `hdmi-audio-codec: Unknown ELD version 0` (the Blade3 RX's EDID has no audio block?).
- **AV1 crash fix**: Kodi `282a09a58b` "VideoPlayer: Switch to a software decoder when reopening fails" (`Reopen()` returns bool; on failure VideoPlayer recreates the codec with `CODEC_FORCE_SOFTWARE`, so `CDVDVideoCodecFFmpeg` + libdav1d + GLES). kodi-rockchip-deb `0220831`, LibreELEC `691a0686ea`.
- Screenshots: `notes/media/img/real-*` (best: `real-bbb-1080p24-egl-plain.png`, `real-bbb-1080p24-egl-processinfo.png` (HW H.264, 24 fps, AAC 5.1), `real-bbb-1080p24-plane-processinfo.png` (HW + MDP3), `real-jf-hevc8-1080-30M-egl-processinfo.png`; informative: `real-jf-avc-2160-150M-plane-*`, `real-jf-hevc10-2160-plane-swfallback-processinfo.png`, `real-jf-hevc-hdr10-2160-egl-processinfo.png` (washed out)). `kodi-shots.sh` has `SEEK=<pct>` and `PLAIN=1`.

### Real use: BBB 1080p24 (2026-11-12 ~22:35; `kodi-realuse.sh <clip> <r> [min]`, results `results/realuse-*`)

- **Refresh-rate switching works** (`adjustrefreshrate`=2): the GUI is at 1080p60 (148.5 MHz), playback switches to 1080p23.98/24 (74.25 MHz), and stop returns to 60. Same on both paths.
- **Seeking works**: 25/60/90/10% all land and resume at speed 1 within 6 s (time advances 5 s in 5 s).
- **3 min continuous play OK** on both paths; audio PCM `RUNNING` throughout; 0 IOMMU faults.
- Drops: 64× `OutputPicture - dropped in output` per run (around seeks and mode switches), plus the normal seek-target drops.
- **5.1 → stereo**: Kodi set to 5.1, but the ALSA device reports only FL/FR (`Input Channel Count: 6 Output Channel Count: 2`). Likely the Blade3 RX's EDID has no audio block (`hdmi-audio-codec: Unknown ELD version 0`), so the HDMI codec limits output to 2 channels. Needs a real AV receiver/TV to test multichannel and passthrough.
- **Mode switches are slow**: every CRTC disable waits out vblank timeouts (`mtk_crtc_atomic_disable` → `drm_atomic_helper_wait_for_vblanks`; `vblank wait timed out on crtc 0` warnings). The watcher caught `kodi-gbm` in D state there once, during the 24p↔60p switch at stop. It recovered, so it's not a hang, but it is a display-driver bug to look at (with the rdma/ethdr runtime-PM underflows).

### 10-bit: MT2110 CPU detile to P010 (2026-11-12 ~23:00)

- **FFmpeg** `c45b2cfba5` "avutil/hwcontext_v4l2request: Detile MediaTek MT2110T/R to P010 on hwdownload".
  - Layout (from GStreamer `video-format.c` `unpack_MT2110T/R`): the MM21 tile grid (16x32 luma = 640 B, 16x16 chroma = 320 B, tiles linear, `x_tiles = bytesperline/16`). Partitions of 4 rows × 16 px = 80 B: 16 B of low 2 bits, then 64 B of high 8 bits. T: low bits at byte `x`, shift `2*row`; R: byte `row*4 + x/4`, shift `2*(x%4)`.
  - Bit-exact against FFmpeg software (P010 framemd5): generated HEVC Main10 150/150, Jellyfin HEVC 10-bit 300/300, AV1 10-bit 300/300.
  - Speed on the NIO, 4K60 10-bit: HEVC 104 fps with detile (132 without), AV1 97 fps (96).
- **Kodi** `552f13298c` "DVDVideoCodecDRMPRIME: Detile MediaTek 10-bit frames into P010 DMA buffers": `DownloadToDMA()` takes a P010 `CVideoBufferDMA` from the software pool, `Export`s it into an AVFrame, runs `av_hwframe_transfer_data`, then moves it into `m_pFrame` so `SetPictureParams` takes the DMA path. GLES imports P010 directly; the plane path hands it to GLES (plane rejects P010). The software reopen remains as fallback.
  - First build bug: `av_frame_copy_props()` copied the hw frame's `opaque` over our DMA buffer → `videoBuffer:nullptr` on every frame. Fixed by resetting `opaque` after the copy.
- Packaging: kodi-rockchip-deb `fac74f5`, LibreELEC `483bb4a5c3` (FFmpeg and Kodi patches regenerated; Kodi patches apply on `22.0rc2-Piers`).
- **Kodi matrix with the detile** (both paths): `jf-hevc10-2160-40M` 60/60, `jf-hevc-hdr10-2160-40M` 60/60, `jf-dv81-2160` 60/60, `hevc10-1080` (30 fps) 31/60, `jf-av1-10-2160-40M` 44/60. 0 IOMMU faults, no fallbacks.
  - AV1 4K10 at 44/60 although hw+detile benchmarks at ~97 fps: to look at (Kodi-side copy/sync? AV1 hw decode alone is 96 fps, so little headroom).
- **Audio device**: Kodi enumerates only `@` and `sysdefault:CARD=sofmt8395evk` for this card, and `ValidateOutputDevices` sometimes rewrote `plughw:…,DEV=5` to `sysdefault` (PCM 0, not HDMI). Test setup now mounts `kodi-home/asound.conf` (board `/root/vdec/asound.conf`) as `/etc/asound.conf` (`pcm.!default` = plug → `hw:CARD=sofmt8395evk,DEV=5`), and the seed uses `ALSA:default`.
- Screenshots: `real-jf-hevc10-2160-plane-hwdetile-processinfo.png`, `real-jf-av1-10-2160-egl-hwdetile-processinfo.png`.

### Step 5 (2026-11-12/13): conformance with the detile, AV1 tiles, K27

- **Conformance with 10-bit checkable** (`board-ffmpeg-md5.py` downloads `p010le` for 10-bit; `results/k5-*`): AV1 137 → **201/242**, HEVC 132 → **142/147**, VP9 unchanged 204/305 (profile 0 only), Chromium 10-bit AV1 10/23 before the tile fix.
- **AV1 tile bug (FFmpeg)**: `v4l2_request_av1.c` filled `mi_col_starts`/`mi_row_starts` with CBS superblock starts (only the last entry was in MI units). V4L2 wants MI (4x4) units, and the MTK driver derives tile sizes from consecutive starts (`vdec_av1_slice_setup_tile`, `sb_boundary_x_m1`), so every multi-tile frame faulted. Fixed: shift by 4 (or 5 for 128x128 SB). FFmpeg `3a0857fba5`.
  - Chromium 8-bit AV1 6 → **10/13**, Chromium 10-bit 10 → **22/23** (= GStreamer) (`results/k6-*`). Left: `av1-1-b8-03-sizeup` (still IOMMU-faults) and the film-grain vectors.
- **Dufresne's comment on the PR** ("For 10bit, you can point your AI to gstreamer code… The mapping in MDP3 is indeed missing… It is supported though, maybe this can be extracted from vendor TV stacks"):
  - The CPU detile is a port of his GStreamer unpack code; the FFmpeg commit now credits him (`1ed4b233dc`).
  - **K27 tried**: mainline MDP3 already has `MDP_COLOR_420_BLK_10_V/_H` + RDMA 10-bit; added MT2110T/R entries (`037c58f9c881`, Armbian `3203`, armbian-build `310898a8c`), plus a `scale_v4l2m2m` NV15+MTK-10-bit mapping (FFmpeg, not committed; saved at scratchpad `ffmpeg-mt2110-mdp3-filter.diff`).
  - Result: MDP3 lists `MT2T`, but conversion triggers **`mtk-scp: SCP watchdog timeout`** (`mdp_vpu_sendmsg` → `scp_ipi_send failed -5`), ~1 fps, and the decoder briefly times out on the same SCP. The SCP recovered by itself (8-bit decode and MM21→UYVY fine afterwards); no reboot needed.
  - The ChromeOS SCP fw (`cherry_scp_v2.0.23042`; linux-firmware `f41d890a` "support 10bit mode" by Yunfei Dong, 2023) has 10-bit strings only on the decoder side (`MM21_10bit tile/raster mode` next to `Unsupported capture fourcc`); its MDP code shows only alignment checks.
  - Vendor TV kernel sources aren't public in a useful form. Looking at the Genio AIoT SCP fw (Ubuntu `linux-firmware-mediatek-aiot`, `scp.img v14454.8.0`) and the Genio BSP kernel's mdp3 (gitlab `mediatek/aiot/bsp/linux`), under `le-media-kodi-vdec/vendor/`.
  - Kodi is unaffected: it detiles 10-bit on the CPU before any MDP3 conversion. The FFmpeg mapping was reverted on the board.
  - **Vendor check (2026-11-13; files in `le-media-kodi-vdec/vendor/`)**:
    - Ubuntu `linux-firmware-mediatek-aiot` 2-0ubuntu1 (newest on Launchpad) mt8195 `scp.img` = `cherry_scp_v2.0.11877 / 14454.8.0 (2022-01-24)`: **older** than linux-firmware's `cherry_scp_v2.0.23042 (2023-11-21)`, same MDP strings, no 10-bit MDP. No alternative SCP fw there.
    - Genio BSP kernel `gitlab.com/mediatek/aiot/bsp/linux` `mtk-v6.6` (newest): **MDP3 frame setup runs on the AP** (`mdp_alg_*.c`/`mdp_tile_*.c`, ~13k lines, `.mdp_alg_plat = MDP_ALG_MT8195`), not in the SCP. Its RDMA algorithm handles 10-bit block input (`mdp_alg_rdma.c`: `blk_10bit = MDP_COLOR_IS_10BIT_PACKED`, `blk_tile = MDP_COLOR_IS_10BIT_TILE`). It still has **no MT2110 V4L2 mapping** (only MT21C/MM21). Stride/plane-size code matches mainline.
    - `mtk-v5.15-dev` and 4 mtk-v6.6 headers weren't fetched (GitLab HTTP 429; retry later).
    - **Conclusion**: the hardware supports 10-bit block input, as Dufresne says, but the mainline SCP-firmware MDP path doesn't. K27 would mean porting the BSP's AP-side MDP algorithm (big, unlikely upstreamable) or getting MediaTek to update the SCP fw. **Parked**; the CPU detile covers 10-bit (4K60 HEVC at full rate). Armbian `3203` reverted (armbian-build `9259e765f`); branch `mainline/mtk-mdp3-mt2110` kept for reference. **The NIO still runs kernel build #4 with 3203**: harmless for our stack (nothing feeds 10-bit to MDP3), replace it at the next kernel install.

### Housekeeping (2026-11-13)

- **Final FFmpeg conformance on the NIO** (`results/k7-*`): AV1 **234/242**, VP9 **265/305**, H.264 100/135, HEVC 142/147, VP8 59/61; Chromium AV1 8-bit 11/13, 10-bit 22/23.
- **Deployed on the NIO**: kernel build #3 (3200–3202, no 3203) and the Kodi image from kodi-rockchip-deb `d2525a0`. AV1 recheck in Kodi: 10-bit 1080p60 60/60 (HW + detile), 4K 44/60, 0 faults.
- **Armbian 3200/3202 "needs_rebase"**: only index/blank-line differences; cosmetic, fixed by `./compile.sh rewrite-kernel-patches` when needed (user). Left as b4 dumps.
- **LibreELEC** `mediatek-genio` rebased onto `le-upstream/master` (backup `backup/mediatek-genio-pre-rebase-20261113`). Master already moved Amlogic to 7.3.4 and chewitt `armsoc-9.0.2` `ad8c2e36ee`, the same commit our Mediatek FFmpeg case uses; chewitt's FFmpeg branch hasn't moved, so no FFmpeg rebase needed.
  - `33da025fc3` "linux: Mediatek: update to 7.3.4 with CEC and media fixes": same 7.3.4 commit as Amlogic, plus Armbian's 3005 (ethernet ASPM), 3100–3104 (CEC), 3200–3202 (K29/K26/K28). Config regenerated with `olddefconfig`/`savedefconfig` (+`CEC_MTK=y`; 7.3 dropped `BATTERY_QCOM_BATTMGR`, `QCOM_PMIC_GLINK`, `DMA_FENCE_TRACE`). All patches apply on v7.3.4 (no image build yet).
  - SOF/SCP firmware: covered by `mediatek/*` in `projects/Mediatek/config/kernel-firmware.dat`; UCM `sof-mt8395-evk` in the branch.
  - chewitt's LE `amlogic-0174` is the same vb2-dma-contig change as our 3202.
- **kodi-rockchip-deb** `9008c03`: ffmpeg-only `kodi-rockchip-gbm-ffmpeg_<arch>_ffmpeg_<id>_<distro>.deb` (ffmpeg/ffprobe + the `/usr/local` libs they link, `dpkg-shlibdeps -xkodi-rockchip-gbm`, `Conflicts: kodi-rockchip-gbm`); the container stage installs only the Kodi package. Tested: installs on plain trixie, `-hwaccels` = drm v4l2request. The rkmpp flavor is untested (MPP/RGA libs get picked up via ldd).
- **Blade3 baseline (RK3588 mainline: hantro, rkvdec, AV1 VPU)**: `blade3-setup.sh`, `blade3-baseline.sh` (`BOARD=` override in `board-ffmpeg-md5.py`, `board-fluster-gst.sh`, `board-watch.sh`). Headless only (no HDMI-RX on the NIO). Results in `results/blade3-*`.

### Parked (2026-11-13, user decision: non-essential)

- HEVC `PICSIZE_A`–`D` (no output; not fixed by the min-framesize change) and `CONFWIN_A` (likely left/top crop of hw frames)
- VP8 `segmentation-1425` (IOMMU faults) / `1436`
- AV1 film grain (`av1-1-b8-23-filmgrain-50`, `ccvbfilmgrain`, `av1-1-b10-23-filmgrain-50`)
- VP9 `resize*` (26; GStreamer fails them too), `vp91-2-04-yuv422/444` (unsupported profiles), `vp90-2-22-svc`
- AV1 10-bit 4K headroom (44/60), EGL vs. plane colour, 10-bit fallback skip-ahead, display-driver warnings, Blade3 hdmirx audio
- Latest fixes (2026-11-13): AV1 resolution-change reinit (FFmpeg `d10bfdc65f`, fixes `sizeup`; Chromium 8-bit AV1 11/13 = GStreamer); min framesize only enforces the maximum (`abcf34a935`; VP9 204 → 265/305). Packaging: kodi-rockchip-deb `d2525a0`, LibreELEC `3960b8c2f8`.

### Audio (2026-11-12)

- **Root cause of "no sink"**: no sound card. The SOF DSP (`sof-audio-of-mt8195 10803000.dsp`) failed with `SOF firmware and/or topology file not found` (`mediatek/sof/sof-mt8195.ri`, `mediatek/sof-tplg/sof-mt8195.tplg`). The machine driver `mt8195_mt6359` then never registered the card.
- **Fix on the board**: copied `sof-mt8195.{ri,ldc}` and `sof-mt8195.tplg` from the linux-firmware clone into `/usr/lib/firmware/mediatek/` and rebooted. The card is now `sof-mt8395-evk` (`sofmt8395evk`).
- **HDMI = `hw:0,5`** (`DL10 Playback`), from LibreELEC's UCM `projects/Mediatek/filesystem/usr/share/alsa/ucm2/MediaTek/sof-mt8395-evk/`. It needs mixer routes that nothing sets on CaptainOS (no UCM there, and the Kodi image's alsa-ucm-conf has `mt8395-evk` but not `sof-mt8395-evk`):
  - `HDMI_OUT_MUX`=1, `ETDM_OUT3_Clock_Source`=a1sys_a2sys, `O176 I070 Switch`=on, `O177 I071 Switch`=on
  - set with `amixer`. alsa-utils is now installed on the NIO host (user OK) and the state is saved with `alsactl store` (`/var/lib/alsa/asound.state`, restored at boot by `alsa-restore`).
  - `speaker-test -D hw:0,5 -c2` runs at the right rate.
- **Kodi**: `default`/`sysdefault` is PCM 0 (DL2), not HDMI, and `@:CARD=…,DEV=5` expands to `front:…`, which doesn't exist. The seed now sets `audiooutput.audiodevice` = `ALSA:plughw:CARD=sofmt8395evk,DEV=5` and `audiooutput.channels` = 1 (2.0). During BBB (AAC 5.1 downmixed) the PCM is `RUNNING` at S24_LE, 2 channels, 48 kHz.
- **LibreELEC has all the firmware**: `projects/Mediatek/config/kernel-firmware.dat` contains `mediatek/*` (copied recursively), and LE's linux-firmware `20261019` has `mediatek/mt8195/scp.img`, `mediatek/sof/sof-mt8195.ri` and `mediatek/sof-tplg/sof-mt8195.tplg`. The branch also ships the UCM (`sof-mt8395-evk`, matching the card name).
- **Armbian/CaptainOS**: needs the SOF firmware (and `scp.img`) packaged, plus UCM `sof-mt8395-evk` (or alsa-ucm-conf upstream) and alsa-utils/UCM to apply the boot sequence.

### MDP3 hang: root cause K29 (fixed)

- **Symptom**: any MDP3 m2m job (FFmpeg `scale_v4l2m2m`, even plain `v4l2-ctl` NV12→YUYV on a fresh boot) never completes.
  - The task goes to D state in `v4l2_m2m_cancel_job` (STREAMOFF/release). Nothing is logged by MDP3, SCP or CMDQ.
  - Afterwards MDP3 stays wedged. `systemctl reboot` stalls on the D-state task.
  - A forced warm reset once hung in `kernel_init`/`async_synchronize_full` (MT6360 IRQ storm). Only a long power-off recovers.
  - Reading debugfs `clk_summary`/`pm_genpd_summary` while it's hung stalled the board until the watchdog reset it. **Don't.**
- **Cause**: Jason-JH Lin's "Add pm_runtime support for GCE power control" v2 (`20250829091727.3745415-{2,3,4}-jason-jh.lin@mediatek.com`, reviewed by AngeloGioacchino) was merged only in part:
  - 1/3 `3f39f5652037`: the mailbox no longer powers the GCE in `cmdq_mbox_send_data`; went into v6.18-rc1
  - 2/3 `afcfb6c8474d`: drm; went in via drm-fixes
  - **3/3 mtk-mdp3: never merged, still missing in master**
  - So MDP3 sends to GCE1, which only MDP3 uses and which has autosuspended. The packet never runs and the callback never comes.
  - The DT, SCP and firmware are identical to Cherry and the vendor tree, so they're not the cause.
- **Fix**: 3/3 = K29 (`mainline/mtk-mdp3-gce-pm-runtime`; Armbian `3200`, b4 dump `-P 3`).
- **Confirmed on the board** (2026-11-12 15:20 UTC, build #3):
  1. `v4l2-ctl` 30/30 frames
  2. GStreamer `v4l2slvp9dec ! v4l2convert ! YUY2`: 1080p stream to EOS in 2.1 s
  3. FFmpeg → `scale_v4l2m2m` `uyvy` / `uyvy:w=1280:h=720` / `nv12`: 217/217 frames at 205–215 fps
  - No IOMMU faults.
- **Upstream**: ping or resend 3/3 with `Fixes: 3f39f5652037`. The user decides; nothing goes to lists without an OK.
- The vendor (Genio) instead moved MT8195 MDP3 config into the kernel (no SCP), and carries many `GENIO:` MDP3 fixes (e.g. "adjust MUTEX clock enable timing"). Not needed for this hang.
- The FFmpeg capture-buffer accounting fix is still right for Kodi (it holds frames), but it wasn't this bug.

## Findings (reference)

### Kernel (kernel-torvalds/master ~ v7.4-rc2+)
- **vcodec on 7.3:**
  - v7.3 already has every relevant fix: `1b78aae6313f4` manual request completion and `3e92d7e493508` VP9 422/444 both landed in v7.0.
  - v7.3..master adds only `ceb6e96122e10` (workqueue on remove) and `ff3308afa9c9d` (mdp3 ref leak).
- **Codecs on MT8195 (LAT+core):**
  - H.264/HEVC/VP9/AV1 use LAT, VP8 uses core. The actual list comes from the SCP capability bits (`mtk_vcodec_dec_drv.c` ~L263).
  - Max levels: H.264 6.0, HEVC 5.2 Main10, VP9 5.2 Profile 2.
  - CAPTURE formats: MM21, plus MT2110T/R when the SPS is 10-bit (L543-556, L837-848). Two planes; `queue_setup` rejects a mismatch (`mtk_vcodec_dec.c` L768-787).
  - No `MIN_BUFFERS_FOR_CAPTURE` on stateless, and `allow_cache_hints=1`.
  - No validation of userspace refs/tiles, hence the IOMMU faults on bad input.
  - IOMMU larb21 ports 0/2 = `VDEC_MC_EXT`/`VDEC_PP_EXT` (decoder core); MDP RDMA is larb4 on iommu_vpp.
- **DRM planes** (`mtk_plane.c`):
  - only LINEAR (L23-26, L63-67)
  - `DRM_PLANE_NO_SCALING` (L250-254, L102-105)
  - OVL (`mtk_disp_ovl.c` L118-139) and ovl_adaptor/MDP-RDMA (`mtk_mdp_rdma.c` L63-75): RGB plus UYVY/YUYV, **no NV12, no MTK modifier**
  - no YUV rotation
- **MDP3** (`mdp_cfg_data.c` L1041-1250):
  - MM21 is input-only. **MT2110T/R appears nowhere**, vendor trees included (K27).
  - Both queues take MMAP and DMABUF.
  - Jobs go via GCE1 (`mboxes = <&gce1 …>`) with no completion timeout.
- **Collabora** (`kernel-collabora-mediatek`):
  - `wip/mtk/mtk-staging`: `29c8b5f5bf593` "guard empty stateless capture queue" (a vendor `GENIO:` commit by Kyrie Wu) → **K26**
  - `34bf231e51d9a`: longer IRQ timeout
  - MDP3 algorithm-in-kernel (`b4a4a915a26d8`…)
  - K29 (`604b6c37dba8`) carried in many branches
- **vb2 dma-contig**: `begin/end_cpu_access` are stubs in v7.3 (→ K28, chewitt's patch; not on lore).

### FFmpeg (bases)
- `ffmpeg-rpardini/rockchip-9.0.2` matches kodi-rockchip-deb's old 22 patches. `ffmpeg-chewitt/armsoc-9.0.2` (`ad8c2e36ee`, the base now) is a superset: cached CAPTURE, crop export, deinterlace stride, NV12M, VC-1, DoVi, Amlogic/RK AFBC.
- **Decode path** (`v4l2_request.c`):
  - `initial_pool_size=1`; the CAPTURE pool grows with `CREATE_BUFS count=1` on demand, up to 32
  - timestamps = capture index + 1 (µs)
  - polls time out after 2 s
- `scale_v4l2m2m` name clash: rpi-ffmpeg also defines it. The design reference is rpi's `vf_deinterlace_v4l2m2m.c` (8 OUTPUT/12 CAPTURE, `activate()`, EAGAIN, drain).

### Kodi (branch `mediatek-piers`, off `kodi-upstream/Piers`; patches also apply on LE's 22.0rc2-Piers)
- drmprime-filter 0001/0002 (same patch-ids as LE and kodi-rockchip-deb), then:
  1. `DRMHelpers: Define the MediaTek modifiers for older libdrm`
  2. `EGLImage: Accept MediaTek 16L32 tiled buffers for dma-buf import` (claims support without the EGL query; probably unnecessary with Mesa ≥ 25, verify on the board)
  3. `DRMPRIMEEGL: Re-import MediaTek tiled buffers instead of caching them` (needed: panfrost detiles once per sampler view; also re-imports on redraws)
  4. `DVDVideoCodecDRMPRIME: Convert tiled frames for direct scanout`: `scale_v4l2m2m=format=uyvy` for **MTK modifiers only**, in DirectToPlane mode, scaled to fit the screen at the display aspect ratio
  5. `DVDVideoCodecDRMPRIME: Fall back to software when a layout cannot be converted` (+ `GetBuffer` via `av_image_get_buffer_size` for 10-bit, `Reopen()` unrefs frames)
  6. `RendererDRMPRIMEGLES: Use the OES path for MediaTek tiled buffers` (no per-plane YUV import for MTK)
- Multi-object dmabuf is already handled upstream (`DRMPRIMEEGL.cpp:84-90`, `EGLImage.cpp:135-149`, `VideoLayerBridgeDRMPRIME::CreateFramebuffer`, `DmaBufIdentity`).
- **To check on the board**:
  - whether the aspect-fit scale matches Kodi's plane dest rect in every view mode (zoom/stretch would break `NO_SCALING`)
  - how many frames Kodi holds vs `capture_buffers=12`

### Mesa
- panfrost advertises `DRM_FORMAT_MOD_MTK_16L_32S_TILE` (`0x0b00000000000001`) for NV12/R8/RG88 as **external-only** (`pan_screen.c` ~L472-488, `PANFROST_EMULATED_MODIFIERS`). Sample via `GL_TEXTURE_EXTERNAL_OES`.
- Detile path:
  - import as fake-linear R8/RG88 (`pan_resource.c` L101-140)
  - on sampler-view creation, `panfrost_mtk_detile_compute` into a linear shadow
  - **once per sampler view**
  - CPU map of MTK resources looks broken; use the GPU only
- No 10-bit MTK in Mesa (no NV15/MT2110).
- Releases: 25.0.0 first; **25.2.0 practical minimum** (stride fix `eb476fd2c60`); 26.3.0 has more fixes. trixie 25.0.7 is too old, trixie-backports 26.1.6 is in our image, LibreELEC has 26.3.0.

### GStreamer (the reference; Nicolas Dufresne)
- **Formats:**
  - `NV12_16L32S` (MM21) since 1.22
  - `MT2110T`/`MT2110R` since 1.24 (unpack in `video-format.c` L7657-7955)
  - `DMA_DRM` mapping since 1.26: MT2110T → NV15 : `0x0b00000000010001`, MT2110R → NV15 : `0x0b00000000020001`
- **MT2110 layout:**
  - 16×32 Y (640 B) / 8×16 UV (320 B) tiles, raster order
  - 80-byte partitions of 4 rows: 16 B of low 2-bit LSBs, then 64 B of high 8 bits
  - T: `lo[x] >> 2r`; R: `lo[r*4 + x/4] >> 2*(x%4)`
  - The high bytes alone give an 8-bit fallback.
- **Elements:**
  - `v4l2codecs` outputs DMA_DRM NV12:MTK
  - `glupload` direct external-OES lets Mesa detile
  - `v4l2convert` (plugins-good) does MM21 → MDP3 (works with K29)

## Test recipes (board; one at a time)

- **GStreamer**: `nerdctl run --rm --net=host --privileged -v /dev:/dev -v /root/vdec/vectors:/vectors --entrypoint gst-launch-1.0 vdec/gst-fluster filesrc location=X ! parsebin ! v4l2slvp9dec ! v4l2convert ! video/x-raw,format=YUY2 ! fakesink`
- **fluster**: `nerdctl run … -v /root/vdec/results:/results vdec/gst-fluster -ne run -j1 -t 60 -d GStreamer-H.264-V4L2SL -ts JVT-AVC_V1 -s -so /results/x.md`
- **FFmpeg**: `nerdctl run --rm --net=host --privileged -v /dev:/dev -v /opt/ffmpeg-vdec:/opt/ffmpeg-vdec:ro -v /root/vdec/vectors:/vectors vdec/ffmpeg-run ffmpeg -hwaccel v4l2request -hwaccel_output_format drm_prime -i X [-vf scale_v4l2m2m=format=uyvy[:w=W:h=H] | -vf hwdownload,format=nv12] -f null -`
- **MDP3 alone**: `v4l2-ctl -d /dev/video4 --set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 --set-fmt-video=width=1920,height=1080,pixelformat=YUYV --stream-out-mmap=4 --stream-mmap=4 --stream-count=30`
- **Kodi**: `le-media-kodi-vdec/kodi-test.sh <clip> <1=EGL|0=plane> [secs]` (run it through `40-tmux-run.sh` plus `board-watch.sh`). By hand: `docker save kodi-rockchip-gbm:trixie-v4l2requests | ssh board nerdctl load`, then `nerdctl run -it --rm --privileged --network host -v /dev:/dev -v /run:/run -v /srv/kodi:/root/.kodi <image> kodi --logging=console --windowing=gbm --audio-backend=alsa`.
  - Settings > Player: DRM PRIME on; render method EGL (`useprimerenderer=1`) vs DirectToPlane (0).
- After any test: `journalctl -k --since @T0 | grep 'iommu.*fault'`, and check for D-state tasks.

## Userspace work items (no IDs)

- [x] FFmpeg: rework onto armsoc-9.0.2, fix `vf_scale_v4l2m2m`, MM21 CPU detile, libdrm fallback, build script
- [x] Kodi: `mediatek-piers` with reworked MTK commits + DRMHelpers fallback
- [x] kodi-rockchip-deb: `mediatek-genio` (patches regenerated, backports Mesa, README); image `kodi-rockchip-gbm:trixie-v4l2requests` built with the MTK code verified compiled in
- [x] LibreELEC: `mediatek-genio` off master (PR commits + ffmpeg/kodi Mediatek gates and patch dirs; ffmpeg = chewitt tarball `ad8c2e36ee` + `patches/mediatek`)
- [x] Board baseline: scp.img, GStreamer/fluster (incl. H.264), FFmpeg CLI conformance
- [x] MDP3 hang: root cause and fix (K29)
- [x] Revert the FFmpeg cache-hint test hack; retest on the K26/K28/K29 kernel (no regressions; K28 confirmed)
- [x] MDP3 soak (pass) and FFmpeg AV1 on the K26 kernel (no panic; faults remain; lead: tiny show-existing-frame submissions)
- [x] Kodi on the board: EGL path (works; picture correct when the decode is)
- [x] FFmpeg H.264 B-frame corruption (pic_num wrap + stale marking size), conformance 100/135
- [x] Kodi DirectToPlane (MDP3) run: works
- [x] kodi-rockchip-deb FFmpeg patches regenerated (`6a72109`), image rebuilt, Kodi matrix 16/16 OK
- [x] Kodi 10-bit software fallback (both paths), patches refreshed in kodi-rockchip-deb and LibreELEC
- [x] LibreELEC `mediatek-genio`: FFmpeg H.264 fixes + Kodi fixes refreshed (`957538b1a0`, `424ce54491`)
- [x] Kodi seed dialogs: handled in the test script
- [ ] Upstream candidates: the two FFmpeg H.264 fixes (to chewitt / the v4l2-request series)
- [x] Audio: SOF firmware, HDMI `hw:0,5` + mixer routes; Kodi plays to HDMI (2.0)
- [ ] Blade3 (RK3588) mainline `snps_hdmirx`: why no audio capture? (would allow verifying NIO HDMI audio end to end)
- [x] Real-clip matrix (Jellyfin + BBB): 8-bit HW solid up to 4K150M; 10-bit 4K CPU-bound; AV1 10-bit crash found and fixed (verified)
- [x] BBB real use: 24p refresh switching, seeking, 3 min play, audio (2.0)
- [ ] Display: slow CRTC disable (vblank timeouts) on every mode switch; rdma/ethdr runtime-PM underflow
- [ ] Audio: multichannel / passthrough over HDMI; persistent mixer setup on CaptainOS/Armbian (UCM `sof-mt8395-evk`); upstream the UCM to alsa-ucm-conf?
- [ ] **Real-movie test** (see "Usability assessment"): 5.1 audio, 4K HEVC 10-bit HDR, VP9/AV1, 23.976 refresh switching, seeking, long playback
- [x] 10-bit display path: CPU MT2110 detile → P010 (FFmpeg + Kodi), 4K60 HEVC 10-bit at full rate
- [ ] AV1 10-bit 4K60 at 44/60 with the detile (headroom?); GPU detile in Mesa or MDP3 MT2110 (K27) as zero-CPU follow-ups; HDR output
- [ ] Colour rendition: EGL vs. plane (range/matrix)
- [ ] 10-bit fallback skips ahead at the reopen (keep the packets already queued?)
- [ ] Display-driver warnings: vblank timeout on crtc disable, rdma/ethdr runtime-PM underflow
- [ ] FFmpeg vs driver: VP8 1425/1436, AV1 tiles/SVC, H.264 WP/MR1, HEVC CONFWIN (diff the controls against GStreamer)
- [ ] `hwdownload` detile for MT2110 (10-bit), so 10-bit conformance can be checked
- [ ] LibreELEC: kernel 7.2 → 7.3 with the genio patches (incl. 3200–3202)
- [ ] Armbian: refresh 3200/3202 for 7.3.4 (needs_rebase)
- [ ] Upstream: K29 ping/resend (user decides)
- [ ] Later: 10-bit display (Mesa MT2110 detile? MDP3 MT2110 = K27); an Armbian extension for Kodi on genio; ask Sjoerd Simons about the NIO lab rig
