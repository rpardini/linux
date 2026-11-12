# MediaTek MT8195 HDMI CEC (Radxa NIO-12L): upstreamable driver

Work of 2026-11-08. Status ID: K23. The series is written and builds clean; all DT checks pass.
**Board-tested 2026-11-12** against a Mixtile Blade 3 HDMI-in (see "Board test"). Module renamed to `mtk-hdmi-cec` after the test found a module name clash.

## Problem

- The MT8195 (Genio 1200) has an HDMI CEC controller. Mainline has no driver for it.
- On the NIO-12L, `mtk_hdmi_common.c` looks for a `mediatek,mt8173-cec` node and logs `mediatek-drm-hdmi-v2 1c300000.hdmi-tx: error -EOPNOTSUPP: Failed to find CEC node`.
- The existing `drivers/gpu/drm/mediatek/mtk_cec.c` supports only MT8173, and only for hotplug detection. It never registers a CEC adapter, so no MediaTek SoC has CEC messaging in mainline.

## Hardware facts (from the vendor kernel)

- CEC is a **separate block**, not inside the HDMI TX registers (`0x1c300000`):
  - `cec@10014000`, size 0x100; registers `TR_CONFIG` 0x00 … `INT_STA` 0x7c
  - interrupt `GIC_SPI 680`
  - 4 `infracfg_ao` clock gates: `CLK_INFRA_AO_CEC_66M_H`, `CEC_66M_B`, `HDMI_32K`, `HDMI_26M`. All 4 exist in mainline `mt8195-clk.h`.
- The same block, with the same vendor compatible, exists on MT8188 and MT8370.
- Pin: GPIO33 function `HDMITX20_CEC`. The NIO-12L mainline DT already muxes it in `hdmi_pins` (`pins-cec`, `bias-disable`).
- Timer tick: 10 µs, from the "27M" path with divider 0x82. All bit timings are in these ticks:
  - start bit 3.7/4.5 ms
  - data bit 0.6/1.5 ms low, 2.4 ms total
  - line stuck low 5 ms
- Hardware:
  - 3 logical address slots (`DEVICE_ADDR1..3`); a 4-bit field, 0xf = none
  - automatic ACK for those addresses (`RX_CHK_DST`)
  - a "bypass" receive-all mode
  - hardware retransmit counters (`TX_ARB`)
- The interrupt clear register is level-triggered: write the bits, then write 0. The TX/RX reset bits in `TR_CONFIG` are active low.

## Vendor references

| Tree | Remote / location | Notes |
|---|---|---|
| MediaTek Genio BSP | remote `kernel-mediatek-aiot` = `https://gitlab.com/mediatek/aiot/bsp/linux.git`, branch `mtk-v6.6`; worktree `/opt/linuxdev/kernel-genio-mtk` (detached at `dffa3b70fbc3`) | `drivers/gpu/drm/mediatek/mtk_cec_v2.{c,h}`, commit `737f4ade54b2` "GENIO: drm: mediatek: cec: add mtk_cec_v2 driver", Tommy Chen <tommyyl.chen@mediatek.com>, GPL-2.0, © 2024 MediaTek. Binding `display/mediatek/mediatek,cec2.yaml`. The node is `disabled` in mt8195.dtsi, and **no vendor board enables it** (not even the EVK). Other branches: mtk-v5.15-dev, mtk-v5.10… |
| Canonical linux-mtk (Armbian `BRANCH=vendor`, 5.15) | remote `kernel-canonical-linux-mtk` = `https://git.launchpad.net/~canonical-kernel/ubuntu/+source/linux-mtk/+git/jammy`, branch `master-next` (only branch) | Fetched 2026-11-08: tip `6383daeebb34` "UBUNTU: Ubuntu-mtk-5.15.0-1043.51", 41986 commits on top of v5.15. A plain fetch stalls forever in negotiation: 1301 local refs produce thousands of "have"s, and Launchpad answers slowly. Ubuntu re-applies stable updates as its own commits, so `stable/linux-5.15.y` gives no common commits. **Use `git fetch --negotiation-tip=v5.15 kernel-canonical-linux-mtk master-next`**: ACK at once, then a normal download. (The 5.15.y blobs fetched from `kernel-stable-google` on the way did not help.) Plan: worktree `/opt/linuxdev/kernel-genio-vendor`, branch `armbian/genio-vendor`, plus Armbian `patch/kernel/genio-1200-vendor/` (Mali patch, `dt/mt8395-radxa-nio-12l.dts`, Makefile line). Reference only; not created yet. |

