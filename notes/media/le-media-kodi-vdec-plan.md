# Plan: MediaTek vdec → Kodi (le-media-kodi-vdec)

Copied from the 2026-11-12 Claude plan session. Findings: [le-media-kodi-vdec.md](le-media-kodi-vdec.md).

## How to resume

In a new session, say "continue the MediaTek vdec plan in `notes/media/le-media-kodi-vdec-plan.md`". Read the main note's **Status** section first.

- **Done (2026-11-12)**:
  - Phase 0, A1–A5 and B1–B3: clones; notes; FFmpeg/Kodi/kodi-deb/LE branches; board firmware; GStreamer and FFmpeg conformance incl. H.264
  - **MDP3 hang root-caused and fixed (K29)**
  - Board kernel: Armbian genio edge build #3 with 3200 (K29), 3201 (K26), 3202 (K28); armbian-build `8c93af5e2`
- **Rules**:
  - Ask the user before anything that might hang or crash the board. Recovery is a long power-off by the user.
  - Kernel installs and reboots need an OK. The CAPT `extlinux.conf` pins the kernel version.
  - Run one decode test at a time. Don't read clk/genpd debugfs on a hung board.
  - Nothing is pushed and nothing goes to lists without an OK.

**Resume here (2026-11-13 ~18:10)**: the NIO runs LE image #3 at the TV. Read the main note's Status + "LibreELEC on the TV".
- LE `mediatek-genio` on top of `7cf2fccd61` (nothing pushed):
  - `6de0ba275e` GUI limit/HDMI audio defaults
  - `c9d1833dd9` module autoload + `NR_CPUS=8`
  - `d8ee45e1c0` cmdline
  - `d81abf04ae` `TYPEC_MT6360=m`
  - `4c26c67451` HDMI S32 via linear plugin (not in an image yet; board uses the autostart.sh bind mount)
- Next (ask the user):
  - lockup: image #3 soak clean (4173 iterations / 73 min); confirm over more boots and Kodi restarts; if it hangs again, `modprobe.blacklist=tcpci_mt6360`
  - HDR output on LE
  - IRQ 116 root cause
  - suspend/resume WDT
  - a Mediatek `bootloader/update.sh` (so `.tar` updates refresh extlinux)
  - LE PR #10891 update + screenshots (the user's)
  - CaptainOS control soak
- Soak script on the board: `/storage/.cache/ipi-soak.sh` (unit `ipi-soak`, stop with `touch /storage/.cache/ipi-soak.stop`).

**Update 2026-11-13 ~14:45**: the NIO is at the TV, running the LE SD image. See the main note, "LibreELEC on the TV": GUI scaling ERANGE fixed on the board (LE appliance fix to do), HDMI audio default to do, lost-IPI lockup noted. No image rebuild until the user asks; fix the running board first.
- **Open (later, user)**:
  - root-cause the MT6360 TCPC IRQ 116 storm (seen on Armbian and LE; leads in the main note)
  - lost-IPI lockup control soak on CaptainOS from UFS
  - suspend/resume ends in a HW watchdog reset (needs `loglevel=7` UART logs)

**Resume here (2026-11-13 ~04:00; next session in 1–2 days)**: read the main note's Status, "Housekeeping", "Armbian PR prep", "Rockchip baseline" and "Parked".
- **State**:
  - NIO: Armbian kernel build #3 (3200–3202, no 3203) on UFS; Kodi image `kodi-rockchip-gbm:trixie-v4l2requests` from kodi-rockchip-deb `9008c03`; FFmpeg in `/opt/ffmpeg-vdec` = `armsoc-9.0.2-mediatek` HEAD `abcf34a935`. **SD card (`/dev/mmcblk1`) holds the LibreELEC Genio image** (written + read-back verified 2026-11-13; it wiped a Switch exFAT card, with the user's OK). **The user boots it** (not done yet).
  - Blade3: vdec images, Kodi image, vectors, clips, `/opt/ffmpeg-vdec`; baseline done (AV1 intrabc-extreme-dv vector hard-hangs it: never run it there).
  - Repos: FFmpeg `armsoc-9.0.2-mediatek` (tracks `ffmpeg-rpardini/armsoc-9.0.2-mediatek`); Kodi `mediatek-piers`; kodi-rockchip-deb `main` (always work on main); LibreELEC `mediatek-genio` (5 squashed commits on current master, backups `backup/mediatek-genio-pre-*`); armbian-build `extensions` (tracks `armbian-armsurvivors/extensions`; genio CEC + media commits last, the user cuts PRs with prtool).
