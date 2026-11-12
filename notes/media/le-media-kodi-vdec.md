# MediaTek Genio (MT8195/MT8395) HW video decode → Kodi (Armbian, then LibreELEC)

Started 2026-11-12. Board: Radxa NIO-12L (Genio 1200 / MT8395, Mali-G57).
- Goal: HW decode in Kodi (GBM/GLES, DRM PRIME) via the kodi-rockchip-deb container/deb on Armbian kernels, then port to LibreELEC.
- Plan and next steps: [le-media-kodi-vdec-plan.md](le-media-kodi-vdec-plan.md). Origin: [libreelec-pr-10891.md](libreelec-pr-10891.md).
- Kernel topics: K26 (vcodec `cap_to_disp` NULL guard), K27 (MDP3 MT2110 input) in `STATUS.md`. Userspace work has no IDs and is tracked here.

## Layout (`/opt/linuxdev/le-media-kodi-vdec/`)

Full clones made by `scripts/10-vm-clone-main.sh <repo>`. The remotes are in `remotes.tsv`; the prefix is the dir name.

| Dir | Remotes | Work branch (local, tracking fork) |
|---|---|---|
| `kodi-rockchip-deb` | `kodideb-armsurvivors` | `main` |
| `ffmpeg` | `ffmpeg-rpardini`, `ffmpeg-upstream`, `ffmpeg-kwiboo`, `ffmpeg-chewitt`, `ffmpeg-rpi` (jc-kynesim) | `mediatek-mm21-v4l2requests-opus` |
| `libreelec` | `le-rpardini`, `le-upstream`, `le-chewitt` | `mediatek-genio-wip` (PR head) |
| `kodi` | `kodi-rpardini`, `kodi-upstream` (xbmc) | `with-librelec-patches-and-mediatek-opus` |
| `gstreamer` | `gst-upstream` (monorepo) | detached `main` |
| `mesa` | `mesa-upstream` | detached `main` |
| `fluster` | `fluster-upstream` | detached `master` |
| `linux-firmware` | `linuxfw-upstream`, `linuxfw-armbian` | detached `main` |

- **Kernel:** `kernel/` with worktrees `kernel-<slug>`. The useful remotes are `kernel-collabora-mediatek` (fetched 2026-11-12) and `kernel-mediatek-aiot` (vendor `mtk-v6.6`, worktree `kernel-genio-mtk`).
- **Armbian:** `armbian-build` (branch `extensions`, shared with the CEC session). Genio edge = 7.3, `patch/kernel/archive/genio-7.3/`, `config/kernel/linux-genio-edge.config` (`VIDEO_MEDIATEK_VCODEC=y`, `MDP3=y`, `MTK_SCP=y`, `DRM_PANFROST=y`, `CEC_MTK=m`).
- Out-of-tree builds go in `le-media-kodi-vdec/out/` (not yet created).

## How it connects

```
SCP firmware (mediatek/mt8195/scp.img) ─┐
mtk-vcodec-dec (stateless, LAT+core) ───┴→ CAPTURE MM21 (8-bit) / MT2110T|R (10-bit), 2 non-contiguous planes
  └→ FFmpeg v4l2request hwaccel (hwcontext_v4l2request: DRM PRIME, 2 objects, MTK modifier)
       ├→ Kodi EGL path: eglCreateImage(NV12 + DRM_FORMAT_MOD_MTK_16L_32S_TILE) → panfrost compute detile → GLES (external OES)
       └→ Kodi DirectToPlane: MDP3 m2m (vf_scale_v4l2m2m) MM21 → UYVY/YUYV at dest size → KMS plane (LINEAR only, no scaling)
Packaging: kodi-rockchip-deb (Docker; v4l2requests flavor; container run via nerdctl on the board) → later LibreELEC project Mediatek/Genio
```

## Decisions (2026-11-12)

- **Board**: test on the current NIO-12L CaptainOS node (CAPI checks paused).
  - Kodi runs as a nerdctl container. FFmpeg CLI and fluster run in a `debian:trixie` container (`--privileged -v /dev:/dev`). The host only gets `scp.img`.
  - **No board writes while the CEC session (K23) is still testing on it.**
