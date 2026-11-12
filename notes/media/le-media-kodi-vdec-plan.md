# Plan: MediaTek vdec → Kodi (le-media-kodi-vdec)

Copied from the 2026-11-12 Claude plan session. Findings: [le-media-kodi-vdec.md](le-media-kodi-vdec.md).

## How to resume

- Done (2026-11-12):
  - Phase 0: clones; commits `f4d2536` (clone script + `remotes.tsv`) and `40aa1fc` (tmux ssh agent)
  - A1: notes, K26/K27, AGENTS row
  - B1: `scp.img` on the board, decoder up
  - B2: GStreamer fluster baseline (see the main note)
  - A2: FFmpeg `mediatek-mm21-armsoc-9.0.2`: libdrm fallback defines (root cause of no HW decode), scale filter buffer accounting, MM21 detile, deinterlace modifier check. Build loop `scripts/50-media-ffmpeg-build.sh`
  - A3: Kodi `mediatek-piers`: DRMHelpers fallback, vendor-gated convert filter with aspect-fit size, GetBuffer 10-bit, Reopen unref, OES-only for MTK. Applies on LE's 22.0rc2-Piers too
  - A4: kodi-rockchip-deb `mediatek-genio` (patches regenerated, Mesa from backports, README)
  - A5: LibreELEC `mediatek-genio` (PR commits on master, ffmpeg/kodi Mediatek gates and patch dirs). **Kernel still v7.2**: the bump to the Armbian genio-7.3 patch set is pending
- Open:
  - B3: MDP3 hang (main note, "one frame then hang"). Needs a board reboot to unwedge MDP3, then isolated repro
  - B3: FFmpeg conformance (`results/ffmpeg-*.txt`), VP8 recheck in isolation
  - B4: Kodi container on the board (kodi-deb image built on the VM; rebuild with refreshed patches)
  - B5: K26 into Armbian genio-7.3
  - H.264 vectors: the ITU WAF blocks fluster downloads
- Board writes and kernel installs need the user's OK. The CAPT `extlinux.conf` pins the kernel version.
- Nothing is pushed: the branches above live only in the local clones.

## Context