- **Next, in order** (ask the user first):
  1. When the user has booted the LE SD image on the NIO: test Kodi in LibreELEC over JSON-RPC + Blade3 capture: both paths, 8/10-bit clips (copy clips or a share), audio via UCM, CEC (with the Blade3 as the CEC peer), screenshots.
  2. LE PR #10891 update (the user's): branch `mediatek-genio`; screenshots in `notes/media/img/`.
  3. Optional: K29 upstream draft; FFmpeg/Kodi upstream candidates; GStreamer HEVC on rkvdec (31/147) and the RK AV1 intrabc hang report; parked conformance items.
- **Scripts**: the harness is versioned in `scripts/media/vdec/` (README there) and symlinked into `le-media-kodi-vdec/`; edit the versioned files and run through the symlinks.
- **Rules**: Sonnet/Haiku subagents for images/logs/downloads; guard `rm` with `"${VAR:?}"`; never `--no-gpg-sign`; no Docker for LE builds (native, `taskset -c 0-11`, THREADCOUNT/CONCURRENCY_MAKE_LEVEL 12); long runs in tmux with `board-watch.sh` (`BOARD=` for the Blade3), check every 15 min; small tools on the boards OK (ask for more); ask before reboots/kernel installs/risky board tests; one decode test per board at a time; no push state in notes.
- **Board**: kernel build #4 (still has the reverted 3203; harmless, replace at the next kernel install). FFmpeg on the board = branch HEAD `3a0857fba5` (no MT2110 filter mapping). Kodi image = kodi-rockchip-deb `fac74f5` (rebuild for `c8d8889`, which adds the AV1 tile fix). NIO has alsa-utils, SOF fw, `/root/vdec/asound.conf`, clips in `/root/vdec/clips{,/real}`.
- **Next, in order**:
  1. Rebuild and load the Kodi image (kodi-rockchip-deb `c8d8889`), and quickly recheck AV1 in Kodi (multi-tile real clips).
  2. Step 5 leftovers, each with the `tools/h264ctl-dump` approach (extend to VP8/HEVC): AV1 `av1-1-b8-03-sizeup` (IOMMU faults; the 16–17 byte OUTPUT buffer lead), AV1 film grain (check GStreamer too), VP8 `segmentation-1425/1436`, HEVC `CONFWIN_A`, and the remaining H.264/HEVC 10-bit fails.
  3. Step 6 housekeeping: Armbian kernel rebuild (without 3203; 3200/3202 needs_rebase refresh for 7.3.4) + install; LE kernel 7.2 → 7.3 with K29/K26/K28; SOF fw + UCM for Armbian/CaptainOS; K29 upstream ping draft (user decides); upstream candidates (FFmpeg H.264 pic_num/marking, AV1 MI units, MT2110 detile; Kodi fallbacks); display warnings (vblank timeout on CRTC disable, rdma/ethdr runtime-PM underflow); Blade3 hdmirx audio; AV1 10-bit 4K headroom.
- **Rules**: Sonnet/Haiku subagents for captures/logs/downloads; guard `rm` with `"${VAR:?}"`; installing small tools on the NIO host is OK (ask for anything bigger); ask before reboots/kernel installs and before risky board tests; one decode test at a time; run long work in tmux with `board-watch.sh`.

## Phase C (next, in order)