- **FFmpeg**: base `ffmpeg-chewitt/armsoc-9.0.2`. Iterate with a native build in a trixie container on this VM, then rsync to the board.
- **Mesa**: trixie + backports Mesa 26.1.6 in the Kodi container.
- **kodi-rockchip-deb**: MediaTek goes into the existing `v4l2requests` flavor. Kodi base is `Piers`.
- **Order**: debug "one frame then hang" outside Kodi first, then both display paths.
- **IDs**: kernel only (K26, K27).
- **LibreELEC**: new branch off `le-upstream/master`.
- **Trailers**: reworked commits drop `Co-Authored-By`/`Claude-Session` and get `Assisted-by: Claude:claude-opus-5-5`. No push without the user's OK.

## Board state (read-only check 2026-11-12)

- `root@192.168.66.83`, CaptainOS (CAPT k8s node image, Debian trixie, 276 packages), kernel 7.3.4-edge-genio (Armbian `linux-image-edge-genio`).
  - The CEC session has since installed its CEC build.
  - `/boot/extlinux/extlinux.conf` pins the kernel version: fix it after any kernel `dpkg -i`, before rebooting.
- Video devices: `video0` jpeg-dec, `video1` jpeg-enc, `video2` vcodec-enc, `video3` vcodec-dec, `video4` mdp3 m2m; `media0`. HDMI-A-1 connected.
- **There is no `/lib/firmware` at all**: `Direct firmware load for mediatek/mt8195/scp.img failed`, `mtk-vcodec-dec ... failed to load firmware!`. Nothing can decode until `scp.img` is installed.
  - It's in linux-firmware (`mediatek/mt8195/scp.img`, last changed `5e9fdab5` 2023-11) and in armbian/firmware `master`.
- containerd, nerdctl (`/usr/local/bin`), crictl and kubelet are present. `/` has 232 GB free. There's an SD card (`mmcblk1`, 59.5 GB).

## Findings

### Kernel (kernel-torvalds/master ~ v7.4-rc2+)
- **vcodec on 7.3:**
  - v7.3 already has every relevant fix: `1b78aae6313f4` manual request completion and `3e92d7e493508` VP9 422/444 both landed in v7.0.
  - v7.3..master adds only `ceb6e96122e10` (workqueue on remove) and `ff3308afa9c9d` (mdp3 ref leak).
- **Codecs on MT8195 (LAT+core):**
  - H.264/HEVC/VP9/AV1 use LAT, VP8 uses core. The actual list comes from the SCP capability bits (`mtk_vcodec_dec_drv.c` ~L263).
  - H.264/HEVC are FRAME_BASED + ANNEX_B only (`mtk_vcodec_dec_stateless.c` L70-82, L170-182).
  - Max levels: H.264 6.0, HEVC 5.2 Main10, VP9 5.2 Profile 2.
  - CAPTURE formats: MM21, plus MT2110T/R when the SPS is 10-bit (L543-556, L837-848). Two planes; `queue_setup` rejects a mismatch (`mtk_vcodec_dec.c` L768-787).
  - No `MIN_BUFFERS_FOR_CAPTURE` on stateless, and `allow_cache_hints=1`.
- **DRM planes** (`mtk_plane.c`):
  - only LINEAR (L23-26, L63-67)
  - `DRM_PLANE_NO_SCALING` in atomic_check and async_check (L250-254, L102-105)
  - OVL formats (`mtk_disp_ovl.c` L118-139) and ovl_adaptor/MDP-RDMA (`mtk_mdp_rdma.c` L63-75): RGB plus UYVY/YUYV, **no NV12, no MTK modifier**
  - no YUV rotation
  - The vendor tree and Collabora branches are the same.
- **MDP3** (`mdp_cfg_data.c` L1041-1250): MM21 is input-only at L1185. **MT2110T/R appears nowhere**: not in mainline, any Collabora branch, mediatek-aiot `mtk-staging`/`mtk-v6.6`/`mtk-v5.15-dev`, or `kernel-genio-mtk`. Both queues take MMAP and DMABUF.
- **Collabora** (`kernel-collabora-mediatek`):
  - `wip/mtk/mtk-staging` has `29c8b5f5bf593` "guard empty stateless capture queue" (NULL check in `mtk_vdec_stateless_cap_to_disp`; upstream would oops) → **K26**
  - `34bf231e51d9a`: longer IRQ timeout
  - MDP3 algorithm-in-kernel for MT8195 (`b4a4a915a26d8`…) and format fixes (`c1698e82ba85a`, `84528c6534b13`, …)
  - `mediatek-dev`: DRM multi-stage layers; no decoder changes

