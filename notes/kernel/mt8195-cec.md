# MediaTek MT8195 HDMI CEC (Radxa NIO-12L): upstreamable driver

Work of 2026-11-08. Status ID: K23. The series is written and builds clean; all DT checks pass.
**Not tested on hardware yet.** Whether the HDMI display supports CEC is not known.

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

- armbian-build commit `f635a539d` "genio: edge: HDMI CEC for MT8195 (NIO-12L)", branch `extensions` (not pushed):
  - `patch/kernel/archive/genio-7.3/3100…3104-*.patch` (the 5 patches, `format-patch` from the series before b4 enrollment)
  - `config/kernel/linux-genio-edge.config`: `CONFIG_CEC_MTK=m`. `MEDIA_CEC_SUPPORT`/`CEC_CORE`/`CEC_NOTIFIER` are already on (via `CEC_CROS_EC=y`).
- The kernel deb is not built yet (user: "not now").

## Next steps

1. Build: `PREFER_DOCKER=no ./compile.sh rpardini-generic kernel BOARD=radxa-nio-12l BRANCH=edge`, then install the debs on the board (`root@192.168.66.83`).
2. Board test:
   - `dmesg | grep -i cec`: probe OK, no `Failed to find CEC node`
   - `ls /dev/cec0`
   - `cec-ctl -d0`: physical address (e.g. 1.0.0.0) with HDMI plugged in, f.f.f.f when unplugged
   - `cec-ctl --playback`, `cec-ctl --to 0 --give-device-power-status`, `--image-view-on`, `--standby`
   - `cec-ctl -M` while pressing TV remote keys
   - `cec-compliance -A` if the display supports CEC
   - without CEC on the display: transmits must end in NACK, not timeouts or IRQ storms
   - regression: HDMI output, hotplug, audio
3. If TX status or RX misbehaves: compare with the vendor flow (start-bit workaround, broadcast ACK semantics).
4. Before sending: SoB, trailer format, `b4 prep --auto-to-cc`, `b4 prep --check`, Cc Tommy Chen. MT8188 is untested; say so (already in the cover).
5. Later: monitor-all, 3 logical addresses, CEC wakeup; MT8188/MT8370 DT nodes by someone with hardware.
6. Canonical tree (fetched): worktree + Armbian vendor patches, compare CEC code with MediaTek's (low priority).