Vendor driver issues (why it is not upstreamable as is):
- non-standard compatible `mediatek,cec2` and property `hdmi`
- lives in `drivers/gpu/drm/mediatek`
- no physical address from HDMI (the vendor HDMI driver registers no notifier), so userspace must set it
- 1 of 3 logical addresses used; the others are never cleared, so a reset value of 0 could ACK the TV's address
- `request_irq` errors ignored
- work queues plus a non-threaded IRQ
- many non-static `inline` functions and static locals in the "start bit error" detection
- PM only behind a Kconfig option

## Upstream series (K23)

- Worktree `/opt/linuxdev/kernel-cec`, branch `b4/mt8195-cec`, base `d164c7d754f0` (v7.4-rc1+, "Merge tag 'devicetree-fixes-for-7.4-1'").
- b4-enrolled: change-id `20261108-b4-mt8195-cec-7f2840a477aa`, cover strategy `commit`, v1 unsent. Recipients not set yet (`b4 prep --auto-to-cc`).
- `get_maintainer.pl`: Hans Verkuil (CEC), Mauro, Matthias Brugger, AngeloGioacchino; lists linux-media, linux-mediatek, linux-arm-kernel.

| # | Commit | Content |
|---|---|---|
| 0 | cover | "media: cec: add MediaTek MT8195 HDMI CEC support". It says: not tested on hardware. |
| 1 | `dt-bindings: media: cec: add MediaTek MT8195 CEC controller` | New `Documentation/devicetree/bindings/media/cec/mediatek,mt8195-cec.yaml`, with `allOf: cec-common.yaml`. Compatible `mediatek,mt8195-cec`, or `"mediatek,mt8188-cec", "mediatek,mt8195-cec"`. Clock-names `cec-66m-h`, `cec-66m-b`, `hdmi-32k`, `hdmi-26m` (gate names; roles unknown without a datasheet). `hdmi-phandle` required. Maintainer: me. |
| 2 | `media: cec: add MediaTek MT8195 CEC driver` | New `drivers/media/cec/platform/mediatek/mtk-cec.c` (~550 lines), `CEC_MTK` (selects `CEC_CORE`, `CEC_NOTIFIER`), Makefile/Kconfig hooks. MAINTAINERS "MEDIATEK HDMI CEC DRIVER" (M: me, L: linux-media). |
| 3 | `drm/mediatek: hdmi: register a CEC notifier for HDMI v2` | `struct mtk_hdmi_ver_conf.has_cec_hpd` (set for v1). Only v1 looks up the MT8173 CEC node; this ends the misleading message. v2 sets `DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER` + `bridge.hdmi_cec_dev`, so `drm_bridge_connector` registers the notifier and the physical address follows the EDID. No DRM Kconfig change: `DRM_DISPLAY_HDMI_CEC_NOTIFIER_HELPER` is `def_bool CEC_NOTIFIER`. |
| 4 | `arm64: dts: mediatek: mt8195: add HDMI CEC controller` | Node `cec: cec@10014000`, disabled, `hdmi-phandle = <&hdmi>`. |
| 5 | `arm64: dts: mediatek: mt8395-radxa-nio-12l: enable HDMI CEC` | `&cec { status = "okay"; }`; the pin is already in `hdmi_pins`. |