### FFmpeg
- **`mediatek-mm21-v4l2requests-opus`** = chewitt `rockchip-9.0.1` (`c04518bc5d`, the same commit LE Amlogic pins) plus:
  - `7af1eb2d5d` hwcontext MM21/MT2110 (`hwcontext_v4l2request.c` L116-140 formats, L222-239 two-object descriptor). Entries sit behind `#if defined` on libdrm `drm_fourcc.h` (MTK modifiers since uapi v6.15), so old headers silently drop them.
  - `f4fff38020`: deinterlace rejects non-linear or 2-object frames
  - `a0709aa65a`: new `vf_scale_v4l2m2m.c` (1007 lines)
  - All three carry `Co-Authored-By` and `Claude-Session` trailers. Fix them on rework.
- **Base match**: `ffmpeg-rpardini/rockchip-9.0.2` matches kodi-rockchip-deb's 22 patches exactly (same patch-ids).
  - `ffmpeg-chewitt/armsoc-9.0.2` (`ad8c2e36ee`) is a superset (+17). Notable extras:
    - `c403d2e930` cached CAPTURE (MTK allows it)
    - `53a9d46174` crop export
    - `afcf39410b` deinterlace stride
    - `4991439eb8`
    - VC-1, DoVi
- **Cherry-pick check** (merge-tree): 7af1eb2d5d and a0709aa65a are clean on both bases. **f4fff38020 conflicts**: both 9.0.2 bases accept 2-object NV12M (`064b026b90`, `b9472dbe27`), so rework it as a modifier-only check. NV12M uses the same "plane 1 in object 1" pattern, so a helper could be shared.
- **Decode path** (`v4l2_request.c`):
  - `initial_pool_size=1`; the CAPTURE pool grows with `CREATE_BUFS count=1` on demand (hwcontext L766-818), so a consumer holding frames can't starve it. The limit is 32 (vb2 limit and the `1<<index` masks).
  - Polls time out after 2 s and fail with EINVAL.
  - kwiboo `v4l2-request-n8.1` has nothing newer.
- **`vf_scale_v4l2m2m` hang suspects:**
  1. Only 6 OUTPUT/6 CAPTURE buffers (L944-946). CAPTURE is re-queued only when the AVFrame is freed. Kodi holds up to 6 in its render queue (`BaseRenderer.h:22` NUM_BUFFERS) plus the bridge's `m_buffer`/`m_prev_buffer` plus the codec frame, so the 1 s DQBUF timeout hits, then a hard error, then ENOMEM.
  2. Poll race (L569-582): a POLLOUT-only wakeup returns NULL. MDP3 marks src done before dst (`mtk-mdp3-m2m.c` L56-57).
  3. The output defaults to the input size and NV12, which the planes reject (no NV12, no scaling). It must be uyvy/yuyv at the exact destination rect.
  4. Minor: `enqueued` isn't atomic; the lowest free OUTPUT slot is re-mapped every frame; no `AV_NOPTS_VALUE` guard; no drain; the get_drm_frame chroma offset assumes a single object.
  5. Name clash: rpi-ffmpeg also defines `scale_v4l2m2m` (`ffmpeg-rpi/test/9.0.2/main`, `ffmpeg-chewitt/modifiers`).
  - Design reference: rpi's `vf_deinterlace_v4l2m2m.c` (8 OUTPUT/12 CAPTURE, `activate()`, EAGAIN, drain).

### Kodi
- **Branches:**
  - `with-libreelec-patches-26.08` = upstream `9dca7d125d` (2026-08-24) + drmprime-filter 0001/0002 (Kwiboo/Jernej; same patch-ids as LE and kodi-rockchip-deb)
  - `with-librelec-patches-and-mediatek-opus` adds the four MTK commits below
  - `Piers` branched from master at `08364e607a` (2026-10-02); the base is shared with both
