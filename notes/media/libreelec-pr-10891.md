# LibreELEC PR #10891: "Mediatek: add initial project with Genio device"

<https://github.com/LibreELEC/LibreELEC.tv/pull/10891>. Read in full 2026-11-12. Main note: [le-media-kodi-vdec.md](le-media-kodi-vdec.md).

## State

- Draft, open since 2026-01-11, last update 2026-09-27. Head is `rpardini:mediatek-genio-wip` @ `da9e55d7c2`, against `master`. 8 commits, 31 files.
- Commits (all mine):
  - `f497eaeb7c` u-boot: don't build anything if config == `none`
  - `cd0301de81` uboot-helper: nio-12l with `none` config + dt
  - `4683363aeb` pkg/linux: kernel v7.2 for Mediatek + patches (NIO-12L DT: UFS lanes, i2c2/3, LEDs; ASoC DAI-link fix)
  - `73aa730246` Mediatek: initial project with Genio device (fake `none` u-boot; SSH always on via cmdline)
  - `5ca91c28ac` alsa-lib: enable ucm+topology
  - `984063348c` Genio: alsa ucm2 config (from Collabora's Debian 13 build)
  - `f18f3dd693` dthelper: add mediatek
  - `da9e55d7c2` soundconfig for mediatek forces `alsactl init`
- Boot stack is not included. Use Armbian's (`./compile.sh BOARD=radxa-nio-12l BRANCH=edge RELEASE=trixie EXT=ufs,mtkflash,u-boot-menu` flashes UFS), then boot LE from SD. The u-boot env is in boot1 at offset 0x200000.
- Aug 2026 test with v7.2:
  - works: HDMI and HDMI audio, Panfrost, WiFi/BT, UFS/SD (the image only boots from SD; UFS needs 4k sectors), USB3, Ethernet
  - doesn't work: CEC (now K23), HW decode, analog audio
  - HW decode stalls with DirectToPlane and falls back to SW with EGL. The CPU decodes 4K AV1 at 75+ °C.
- scp firmware was confirmed loaded on LE: `remoteproc0: Booting fw image mediatek/mt8195/scp.img`, `cherry_scp_v2.0.23042-e27728578`.

## Reviewer guidance

- **chewitt** (2026-01-12):
  - no objection to merging if Kodi is usable
  - try the RPi FFmpeg sources he uses for Amlogic (better `v4l2_m2m`, quirks code in `libavcodec/v4l2_m2m_dec.c`)
  - 2026-08-21: "minimal image on current versions welcome", or park it
- **ndufresne** (Collabora):
  - 2026-01-12: playback needs MM21 (and the 10-bit variants) plumbed into the FFmpeg fork and Kodi's GPU path, or MDP3 colour conversion for GPU-less playback.
  - 2026-01-21: check the scp firmware is installed. It's in linux-firmware, but not everyone ships it.
  - 2026-08-24: DirectToPlane works from MDP3 to the plane, not from the codec to the plane, on MTK. Libyuv, skia, GStreamer and recent Mesa have detile shaders, so MDP can be skipped. He was checking on CEC plans.
  - 2026-08-25: for 10-bit, look at GStreamer. He wrote MT2110T/MT2110R there. The MDP3 mapping is missing, with no patches on the list; maybe it can be taken from vendor TV stacks.
  - 2026-08-25: ping Sjoerd Simons about rigging NIOs in a lab. The board draws power from both USB ports and won't reboot if it doesn't draw enough.
- **My 2026-08-25 attempt** (Opus):
  - FFmpeg: MM21 → `DRM_FORMAT_NV12` + `DRM_FORMAT_MOD_MTK_16L_32S_TILE`, as a two-object descriptor.
  - Kodi: bypassed the EGL modifier check, believing panfrost doesn't advertise the modifier. **That was wrong**: Mesa ≥ 25.0 advertises it as external-only (see the main note).
  - Result: one frame in EGL mode, then a hang.
  - Then a new `vf_scale_v4l2m2m` (MDP3, MM21→UYVY plus downscale, because `mtk_plane_atomic_check` passes `DRM_PLANE_NO_SCALING`). One frame via DirectToPlane, then a hang.
  - 10-bit was abandoned: no MDP3 entry, no panfrost importer, not scanout-capable.
  - Promised to add the v4l2request enablement to the PR. Not done in the PR branch; it's in `master-26.08-rpardini`.
- **Power-on workaround** (2026-08-25): after a power cut the board needs the power button. A Type-A→Type-C cable from the board's own Type-A port to the D/L USB-C port feeds VBUS to CHRDET, so it boots by itself (lab-able).

## Where the work lives (rpardini/LibreELEC.tv)

| Branch | What | Base |
|---|---|---|
| `mediatek-genio-wip` | the PR (8 commits, kernel v7.2) | `54eca63dd0` (2026-08-23), 1222 behind master |
| `mediatek-genio-wip-v1` | older version: own kernel (rpardini/linux `00b5f937`, 6.19-rc4 + Collabora/Armbian), DTB `-extra` | 2026-01-11, 4252 behind |
| `master-26.08-rpardini` | wip series **plus the media stack**, 60 ahead / 1177 behind | `da49141f4f` |
| **`mediatek-genio`** (2026-11-12) | the 8 PR commits rebased cleanly on master, plus `ffmpeg: Mediatek: chewitt armsoc-9.0.2 plus MM21 support` and `kodi: Mediatek: drmprime-filter plus MediaTek patches`; patches refreshed 2026-11-12 evening (`957538b1a0`: FFmpeg H.264 B-frame fixes + Kodi 10-bit fallback; `424ce54491`: Kodi GLES fallback for plane-rejected buffers). The Kodi patches apply on `22.0rc2-Piers`. **Kernel still v7.2** (needs 7.3 + K29/K26/K28) | `le-upstream/master` `01a57f984b` |

The media commits on `master-26.08-rpardini`:
- `a7cbf90cfa`: ffmpeg `Mediatek)` case, chewitt `837d8c2f` (`rockchip-9.0.1`) + `PKG_PATCH_DIRS+=" mediatek"`
- `80c13785ad`: `Mediatek` added to the v4l2-request gate (with a stray `echo "...HEREHEREHERE"`) and testing muxers instead of `--disable-programs`
- `be3591ab0c`: `Mediatek` added to the Kodi `drmprime-filter` gate
- `bf9b9983a7`, `0377698aa0`: Kodi patches `drmprime-filter/0003-0006` (MTK) and ffmpeg `patches/mediatek/0001-0003`. These are the same as the FFmpeg branch `mediatek-mm21-v4l2requests-opus` and the Kodi branch `with-librelec-patches-and-mediatek-opus`.

## What a `PROJECT=Mediatek` hits in le-upstream/master (checked 2026-11-12)

- **`packages/multimedia/ffmpeg/package.mk`**:
  - Source is the 9.0.2 tarball unless the project gets its own case. Amlogic/Rockchip use chewitt `armsoc-9.0.2` / `${PROJECT,,}-9.0.2`.
  - Line ~44 `*)`: Mediatek gets `v4l2-request v4l2-drmprime`. `vf-deinterlace-v4l2m2m` is only for `Allwinner | Rockchip` (47-49), and the MTK ffmpeg patch 0002 needs it.
  - **Line ~73 gate:** only Allwinner, Amlogic and Rockchip projects (plus iMX8/RPi4/RPi5 devices) get `--enable-libudev --enable-v4l2-request`. Mediatek falls through to `--disable-v4l2-request`.
  - `V4L2_SUPPORT=yes` comes from `config/graphic:102-106` (panfrost in `GRAPHIC_DRIVERS`).
  - LE's `v4l2-request/0001` has no MM21; plane 1 is hard-coded to object 0. So MTK patch 0001 is required.
- **`packages/mediacenter/kodi/package.mk`**:
  - `22.0rc2-Piers`; GBM and GLES.
  - `drmprime-filter` only for Allwinner, Amlogic and Rockchip (line 243).
  - Non-Generic projects get `config/appliance-gbm.xml` with `useprimerenderer=0` (DirectToPlane) by default.
- **`packages/graphics/mesa/package.mk`**: 26.3.0, which has every panfrost MTK detile fix.
- **Other:**
  - Genio's `appliance.xml` sets `videoplayer.primeallowhwdeinterlace`, which does nothing without the Amlogic/RPi hwdeinterlace patch.
  - `projects/Rockchip/patches/kodi/0001-VideoLayerBridgeDRMPRIME-release-buffer-early.patch` (a buffer-lifetime fix) no longer applies to rc2 (`m_fb_id` refactor). Worth porting for MTK.
- **le-chewitt**: no MediaTek work. Its `rockchip` branch carries kernel `rockchip-0131-FROMLIST-v3-media-mediatek-vcodec-bound-AV1-tile-sta.patch`, which upstream has as `37bef2170d4c8`.

## Plan for the PR

Branch `mediatek-genio` (off `le-upstream/master`) is done except the kernel:
- **ffmpeg**: `Mediatek)` case = chewitt tarball `ad8c2e36ee` (`armsoc-9.0.2`, sha256 `eed6678e…`, includes v4l2-request and the m2m deinterlace) + `PKG_PATCH_DIRS+=" mediatek"`. The 5 patches come from FFmpeg branch `armsoc-9.0.2-mediatek`. Mediatek is added to the v4l2-request/libudev gate and the VERSION file.
- **kodi**: `Mediatek` added to the `drmprime-filter` gate, plus `patches/mediatek` (6 patches from Kodi branch `mediatek-piers`). They apply on `22.0rc2-Piers`.
- **Kernel, still to do**: bump to 7.3 to match Armbian genio edge, and carry:
  - **K29** (mtk-mdp3 GCE pm_runtime): **the August "one frame then hang" in DirectToPlane is almost certainly this**. Any kernel ≥ v6.18 without it hangs MDP3. LE's v7.2 kernel has the bug.
  - **K26** (vcodec empty capture queue guard; FFmpeg AV1 streams can panic without it)
  - **K28** (vb2 dma-contig cache sync, needed by chewitt's cached CAPTURE buffers; LE has it only for Amlogic as `amlogic-0116`)
  - The Armbian genio-7.3 patch files `3200`–`3202` are ready to copy.
- No LE image built or tested yet. Force-pushing or updating the PR branch is the user's call.

## For the PR description (2026-11-12)

- Tested in the kodi-rockchip-deb container on the NIO-12L with the same FFmpeg/Kodi patches. See `le-media-kodi-vdec.md` "Usability assessment" and the screenshots in `notes/media/img/`.
- The August "one frame then hang" was the kernel (MDP3 GCE pm_runtime, K29), not LibreELEC.