Driver design:
- Modelled on `s5p_cec.c` / `tegra_cec.c`:
  - `cec_notifier_parse_hdmi_phandle()` + `cec_notifier_cec_adap_register()`
  - `devm_clk_bulk_get_all()`
  - threaded IRQ (`IRQF_ONESHOT | IRQF_NO_AUTOEN`, enabled only while the adapter is on)
  - one spinlock for registers and TX state
  - `cec_received_msg()` / `cec_transmit_attempt_done()` called **outside** the lock: the core takes `adap->lock` and calls back into the driver
- Caps: `CEC_CAP_DEFAULTS | CEC_CAP_CONNECTOR_INFO`; 1 logical address. Slots 2/3 are set to 0xf (none).
- TX status mapping (unverified against hardware; check on the board):
  - DATA_FINISH → OK
  - LINE_LOW_LONG → ERROR, plus TX reset
  - after FAIL_RETRANSMIT:
    - broadcast with header/data ACK fail → **OK** (follows the vendor code: on broadcast, a NACK means nobody rejected)
    - SRC fail → ARB_LOST
    - HEADER/DATA fail → ERROR
    - header/data ACK fail → NACK
- Hardware retries: 1 each (arbitration/collision/NAK), as in the vendor driver. The core retries too.
- Dropped from the vendor driver:
  - the "start bit error" FSM workaround (TX FSM 0x20→0x08 → reset)
  - the busy-wait retry loop in transmit; it now resets TX if the FSM is not idle
  - polling messages are not passed to the core
- PM: system suspend powers the hardware off; resume re-inits it and restores the logical address. No CEC wakeup.
- Not done (user decision): monitor-all (`CEC_BYPASS`), 3 logical addresses, wakeup from suspend.

Authorship (user decision):
- From: me. The commit and the file header say "Based on the MediaTek vendor driver by Tommy Chen". Keep the MediaTek copyright line. Cc Tommy on submission.
- Commits carry `Assisted-by: Claude Opus 5.5` and **no `Signed-off-by`**: the kernel's `Documentation/process/coding-assistants.rst` forbids AI-added SoB. Before sending, run `git rebase --signoff` (series range) and add the cover's SoB.
- This tree's `checkpatch` warns "Non-standard signature: Assisted-by:" and flags its address. Adjust the trailer to the list norm before sending.

## Checks done

- `make W=1 drivers/media/cec/platform/mediatek/ drivers/gpu/drm/mediatek/ mediatek/mt8395-radxa-nio-12l.dtb`: clean, both on the upstream base and on v7.3 + Armbian `genio-7.3` patches (temporary worktree, since removed).
- `make dt_binding_check DT_SCHEMA_FILES=media/cec/mediatek,mt8195-cec.yaml`: clean.
- `make CHECK_DTBS=y … mediatek/mt8395-radxa-nio-12l.dtb`: clean.
- `checkpatch --strict`: driver clean. Series: only the missing SoB, the Assisted-by trailer, and the usual MAINTAINERS warning on the binding patch.
- Tools installed on this host: `python3-pip` (apt), plus `dtschema`, `yamllint` and `b4` 0.16.0 (pip `--user`, in `~/.local/bin`).
- Build dirs: `/tmp/claude-501/-opt-linuxdev/60a64c1f-a25e-4c3b-87db-599f1ce9650a/scratchpad/kbuild-cec` (upstream, defconfig + CEC/MTK HDMI as modules).

## Armbian backport