On the NIO-12L (MT8395/Genio 1200), hardware decode in Kodi got as far as "one frame, then hang", in both EGL and DirectToPlane modes ([LibreELEC PR #10891](https://github.com/LibreELEC/LibreELEC.tv/pull/10891)).
Phase 0 is done:
- clones are under `/opt/linuxdev/le-media-kodi-vdec/`
- `remotes.tsv` and the scripts are updated (commits f4d2536 and 40aa1fc)

This plan covers:
- notes and tracking
- reworking the FFmpeg, Kodi, kodi-rockchip-deb and LibreELEC branches with the bugs the exploration found
- a fast native FFmpeg build loop
- board tests on the CaptainOS node, but only after the CEC session is finished with the board

### Decisions so far
- **Board**: tests run on the current CaptainOS node (CAPI checks paused).
  - Kodi runs in a nerdctl container. FFmpeg tests run in a `debian:trixie` container. The host only gets `scp.img`.
  - The CEC session is done (2026-11-12); the board is ours. extlinux pins the kernel version.
- **FFmpeg**: rework on `ffmpeg-chewitt/armsoc-9.0.2`. Iterate with a native build (in a trixie container on this VM) plus rsync.
- **Mesa**: the Kodi container uses trixie + backports Mesa 26.1.6.
- **kodi-rockchip-deb**: MediaTek goes into the existing `v4l2requests` flavor. Kodi base is `Piers`.
- **Debugging**: debug the hang first, outside Kodi, then work both paths (EGL and MDP3→plane).
- **Tracking**: kernel IDs only, K26 and K27. Userspace is tracked in notes.
- **LibreELEC**: new branch off `le-upstream/master`.
- **Commits**: when reworking commits, drop `Co-Authored-By`/`Claude-Session` and use `Assisted-by: Claude:claude-opus-5-5`. Nothing is pushed without your OK.

### Key findings that shape the work
- **Firmware**: the node has no `/lib/firmware`. `mediatek/mt8195/scp.img` is missing, so `mtk-vcodec-dec` can't load firmware. Upstream linux-firmware and armbian/firmware `master` both have it.
- **Mesa**: panfrost has advertised `DRM_FORMAT_MOD_MTK_16L_32S_TILE` to EGL as external-only since 25.0.
  - So the Kodi `EGLImage` bypass is probably unnecessary. Verify on the board.
  - 25.2 fixed stride and padded-row handling; trixie's 25.0.7 lacks it.
  - The detile is done once per sampler view, so Kodi must re-import every frame. Kodi commit `f2398e626e` does this.
- **Planes**: MT8195 planes take only LINEAR UYVY/YUYV/RGB, with `DRM_PLANE_NO_SCALING`. DirectToPlane therefore needs MDP3 output in uyvy/yuyv at exactly the destination rect size.
- **10-bit**: MT2110T/R is not supported in Mesa or MDP3 anywhere, vendor trees included. GStreamer has the CPU detile algorithm (`video-format.c:7657-7955`).
- **Hang suspects** (unconfirmed):
  - `vf_scale_v4l2m2m`: only 6 CAPTURE buffers, hard error after a 1 s DQBUF timeout, and a POLLOUT-only wakeup treated as fatal.
  - Kodi can hold 6 or more frames, plus the bridge's `m_buffer`/`m_prev_buffer`.
  - The decoder pool grows on demand (up to 32), so it's not the culprit.
- **Kodi MTK patch bugs**:
  - the convert filter triggers on any non-linear modifier (would hit AFBC and Allwinner)
  - the 10-bit software fallback fails in `GetBuffer`
  - `Reopen()` leaks `m_pFrame`
  - with limited-range colour, the YUV path is tried every frame first

## Phase A: no board writes (start now)

### A1. Notes and tracking (`linuxdev-status`)
- `notes/media/le-media-kodi-vdec.md`, the main note:
  - repo layout and remotes
  - how the pieces connect: kernel vcodec/MDP3/DRM → FFmpeg v4l2request → Kodi DRMPRIME (EGL or plane) → kodi-rockchip-deb container → LibreELEC port
  - decisions, the findings above with file:line refs, and the test recipes
  - userspace work items, tracked here since they have no IDs
- `notes/media/libreelec-pr-10891.md`, the PR note:
  - state (draft, 8 commits, kernel v7.2)
  - reviewers' guidance: chewitt on RPi FFmpeg quirks; ndufresne on MM21 plumbing, MDP3 colour conversion, scp firmware, the GStreamer MT2110 reference and the Sjoerd Simons lab tip
  - your Aug results and the power-button workaround
  - which branches hold what (`mediatek-genio-wip`, `-v1`, `master-26.08-rpardini`)
- `STATUS.md`:
  - kernel table rows:
    - **K26**: mtk-vcodec stateless `cap_to_disp` NULL guard, Collabora `29c8b5f5bf593`. Pick onto v7.3, carry in Armbian genio edge, check whether it's upstream-bound.
    - **K27**: MDP3 MT2110T/R input. Research, no branch yet.
  - a short "MediaTek vdec / Kodi" section pointing to the notes
- `topics.tsv`: K26 as a `pick` row (`mainline/mtk-vcodec-cap-to-disp-guard`, base v7.3). K27 is handled the way the CEC session did K24/K25 (check their rows first).
- `AGENTS.md` layout table: add a `le-media-kodi-vdec/` row.
- Memory: add a project memory, `mediatek-vdec-kodi.md`, with a pointer in MEMORY.md.
- One commit, path-limited (the CEC session also edits STATUS.md; check `git status` first and don't sweep up its changes).

### A2. FFmpeg (`le-media-kodi-vdec/ffmpeg`)
- New branch `mediatek-mm21-armsoc-9.0.2` off `ffmpeg-chewitt/armsoc-9.0.2`.
  - cherry-pick `7af1eb2d5d` (MM21/MT2110 hwcontext) and `a0709aa65a` (`vf_scale_v4l2m2m`)
  - rework `f4fff38020` as a modifier-only check, so linear 2-object NV12M still passes
  - fix the trailers
- Fix `vf_scale_v4l2m2m`. Use rpi-ffmpeg's `vf_deinterlace_v4l2m2m` (`ffmpeg-rpi/test/9.0.2/main`) as the design reference.
  - 12 CAPTURE buffers, and EAGAIN instead of hard errors
  - the dequeue poll loops until POLLIN
  - `AV_NOPTS_VALUE` guard
  - atomic `enqueued`
  - drain at EOF
  - document that the output must be uyvy/yuyv at the destination size
- A CPU MM21 detile in the hwcontext `transfer_data_from`, so `hwdownload` works and decodes can be checksum-checked (fluster).
  - MT2110 is a stretch, ported from GStreamer's unpack functions.
- Build loop: `linuxdev-status/scripts/50-media-ffmpeg-build.sh`.
  - Runs a `debian:trixie` container on this VM (docker is present, so no host apt), with trixie-backports `linux-libc-dev`.
  - The source tree is bind-mounted, the build dir is incremental, and it installs into `le-media-kodi-vdec/out/ffmpeg-vdec` (prefix `/opt/ffmpeg-vdec`, shared libs).
  - Configure flags match kodi-rockchip-deb's v4l2requests stage, plus `--enable-v4l2-request --enable-libudev` (to be confirmed against `configure`).
  - Runs through `40-tmux-run.sh`; the window is named `ffmpeg-vdec-build`.

### A3. Kodi (`le-media-kodi-vdec/kodi`)
- New branch `mediatek-piers` off `kodi-upstream/Piers`, with:
  - drmprime-filter 0001/0002, the same patch-ids as kodi-rockchip-deb
  - the 4 MTK commits, reworked:
    - the EGLImage bypass is kept but only used if the EGL query really lacks the modifier (decided after the board test)
    - `GetConvertFilter` only for `DRM_FORMAT_MOD_VENDOR_MTK`, with w/h taken from the plane's destination rect
    - `GetBuffer` handles the 10-bit software formats
    - `Reopen()` unrefs `m_pFrame`
    - skip the YUV path for MTK modifiers
  - consider porting LE Rockchip's "VideoLayerBridgeDRMPRIME: release buffer early" to Piers
- Build check: compile Kodi in the kodi-rockchip-deb Docker build (A4).

### A4. kodi-rockchip-deb (`le-media-kodi-vdec/kodi-rockchip-deb`)
- New branch `mediatek-genio` off `main`. In the v4l2requests flavor:
  - FFmpeg = chewitt armsoc-9.0.2 plus our MTK patches. Either regenerate `patches/ffmpeg/v4l2requests/` from our branch, or clone the branch (to decide when implementing).
  - Kodi patch set `mediatek`, exported from `mediatek-piers`.
  - Pin Mesa/libgbm/libegl/libgles from trixie-backports (same mechanism as `linux-libc-dev`).
  - Optional: an `ffmpeg-only` target that outputs the `/opt/ffmpeg-vdec` tree as a .deb for releases.
  - README and credits updates.
- Build `FLAVOR=v4l2requests DISTRO=trixie BUILD_CONTAINER=yes ./build.sh` via `40-tmux-run.sh` (window `kodideb-v4l2requests`).
  - Get the image to the board with `docker save | ssh … nerdctl load`, only in Phase B.

### A5. LibreELEC (`le-media-kodi-vdec/libreelec`)
- New branch `mediatek-genio` off `le-upstream/master`, built from:
  - the 8 PR commits (`mediatek-genio-wip`), rebased
  - the media commits from `master-26.08-rpardini`, cleaned up:
    - `Mediatek` added to the v4l2-request gate and the `vf-deinterlace-v4l2m2m` dirs
    - FFmpeg source = chewitt armsoc-9.0.2 commit, plus `patches/mediatek/` from A2
    - Kodi `drmprime-filter` gate gets `Mediatek`, plus the A3 MTK patches
    - the "HEREHEREHERE" echo dropped
  - kernel bumped to match Armbian genio edge, with the NIO-12L DT and ASoC patches
- No LE image build in this phase unless you ask (it takes hours). No push.

## Phase B: board (only after the CEC session hands the NIO-12L over)

I'll ask the CEC session (via SendMessage) to tell me when it's done, and confirm with you before the first write.

1. **Firmware**: copy `scp.img` from the linux-firmware clone to `/lib/firmware/mediatek/mt8195/`. Retry the vcodec open with `v4l2-ctl -d /dev/video3 --list-formats-out-ext`; if the driver doesn't retry the firmware load, ask you before unbind/bind or a reboot.
2. **Baseline (validates kernel and firmware)**:
   - a trixie container with GStreamer 1.26 `v4l2codecs`, plus fluster
   - runs `GStreamer-{H.264,H.265,VP9,AV1}-V4L2SL` on JVT-AVC_V1, JCT-VC-HEVC_V1, VP9-TEST-VECTORS and AV1 vectors
   - pass/fail per suite into the note
3. **FFmpeg**: rsync `out/ffmpeg-vdec` and run in a trixie container (`--privileged -v /dev:/dev`).
   - `-hwaccel v4l2request -hwaccel_output_format drm_prime … -f null -`: count frames, watch dmesg
   - then `-vf scale_v4l2m2m=format=uyvy`
   - then fluster with a new FFmpeg V4L2Request decoder class (local fluster branch), using the A2 hwdownload detile
4. **Kodi container** with sample clips (1080p/4K H.264/HEVC/VP9/AV1, one 10-bit):
   - EGL path (`useprimerenderer=1`), then DirectToPlane
   - collect Kodi debug logs and dmesg, and record which hang suspects held
5. **K26**: carry the patch in Armbian `patch/kernel/archive/genio-7.3/` once the CEC session is done with `armbian-build`. Kernel install and reboot only with your OK, following the extlinux rule.

## Verification
- **A2**: the FFmpeg build succeeds in the container. `ffmpeg -hwaccels` lists `v4l2request`; `-filters` lists `scale_v4l2m2m`. `git log` shows only `Assisted-by` trailers.
- **A3/A4**: the kodi-rockchip-deb v4l2requests build passes its decoder/protocol checks. Inside the image, `dpkg -l | grep mesa` shows 26.1.6.
- **A5**: `PROJECT=Mediatek DEVICE=Genio ARCH=aarch64 scripts/checkdeps`, plus a `make` dry pass of the ffmpeg package (`scripts/unpack ffmpeg`) applies all patches.
- **B**: fluster GStreamer V4L2SL pass rates recorded. FFmpeg CLI decodes whole clips with no stall. Kodi plays past the first frame in both paths, or the note pins down the stall with logs.
- **linuxdev-status**: `scripts/03-verify.sh` dry run is still OK, and the IDs in STATUS.md and topics.tsv are in sync.