1. ~~FFmpeg cleanup~~ done (retest on build #3: no regressions; K28 confirmed). Soak and FFmpeg AV1 retests done 2026-11-12 (soak passes; AV1 no longer panics).
2. **Kodi on the board (B4)**, see "Kodi test setup" below:
   - rebuild the kodi-deb image if the patches changed since `25df920`, then `docker save | ssh nerdctl load`
   - run Kodi in nerdctl (main note, "Test recipes"); test clips 1080p/4K H.264/HEVC/VP9/AV1 (+ one 10-bit)
   - EGL path first (no MDP3), then DirectToPlane (MDP3 + K29)
   - Collect Kodi debug logs, dmesg and IOMMU faults
   - Check: the plane dest rect vs our aspect-fit scale, frames held vs `capture_buffers=12`, whether the EGLImage bypass is needed with Mesa 26.1
   - Ask the user before starting: a hang still costs a power cycle.
### Kodi test setup (B4), prepared 2026-11-12. The user's answers:
- **No input device on the NIO.** Drive Kodi only over **JSON-RPC/HTTP**: pre-seed `guisettings.xml`/`advancedsettings.xml` with the web server on (port 8080, no auth, `services.webserver=true`, `services.esallinterfaces`), then `Player.Open {"item":{"file":…}}`, `Player.GetProperties`, `Settings.SetSettingValue videoplayer.useprimerenderer` (0 = DirectToPlane, 1 = EGL) and `Application.Quit`.
- **Seeing the output: Blade3 HDMI-RX** (the NIO's HDMI TX is wired to it).
  - Blade3 = CAPT node `root@192.168.66.145`, kernel 7.3.1-edge-rockchip64, mainline `snps_hdmirx` = `/dev/video3`, BGR24 only. v4l2-ctl and ffmpeg 7.1 are on the host. The user says it's free to use.
  - Capture: `v4l2-ctl -d /dev/video3 --set-dv-bt-timings query && v4l2-ctl -d /dev/video3 --stream-mmap=4 --stream-skip=5 --stream-count=N --stream-to=/tmp/f.raw`, then `ffmpeg -f rawvideo -pix_fmt bgr24 -s WxH -i /tmp/f.raw -vf scale=960:540 f%03d.png`. One test grab worked (it showed the NIO's CaptainOS console at 3840x2160@30).
  - For playback checks grab ~60 frames, then (a) look at a few PNGs, (b) check that consecutive frames differ (moving), (c) read the burned frame counter.
- **Output mode: 1080p60**, take over the display and ALSA freely. The NIO console currently runs at 4K30 into the Blade3; set Kodi to 1920x1080@60 (`videoscreen.screenmode` in guisettings, or `Settings.SetSettingValue`).
- **Media: generated test clips.**
  - In a container on the VM (the trixie `ffmpeg` package has libx264/libx265/libvpx/libaom/libsvtav1), from `testsrc2=size=WxH:rate=30` + `drawtext` frame counter (`text='%{n}'`), 30 s each.
  - Codecs H.264 (High), HEVC (Main + one Main10), VP9 (profile 0), AV1 (8-bit), at 1080p and 4K (2160p30).
  - Store in `le-media-kodi-vdec/clips/`, then tar to the NIO `/root/vdec/clips` (mount into Kodi as `/media`).
- **Kodi image**: `kodi-rockchip-gbm:trixie-v4l2requests` (built today with the MTK patches; the EGLImage MTK code is verified compiled in). Load it with `docker save kodi-rockchip-gbm:trixie-v4l2requests | ssh root@192.168.66.83 nerdctl load` (about 1.2 GB).
- **Run** (NIO): `nerdctl run -d --name kodi --privileged --net=host -v /dev:/dev -v /run/udev:/run/udev:ro -v /root/vdec/kodi-home:/root/.kodi -v /root/vdec/clips:/media kodi-rockchip-gbm:trixie-v4l2requests kodi --logging=console --windowing=gbm --audio-backend=alsa`. Check the image's entrypoint/README first (`le-media-kodi-vdec/kodi-rockchip-deb/README.md`, "Install: containers").
  - `kodi-home/userdata/advancedsettings.xml`: `<loglevel>2</loglevel>` (debug) + webserver.
  - `guisettings.xml`: webserver, `videoplayer.useprimerenderer`, DRM PRIME on.
- **Test matrix**: per clip, EGL (1) then DirectToPlane (0).
  - Start under `board-watch.sh` (NIO). Play 20 s, capture 60 frames on the Blade3, stop.
  - Record: plays / one-frame-freeze / garbage; Kodi log lines (`DRMPRIME`, `scale_v4l2m2m`, renderer chosen, EGL import errors); NIO dmesg/IOMMU faults; MDP3 `scale_v4l2m2m` frame sizes vs the plane.
  - Watch for: the aspect-fit scale matching the plane rect, `capture_buffers=12` enough (ENOBUFS in the log?), whether the EGLImage bypass is needed (look for EGL query results in the log), and the 10-bit clip falling back to software.
- **Risk**: MDP3 hangs should be gone (K29), but ask/notify the user before the first DirectToPlane run.

3. **FFmpeg vs. driver**: diff the per-frame V4L2 controls FFmpeg and GStreamer send (`GST_DEBUG=v4l2codecs*:7` vs an FFmpeg debug log / `v4l2-tracer`). Cases:
   - VP8 `segmentation-1425` (IOMMU faults) and `1436`
   - AV1 `nonuniformtiling`, tile-rows/cols, SVC, `sizeup` (K26 confirmed: no panic). Start with the 16–17 byte OUTPUT buffers that get EBUSY (`show_existing_frame`?)
   - H.264 `CAWP5`/`CVWP5`/`MR1_BT_A`
   - HEVC `CONFWIN_A`
4. **Upstream K29**: draft a ping/resend of `[PATCH v2 3/3] media: platform: mtk-mdp3: Add pm_runtime support for GCE power control` with `Fixes: 3f39f5652037` and the NIO-12L reproduction, for the user to review.
5. **Housekeeping**:
   - refresh Armbian 3200/3202 for 7.3.4
   - LibreELEC kernel 7.2 → 7.3 with the genio patch set
   - MT2110 `hwdownload` detile (10-bit conformance)
   - push decisions (the user's)

The sections below are the original 2026-11-12 plan, kept for reference; everything in them is done or carried into Phase C.

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

## Phase A: no board writes (done 2026-11-12)

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
- New branch `armsoc-9.0.2-mediatek` off `ffmpeg-chewitt/armsoc-9.0.2`.
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

## Phase B: board (done 2026-11-12; see the main note)

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
