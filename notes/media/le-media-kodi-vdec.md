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

## Status (2026-11-12 evening)

- **Board**: Armbian genio edge 7.3.4 build #3 with patches 3200 (K29), 3201 (K26) and 3202 (K28), plus `scp.img`. Decoder and MDP3 work.
- **Decoding (hardware, through FFmpeg and GStreamer)**: H.264, HEVC, VP8, VP9 and AV1 decode correctly on the hardware, apart from the open FFmpeg issues below. Conformance tables are under "Results".
- **"One frame then hang" (DirectToPlane): fixed.** Root cause was a mainline regression: the MDP3 part (3/3) of the GCE pm_runtime series never merged while 1/3 did (v6.18). That's K29. MDP3 now converts 1080p at about 210 fps (FFmpeg `scale_v4l2m2m`) and GStreamer `v4l2convert` works too.
- **FFmpeg on Debian trixie decoded nothing in hardware**: libdrm 2.4.124 lacks the MTK modifiers, which compiled MM21 out. Fixed in FFmpeg and Kodi with `#ifndef` fallbacks.
- **Open issues (FFmpeg vs. the MTK driver)**:
  - VP8 `segmentation-1425`/`1436` decode wrong (1425 also IOMMU-faults the decoder)
  - AV1 tile and SVC vectors IOMMU-fault the decoder; before K26 one panicked the kernel
  - H.264 `CAWP5`/`CVWP5`/`MR1_BT_A` and HEVC `CONFWIN_A` mismatch
  - GStreamer passes all of these, so FFmpeg's controls differ from what the driver/firmware expects.
- **Not yet tested**: Kodi itself on the board, both the EGL and DirectToPlane paths.
- **Branches**: FFmpeg `mediatek-mm21-armsoc-9.0.2`, Kodi `mediatek-piers`, kodi-rockchip-deb `mediatek-genio`, LibreELEC `mediatek-genio` (kernel still 7.2), armbian-build `extensions` (`8c93af5e2`).

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
- **Kodi container** (not run yet): `docker save kodi-rockchip-gbm:trixie-v4l2requests | ssh board nerdctl load`, then `nerdctl run -it --rm --privileged --network host -v /dev:/dev -v /run:/run -v /srv/kodi:/root/.kodi <image> kodi --logging=console --windowing=gbm --audio-backend=alsa`.
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
- [ ] MDP3 soak and FFmpeg AV1 on the K26 kernel (need the user at the board)
- [ ] Kodi on the board: EGL and DirectToPlane paths
- [ ] FFmpeg vs driver: VP8 1425/1436, AV1 tiles/SVC, H.264 WP/MR1, HEVC CONFWIN (diff the controls against GStreamer)
- [ ] `hwdownload` detile for MT2110 (10-bit), so 10-bit conformance can be checked
- [ ] LibreELEC: kernel 7.2 → 7.3 with the genio patches (incl. 3200–3202)
- [ ] Armbian: refresh 3200/3202 for 7.3.4 (needs_rebase)
- [ ] Upstream: K29 ping/resend (user decides)
- [ ] Later: 10-bit display (Mesa MT2110 detile? MDP3 MT2110 = K27); an Armbian extension for Kodi on genio; ask Sjoerd Simons about the NIO lab rig