- armbian-build: one commit `ad52b6fa1` "genio: edge: HDMI CEC for MT8195 (NIO-12L)", branch `extensions` (2026-11-12: the original commit and the rename / SFT / re-export follow-ups squashed into it; message = bullet-point version of the cover; backup `extensions-backup-pre-cec-squash`):
  - `patch/kernel/archive/genio-7.3/3100…3104-*.patch`: patches 1-5 of the final v1 series (`format-patch`; the defconfig patch isn't needed in Armbian)
  - `config/kernel/linux-genio-edge.config`: `CONFIG_CEC_MTK=m`. `MEDIA_CEC_SUPPORT`/`CEC_CORE`/`CEC_NOTIFIER` are already on (via `CEC_CROS_EC=y`).
- Built and board-tested 2026-11-12 (`7.3.4-edge-genio`, see below).

## Board test (2026-11-12)

Setup:
- NIO-12L `192.168.66.83` (CAPT-k8s image, Armbian `7.3.4-edge-genio`, genio-7.3 `3100..3104`) HDMI TX → Mixtile Blade 3 `blade3a` `192.168.66.145` HDMI IN (`snps_hdmirx`, Armbian `7.3.1-edge-rockchip64`, default EDID `LNX hdmi-4k-300`, source PA 1.0.0.0).
- Blade 3 `/dev/cec1` (`snps_hdmirx`) = partner, `cec-ctl -d1 --tv` → LA 14 (Specific, see K24). NIO `cec-ctl -d0 --playback` → LA 4.
- Tools: `v4l-utils` 1.30.1, `edid-decode`, `libdrm-tests` (NIO); + `ffmpeg`, gstreamer (Blade 3). trixie-backports added on both.
- **Only one cable on the CEC bus.** With the second cable (Blade 3 TX → NIO RX) plugged in, every broadcast from the Blade 3 RX adapter ended in NACK/Max Retries, and the NIO got 4 copies. Still the same with the NIO adapter unconfigured, so the NIO is not the one rejecting: the Blade 3's own TX CEC (`dwhdmiqp`, unconfigured, PA f.f.f.f) sits on the same bus through the NIO's RX connector. Unplugged → broadcasts OK. Noted in K24.

Bug found and fixed:
- Module name clash: `mtk-cec.c` → module `mtk_cec`, the same name as DRM's `drivers/gpu/drm/mediatek/mtk_cec.c` (built in with `DRM_MEDIATEK_HDMI=y`). `modprobe` saw it as built-in and did nothing, no `/dev/cec0`. Renamed to `mtk-hdmi-cec.c` (module `mtk_hdmi_cec`, driver name `mtk-hdmi-cec`, Kconfig help names the module). Fixup squashed into patch 2; backup `b4/mt8195-cec-backup-pre-rename`; Armbian `3101` re-exported (now in armbian `ad52b6fa1`).

Results (logs in `notes/kernel/mt8195-cec/`):
- Probe OK at boot, `/dev/cec0`, IRQ `GIC 712`. "Failed to find CEC node" is gone.
- PA from the DRM notifier: 1.0.0.0 (matches `edid-decode` of the Blade 3 EDID). LA 4 claimed.
- NIO → Blade 3 (LA 14): give-device-power-status, give-osd-name, give-physical-addr, get-cec-version, give-device-vendor-id: Tx OK, replies received. Broadcast active-source: received by the Blade 3.
- Blade 3 → NIO (LA 4, `cec-follower` on the NIO): power status on, OSD name, PA, CEC version, vendor id: all answered. Broadcast request-active-source: Tx OK, received once.
- NACK: NIO → LA 5 (nobody there): `Not Acknowledged, Max Retries`, no timeout. No IRQ storm (about 600 IRQs for a full stress run).
- `cec-compliance -d0 -A` (NIO adapter): 11/11 OK, 1 warning. 73 GET_CEC_VERSION sent, 17 CEC_VERSION received. The Blade 3 monitor saw 74 GET_CEC_VERSION and only 18 replies sent: the remote core's TX queue limit (18) under flood. Not our driver.
- `cec-compliance -d1 -r 4` (Blade 3 tests the NIO as remote): **84/84 OK**, 1 warning (Inactive Source reply, cec-follower behaviour).
- `cec-compliance -d0 -r 14` (NIO tests the Blade 3 as TV): cut off by a 400 s timeout in the power tests. Failures (System Audio Mode directly addressed, Wake up TV on Image/Text View On) are the Blade 3 TV emulation. `IMAGE_VIEW_ON` does reach the Blade 3, but `cec-follower` only acts as a TV on LA 0, and the Blade 3 is on LA 14 because of K24.
- Board reset during the test (not the driver): reading `TR_CONFIG` via `/dev/mem` after `cec-ctl --clear` (adapter off → clocks gated) hangs the bus, so the watchdog resets with nothing on the UART. **Never touch the CEC registers via /dev/mem while the adapter is unconfigured.**
- `TR_CONFIG` while configured: `0x24ff2303` (`RX_CHK_DST`, LA1=4, `ACK_ERROR_BYPASS`, `HEADER_TRIG_INT_EN`, `RX_ACK_SEL`=1 from reset). Toggling `RX_ACK_SEL`/`RX_HEADER_ACK`/`RX_DATA_ACK` does not change broadcast behaviour; setting `HEADER_ACK`/`DATA_ACK` breaks direct ACKs. Leave them as they are.

Hotplug (2 unplug/replug cycles, one quick ~2 s): PA → f.f.f.f + LA released at unplug, PA 1.0.0.0 at replug and LA 4 re-claimed ~150 ms later by itself, then broadcast `REPORT_PHYSICAL_ADDR`. Picture recovers. Logs `mt8195-cec/2026-11-12-hotplug-*`.
- Every unplug also logs a DRM `vblank wait timed out` WARN + runtime PM underflow (ETHDR / MDP-RDMA). Likely pre-existing, not CEC: K25, `notes/kernel/mt8195-hdmi-unplug-vblank-warn.md`.

Not tested yet: a real TV (remote keys, input switching, Kodi/libcec "Linux" adapter, several CEC devices on the bus / arbitration). Suspend/resume skipped (user: not relevant for CEC use).
`CONFIG_MEDIA_CEC_RC` is off in genio edge (and rockchip64 edge): libcec/Kodi don't need it, but without it the kernel creates no remote-key input device. Decide later.

## Submission prep (2026-11-12)

Learnings applied:
- Own series: cover says how it was found + concrete test results, `[n]` links; no `---` lines in the cover text (K4 v6 b4 To/Cc bug); no `Assisted-by`; user adds SoB.
- RK3588 CEC (Cristian Ciocaltea, dw-hdmi-qp v1-v4, applied by Heiko): downstream author as `Co-developed-by` + `Signed-off-by`; generic patches independent of platform ones (Heiko); last patch `arm64: defconfig`; cover explains design. They used the DRM HDMI CEC adapter helpers because their CEC is inside the HDMI controller; ours is a separate block, so the notifier is right (cover says so).
- Hans Verkuil (MSM CEC review 2023, snps_hdmirx review 2024, media maintainer profile): `cec-compliance` must pass, `-A` from both sides; who does the retries (MAX_RETRIES consistency); signal free time; transmit with HPD low (`CEC_CAP_NEEDS_HPD`); `C=1` sparse/smatch.

Driver changes from this (fixup into patch 2, Armbian `3101` re-exported, now in armbian `ad52b6fa1`):
- SFT: measured (own sender + Blade 3 receiver, `scratchpad` scripts `sft_test.py`/`sft_rx.py`): 4 bit periods between own consecutive messages, whatever `TX_ARB` BCNT_* is set to (even 15). The hardware does not wait for SFT on an idle bus. Driver now records `bus_free` (TX/RX done) and starts TX_READY after `signal_free_time` × 2.4 ms (hrtimer when needed). Measured after: 7 (repeat), 5 (new initiator).
- Retries: hardware retransmit counts 0, the core retries (before: hw 1 retry + core retries).
- `CEC_CAP_NEEDS_HPD` not set: separate block; not tested with a TV that drops HPD in standby.
- Results (logs `mt8195-cec/2026-11-12-v1final-*`): `-A` NIO 11/11 0 warnings; `-A` Blade 3 11/11 0 warnings; `-r 4` from Blade 3 84/84 (1 cec-follower warning).
- Measurement note: each side measures the other's replies ~1 bit period short (timestamp bias, symmetric); own transmits measure correctly.

Series (b4, v1, change-id `20261108-b4-mt8195-cec-7f2840a477aa`, base `d164c7d754f0` v7.4-rc1+):
1. `dt-bindings: media: cec: add MediaTek MT8195 HDMI CEC controller`
2. `media: cec: add MediaTek MT8195 HDMI CEC driver` (Co-developed-by + SoB Tommy Chen, from vendor `737f4ade54b2`)
3. `drm/mediatek: mtk_hdmi: Register a CEC notifier for HDMI v2`
4. `arm64: dts: mediatek: mt8195: Add HDMI CEC controller`
5. `arm64: dts: mediatek: mt8395-radxa-nio-12l: Enable HDMI CEC`
6. `arm64: defconfig: Enable MediaTek HDMI CEC` (new)
- Backups: `b4/mt8195-cec-backup-pre-rename`, `-pre-sft`, `-pre-msgs`.
- Checks: dt_binding_check, CHECK_DTBS (only pre-existing jpeg warnings), W=1, checkpatch --strict (only missing SoB + usual MAINTAINERS note on the binding), `b4 prep --check` same.
- sparse: Debian 0.6.4 is too old for this kernel (`__typeof_unqual__`); building sparse from git was blocked. Pending user decision.
- Recipients: `b4 prep --auto-to-cc` (Hans, Mauro, DT, Matthias, Angelo, Chun-Kuang, Philipp, Airlie, Vetter + lists); Tommy via trailers.
- Preview: `b4 send -o` (nothing sent).
- Before sending: user SoB (`git rebase --signoff` on the 6 patches), `b4 send --dry-run`, then `b4 send` with OK.
- Armbian `3100..3104` re-exported from the final v1 commits (now in armbian `ad52b6fa1`, code unchanged; file names kept). The defconfig patch is not needed in Armbian (own kernel config).
- b4 gotcha: `b4 prep --edit-cover` feeds the editor the cover **without** the tracking block and re-adds it. Feeding it text that already contains `--- b4-submit-tracking ---` duplicates the block, and b4 then can't load the cover (`ValueError: too many values to unpack`). Fixed by amending the cover commit with one block (backup `b4/mt8195-cec-backup-pre-coverfix`). Only feed cover text + To/Cc.
- sparse: kernel `C=1` runs sparse on every compiled file; this tree's `scripts/checker-valid.sh` needs `__typeof_unqual__` support, which Debian's 0.6.4 lacks, so `C=1` is silently skipped (Makefile warns "sparse is not available or not up to date"). Needs sparse built from git (git.kernel.org/pub/scm/devel/sparse/sparse.git). Media builds with `C=1` (sparse + smatch) and wants no new warnings.
- 2026-11-12: sparse built from git (tip `84ec065`, 2026-10-22) in `/opt/linuxdev/sparse-src`, installed to `~/.local/bin/sparse` (`--version` says 0.6.4: shallow clone, no tags). `checker-valid.sh` accepts it. Run: `make O=.build W=1 C=2 CHECK=$HOME/.local/bin/sparse CF=-D__CHECK_ENDIAN__ <objs>`. Result: `mtk-hdmi-cec.c`, `mtk_hdmi.c`, `mtk_hdmi_common.c`, `mtk_hdmi_v2.c` clean (V=1 confirms sparse ran on them). smatch not installed (not in Debian).

## Next steps

1. TV test: `cec-ctl -d0 --playback` + `cec-ctl -M` while pressing remote keys; `--image-view-on` / `--standby` to 0; input switching / TV off-on (PA + K25 WARN); `cec-compliance -r 0`; Kodi with `cec-client -l` showing a Linux adapter.
2. Before installing a kernel on the CAPT boards: fix the versions in `/boot/extlinux/extlinux.conf` first (it pins them).
3. If TX status or RX misbehaves: compare with the vendor flow (start-bit workaround, broadcast ACK semantics).
4. Before sending: SoB, trailer format, `b4 prep --auto-to-cc`, `b4 prep --check`, Cc Tommy Chen. MT8188 is untested; say so (already in the cover).
5. Later: monitor-all, 3 logical addresses, CEC wakeup; MT8188/MT8370 DT nodes by someone with hardware.
6. Canonical tree (fetched): worktree + Armbian vendor patches, compare CEC code with MediaTek's (low priority).