- **The four MTK commits:**
  - `7dba228d61` EGLImage (`xbmc/utils/EGLImage.cpp` ~L268-288): `SupportsFormatAndModifier()` returns true for `MTK_16L_32S_TILE` without querying EGL. Probably unnecessary (see Mesa); only checks `objects[0]`.
  - `f2398e626e` DRMPRIMEEGL: `RequiresReimport()`/`RefreshEntry()` re-import MTK buffers on every cache hit (`GetOES`, `GetYUV`). Needed, because panfrost detiles once per sampler view.
  - `abe9319f6c` `GetConvertFilter()` (`DVDVideoCodecDRMPRIME.cpp` ~L980-1040): in DirectToPlane mode, any non-linear modifier gets `scale_v4l2m2m=format=uyvy` (+w/h of the screen) before the deinterlacer.
  - `d13d30ef62` software fallback: `CODEC_FORCE_SOFTWARE` plus `VC_REOPEN`, and 10-bit formats in `IsSupportedSwFormat`.
- **Bugs found:**
  - `GetConvertFilter` fires for AFBC and ALLWINNER_TILED too. Limit it to `DRM_FORMAT_MOD_VENDOR_MTK`, or ask `CDRMPlane::SupportsFormatAndModifier`.
  - `GetBuffer()` (L283-307) sizes only 8-bit formats, so the 10-bit software fallback fails.
  - `Reopen()` doesn't unref `m_pFrame`.
  - With limited-range colour, the YUV path (`GetYUV`, R8/GR88 with the MTK modifier) is tried first on every frame.
  - The re-import also runs on redraws (pause, GUI).
- **Multi-object dmabuf is already handled upstream:**
  - `DRMPRIMEEGL.cpp:84-90`
  - `EGLImage.cpp:135-149`
  - `VideoLayerBridgeDRMPRIME::CreateFramebuffer` L115-187
  - `DmaBufIdentity`
- **Upstream** (master and Piers) has no MTK modifier handling, no `scale_v4l2m2m` and no DRMPRIME filter graph.

### Mesa
- **Advertising**: panfrost advertises `DRM_FORMAT_MOD_MTK_16L_32S_TILE` (`0x0b00000000000001`) for NV12/R8/RG88 as **external-only**.
  - `pan_screen.c` `panfrost_walk_dmabuf_modifiers` ~L472-488
  - `PANFROST_EMULATED_MODIFIERS` in `pan_mod_conv_cso.h:104`
  - Not in `PAN_SUPPORTED_MODIFIERS`, but it still reaches `eglQueryDmaBufModifiersEXT`.
  - So sample via `GL_TEXTURE_EXTERNAL_OES`. If Kodi doesn't see it, look at Kodi's query or filtering, or at an old Mesa.
- **Detile path:**
  - import as fake-linear R8/RG88 (`pan_resource.c` `adjust_mtk_tiled_props` L101-140)
  - on sampler-view creation, `pan_resource_modifier_legalize` → `modifier_convert` → `panfrost_mtk_detile_compute` (`pan_cmdstream.c` L4004-4140), into a linear shadow
  - **Runs once per sampler view; it does not re-detile when a reused dmabuf gets new contents.**
  - CPU map of MTK resources looks broken (`pan_resource.c` L1746-1755). Use the GPU only.
- **No 10-bit MTK** in Mesa (no NV15 or MT2110). Works on panfrost and panthor alike; panvk has none.
- **Releases:**
  - 25.0.0: first (`f39194cdd32`)
  - 25.2.0: robust stride/extents (`eb476fd2c60`), the practical minimum
  - 26.3.0: shader-image fix `19022985a13` and race fix `63bb18ab73a`
- **Distro versions:** trixie 25.0.7 (too old), trixie-backports 26.1.6, LibreELEC 26.3.0.

### GStreamer (the reference; Nicolas Dufresne)
- **Formats:**
  - `NV12_16L32S` (MM21) since 1.22
  - `MT2110T`/`MT2110R` since 1.24 (`d604b3655e`; unpack/pack in `video-format.c` L7657-7955)
  - `DMA_DRM` mapping since 1.26 (`902f0eb9ea`, `video-info-dma.c` L572-574): MT2110T → NV15 : `0x0b00000000010001`, MT2110R → NV15 : `0x0b00000000020001`
- **MT2110 layout:**
  - Tiles are 16×32 Y (640 B) / 8×16 UV (320 B), in raster order.
  - Each tile is 80-byte partitions of 4 rows: 16 B of low 2-bit LSBs, then 64 B of high 8 bits.
  - T (LSB tiled): `lo[x] >> 2r`. R (LSB raster): `lo[r*4 + x/4] >> 2*(x%4)`. Chroma partition = `(y/4)/2`.
  - The high bytes alone give a cheap 8-bit fallback.
- **Elements:**
  - `v4l2codecs` (`gstv4l2format.c` L47-53) outputs DMA_DRM NV12:MTK.
  - `glupload` direct external-OES lets Mesa detile (`gstglupload.c:2010`); the indirect upload rejects non-linear modifiers.
  - GStreamer's own GL detile shader covers 8-bit only (`gstglcolorconvert.c` L440-479).
  - `v4l2convert` (gst-plugins-good) does MM21 → MDP3, with no MT2110 support.

## Test recipes (Phase B; containers on the board)

- **Firmware**: copy `le-media-kodi-vdec/linux-firmware/mediatek/mt8195/scp.img` to `/lib/firmware/mediatek/mt8195/`. Check with `v4l2-ctl -d /dev/video3 --list-formats-out-ext` and `dmesg | grep -i -e scp -e vcodec`.
- **Known-good GStreamer** (trixie 1.26):
  - `gst-launch-1.0 filesrc location=X ! parsebin ! v4l2slh264dec ! videoconvert ! video/x-raw,format=I420 ! fakesink`
  - `... ! v4l2slh264dec ! glimagesink` (caps should show `DMA_DRM`, `drm-format=NV12:0x0b00000000000001`)
  - `... ! v4l2convert ! video/x-raw,format=NV12 ! ...` (MDP3)
  - Swap in `v4l2slh265dec`, `v4l2slvp9dec` or `v4l2slav1dec`.
- **fluster conformance:**
  - decoders: `GStreamer-H.264-V4L2SL`, `GStreamer-H.265-V4L2SL`, `GStreamer-VP8-V4L2SL`, `GStreamer-VP9-V4L2SL`, `GStreamer-AV1-V4L2SL` (`fluster/decoders/gstreamer.py`)
  - e.g. `fluster.py run -d GStreamer-H.264-V4L2SL -ts JVT-AVC_V1`
  - FFmpeg has no v4l2request class: add a subclass with `hw_acceleration=True` and `api="V4L2Request"` (`ffmpeg.py` L83-91, L186-193). It needs MM21 `hwdownload`, i.e. a CPU detile in hwcontext.
- **FFmpeg CLI:**
  - `ffmpeg -hwaccel v4l2request -hwaccel_output_format drm_prime -i X -f null -` (frame count, stalls, dmesg)
  - then `-vf scale_v4l2m2m=format=uyvy:w=W:h=H`
- **Kodi container:** `nerdctl run -it --rm --privileged --network host -v /dev:/dev -v /run:/run -v /srv/kodi:/root/.kodi <image> kodi --logging=console --windowing=gbm --audio-backend=alsa`.
  - Settings > Player: DRM PRIME on; render method EGL (`useprimerenderer=1`) vs DirectToPlane (0).

## Userspace work items (no IDs)

- [ ] FFmpeg: rework onto armsoc-9.0.2, fix `vf_scale_v4l2m2m`, add a CPU MM21 detile for hwdownload, build script (plan A2)
- [ ] Kodi: `mediatek-piers` with the reworked MTK commits (plan A3)
- [ ] kodi-rockchip-deb: MTK in v4l2requests, trixie-backports Mesa (plan A4)
- [ ] LibreELEC: `mediatek-genio` off master (plan A5)
- [ ] Board baseline: scp.img, GStreamer/fluster, FFmpeg CLI, Kodi (plan B)
- [ ] Later: 10-bit (Mesa MT2110 detile shader upstream? MDP3 MT2110 = K27); an Armbian extension for Kodi on genio (like `extensions/kodi-gbm-rkmpp.sh`); ask Sjoerd Simons about the NIO lab rig
