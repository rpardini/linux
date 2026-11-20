# K30: Mekotronics R58X-Pro (RK3588) upstream DT

- Branch `b4/rk3588-mekotronics-r58x-pro` (b4 prep, cover strategy commit), worktree `kernel-rk3588-meko-r58x-pro`, base `kernel-torvalds/master` (v7.4-rc2+). Check that it applies on `kernel-mmind/v7.5-armsoc/dts64` before sending.
- Sources:
  - Armbian DT: `armbian-build/patch/kernel/archive/rockchip64-7.4/dt/rk3588-mekotronics-r58x-pro.dts`. The u-boot v2026.10 `dt_upstream_rockchip` copy is identical.
  - Vendor 6.1 DT: `kernel-armbian-linux-rockchip/rk-6.1-rkr7.2:arch/arm64/boot/dts/rockchip/rk3588-blueberry-edge-v12{.dtsi,-maizhuo-linux.dts}` (+ `rk3588-blueberry.dtsi`).
  - No public schematic exists.
- Not in the series: the VK2C21 segment LCD (stays in Armbian only).

## Resume here (sent v1 2026-11-20)

- **Sent v1 2026-11-20** by the user: `<20261120-rk3588-mekotronics-r58x-pro-v1-0-4e70c077c7b4@pardini.net>`, tag `sent/20261118-rk3588-mekotronics-r58x-pro-54cfda4bd8a4-v1`; b4 branch now at revision 2. Next: collect feedback with `scripts/20-lore.sh all K30`, then prepare v2 if needed.
- **v1 feedback (fetched 2026-11-20):** no human replies yet. Sashiko (patch 3/3 only) found 3 issues; the bot also mailed them to devicetree@, Rob, Conor (`<sashiko-outbox-224280@kernel.org>`). See "v1 review feedback" below.
- **State before sending (for reference):**
  - Series: 3 patches + cover on `b4/rk3588-mekotronics-r58x-pro` (worktree `kernel-rk3588-meko-r58x-pro`), base torvalds master (v7.4-rc3 merge), user's SoB on all 3. Commit messages and cover approved by the user.
  - Checks (2026-11-20): `b4 prep --check` (only the MAINTAINERS warning), `CHECK_DTBS` clean, dt-check-style only documented exceptions, applies strictly on mmind `v7.5-armsoc/dts64` (see "Apply check on mmind"), `b4 send --dry-run` OK (4 messages, patatt-signed).
  - Recipients: To Rob Herring, Krzysztof Kozlowski, Conor Dooley, Heiko Stuebner; Cc devicetree, LKML, linux-arm-kernel, linux-rockchip, Sebastian Reichel.
  - To send: unlock gpg in the user's terminal, then `b4 send` in the worktree.
- **Cover:** short version approved 2026-11-20: no-schematic source line, dt-check-style exceptions, GMAC0 rgmii-rxid, Type-C (source only; mode-switch per [2]; reverse orientation needs Sebastian's pending dwc3 glue [1] + usbdp part3 [2]; no DP alt mode), "Tested on the board" sentence (eMMC/NVMe boot, both GbE, USB 3.0 over Type-C, HDMI/DP out, headphone audio, RTC, WiFi/BT, LEDs, keys, GPU (Panfrost), NPU (Mesa Teflon)), and "I used Claude for cleanups, ordering and naming, according to recent series lore." To edit: write the cover text **without** the b4 tracking block to a file, then `GIT_EDITOR="cp <file>" b4 prep --edit-cover` (passing the tracking block duplicates it and breaks b4).
- **DT changes since 2026-11-18:** `mode-switch` on usbdp_phy0; restored from the Armbian DT: `&pd_npu`/`&pd_gpu` domain-supply, pull-ups (pcie30x4-pwren, wifi-pwren, hdmirx-5v-det), WiFi host-wake pinctrl; names `led-0/1/2`, `dp-con`. See "Regression review" and the backup branches `backup/b4-meko-r58x-pro-pre-*-2026112*`.
- **armbian-build `extensions`:** the 7.4 DT is byte-identical to the series. The Meko history was squashed to 8 commits (Sebastian's series + include prereq, DT+overlay, board file). Not pushed; the user pushes and builds in CI.
- **Board (192.168.66.175 end0 / .174 end1, root ssh):** boots Armbian **edge** 7.4-rc3 (rockchip64 edge = 7.4 since 2026-11-20; same K30 board DT, Armbian dtb package) via `/boot/extlinux/extlinux.conf` (**`default mainline-altmode` since 2026-11-20 evening**, see "DP alt mode test 2"; entries `mainline` = previous bleedingedge 7.4-rc3 + series dtb, `vendor`, `mainline-altmode`, `vendor-dp0`; boot.scr as fallback; pre-edge config in `extlinux.conf.bak-20261120-pre-edge`). Sebastian's series are in the Armbian kernel. The edge dtb differs from the series dtb only in SoC nodes from rockchip64 patches (CPU low OPPs, panthor 1 GHz GPU clocks, rkvdec). extlinux.conf has `prompt 0` / `timeout 10` and no top-level `menu title` (2026-11-20, user: boot without waiting), so U-Boot boots `default` straight away and serial noise can't stop it; switch kernels by editing `default` from Linux (menu version: `extlinux.conf.bak-20261120-menu`). Tools: iperf3, evtest, alsa-utils, i2c-tools, gpiod, libdrm-tests, edid-decode, kmscube, docker (NPU image). modetest/kmscube need stdin held open (`sleep N | ...`). kmscube has no connector option: force the other connector off via `/sys/class/drm/cardN-*/status`.
- **Known, not ours:**
  - `sdhci-dwcmshc fe2e0000.mmc: Can't reduce the clock below 52MHz in HS200/HS400 mode` (x3 at boot, `dmesg --level err`): harmless intermediate state during eMMC init (Shawn Lin). Downgraded to dev_dbg by "mmc: sdhci-of-dwcmshc: downgrade HS200/HS400 clock-reduce message to dev_dbg" (Jun Yan), applied by Ulf 2026-10-30, linux-next 199a09a191be; not in 7.4. User: no Armbian patch needed.
  - fusb302 "IRQ: PD retry failed" spam at boot (also without Sebastian's series).
  - On mmind dts64, CHECK_DTBS warns about vop resets for every rk3588 board (mmind f245313cd545).
- **Not tested / not described (cover says nothing, answer "per schematic/vendor DT" if asked):** USB-A devices, SATA (no disk), RS232/RS485, HDMI-in, mic (needs es8328 `slrck` driver fix), microSD (dropped). DP alt mode is not in v1, but works on the test branch (see "DP alt mode test 2").
- **Pending elsewhere:** Tested-by tags for Sebastian's series, see [`tested-by-pending.md`](tested-by-pending.md) (send only with the user's OK).
- **Optional later:** es8328 slrck (0x2B) driver fix for capture; SD slot debug; decide whether DP alt mode goes back into v2 (works with the Apple adapter, `test/meko-dp-altmode-v2-20261120`); boot-time HPD race (below).

## v1 review feedback

Fetched 2026-11-20 (`scripts/20-lore.sh all K30`): `lore/topics/K30/mbox/v1.mbx` (cover, 3 patches, the Sashiko mail), `lore/topics/K30/sashiko/v1.md`. No human reviews yet (Rob's bot, Krzysztof, Conor, Heiko).

| # | Source | Sev | Finding | Precedent / check | Proposed for v2 |
|---|---|---|---|---|---|
| S1 | Sashiko 3/3 | High | `&usb_host1_xhci` overrides `phys`/`phy-names` to u2phy only. dwc3 then never calls `phy_init()` on the usbdp_phy1 USB3 PHY, so `rk_udphy_usb3_phy_init()` never runs `rk_udphy_u3_port_disable()` (usb_grf usb3otg1_cfg: disable U3, PIPE clock from UTMI). Possible hang/SError on xHCI access. | Turing RK1 (`rk3588-turing-rk1.dtsi`, the only other `dp-lane-mux = <0 1 2 3>` board) keeps the default phys and only sets `maximum-speed = "high-speed"` on `usb_host0_xhci`. On our board (7.4-rc3 bleedingedge, series dtb), `fc400000.usb` probes with no SError, but that may depend on bootloader state. The Armbian DT had neither the override nor `maximum-speed`. | drop the `phys`/`phy-names` override, keep `dr_mode` + `maximum-speed`; retest that host1 USB 2.0 ports enumerate and DP still works (done locally) |
| S2 | Sashiko 3/3 | Medium | `bt_wake_host_irq` (GPIO1_B0) has `pcfg_pull_up`, but the BT `host-wakeup` interrupt is `IRQ_TYPE_LEVEL_HIGH` (active high, idle low). A pull-up holds it in the active state. | Every other rk3588 board with a LEVEL_HIGH BT host-wakeup uses `pcfg_pull_down` (armsom-sige7, coolpi-4b, khadas-edge2, orangepi-5-pro). The pull-up came from the Armbian DT. | `pcfg_pull_down`; retest BT (done locally) |
| S3 | Sashiko 3/3 | Low | `&hdmi0` `frl-enable-gpios` (GPIO4_B1) has no pinctrl; pull left to bootloader. | rock-5b-5bp-5t and orangepi-5-plus add `hdmi0_tx_on_h: hdmi0-tx-on-h` (`<4 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>`) and a full `pinctrl-0` (`hdmim0_tx0_cec/hpd/scl/sda` + tx_on_h). | add the pinctrl as rock-5b does (done locally) |

**Local v2 (2026-11-20, user chose all three fixes; hold v2 until human review or ~1 week):**
- Amended the DTS commit on `b4/rk3588-mekotronics-r58x-pro`. Backup: `backup/b4-meko-r58x-pro-pre-v2-sashiko-20261120`. Patches 1/3 and 2/3 are unchanged.
- S1: dropped the `phys`/`phy-names` override. S2: `pcfg_pull_down`. S3: `hdmi { hdmi0_tx_on_h }` plus a full `pinctrl-0` on `&hdmi0`, names before pinctrl-0 (subarch practice).
- Checks: CHECK_DTBS clean. dt-check-style shows +1 `property-order` (pinctrl-names before pinctrl-0, documented exception). `b4 prep --check` gives only the MAINTAINERS warning.
- Board (dtb built with `-@`, installed as the `mainline` fdt; the v1 dtb was kept as `...r58x-pro.dtb.v1` on the board):
  - Host1 xHCI (fc400000) now registers only a 480M roothub; v1 also had a stray 5000M SS roothub. So the U3 port is now disabled through the PHY, which confirms S1.
  - DP-1 and HDMI-A-1 are connected. `frl-enable` is held by the driver. BT hci0 comes up with the BCM43752 patch loaded; GPIO1_B0 is pulled down.
  - Follow-up with devices in all ports: the host1 USB 2.0 port enumerates a SanDisk Extreme Pro at 480M (bus 3, 38 MB/s direct read). BlueZ was installed on the board: the BT scan finds 5 devices and the `host_wake` IRQ fires.
- Cover: "Changes in v2" filled in (3 Sashiko bullets). Backup before the cover edit: `backup/b4-meko-r58x-pro-pre-v2-cover-20261120`.
- **DP alt mode folded into local v2 (2026-11-20, user OK after the Apple adapter tests):** the test commit was squashed into the DTS patch (tree identical to `test/meko-dp-altmode-v2-20261120`). Backups: `backup/b4-meko-r58x-pro-pre-altmode-v2-20261120` (before squash), `backup/b4-meko-r58x-pro-pre-altmode-cover-20261120` (before wording). Checks: CHECK_DTBS clean; dt-check-style +1 `pinctrl-names` order (`&usbdp_phy0`, documented exception); `b4 prep --check` only MAINTAINERS.
  - Wording (approved): DTS spec line "USB Type-C with USB 3.0 and DP alt mode (FUSB302, source only)". Cover: alt mode sentence (dp0/VP1 via usbdp_phy0; with [1], [2] and dw-dp v12 [3], Apple USB-C to HDMI adapter, 1080p60 both orientations, USB 3.0 on the adapter too), "DP alt mode" in the tested list, `[3]` dw-dp v12 link, first v2 changelog bullet "Describe DP alt mode on the Type-C port (dp0 via usbdp_phy0)". Boot-time HPD race left out of the cover until investigated (user).
- **Boot-time HPD race: fixed by Sebastian's "drm/connector: Cache out-of-band hotplug events"** (2026-11-20). Lore v1 `<20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>` (no v2 yet; Tested-by Igor Paunovic on OPi5+ with fusb302; Chaoyi Chen asked whether to cache only when no connector is found; Sashiko: possible out-of-order replay, cache never freed). v1 doesn't apply to 7.4 (context: `drm_utils.h` renamed to `drm_panel_quirks.h` by 1628e34ee666f, already in v7.4-rc3); Collabora `rockchip-devel` carries a rebased copy with the same change.
  - Cause: typec_displayport calls `drm_connector_oob_hotplug_event()` at ~3.2 s; no connector with that fwnode exists until dw-dp binds/DRM registers (~5.0–5.5 s), so the event is dropped and dw-dp's first detect says disconnected. "no extcon found" is from Armbian's rk3399 extcon patch, unrelated.
  - armbian-build `extensions`: `rk35xx-1246-drm-connector-cache-oob-hotplug-events-v1.patch` (Collabora copy + lore `Link:`), and the 7.4 Meko DT synced to local v2 with alt mode (two commits). Edge kernel built and installed on the board; extlinux `default edge` (Armbian's own dtb) with `drm.debug=0x100` on the edge entry (backup `extlinux.conf.bak-20261120-pre-oob-edge`).
  - Result (reboot with the Apple adapter plugged, reverse): Attention+HPD at 3.36 s, dw-dp bound 5.40 s, DRM registered 5.51 s, AUX/EDID from 5.63 s with no new Type-C event (= replayed cached HPD), adapter's second Attention 5.73 s (reaction to AUX), link trained HBR3 x2 at 5.74 s, console on DP-1. Stick at 5 Gbps.
  - Retests on the new edge build (2026-11-20, for the Tested-by replies): Apple adapter is an **A2119** (HDMI 2.0, "EMC 3279"). Dell U3415W on its HDMI input via the adapter: EDID max 3440x1440@50 (265.25 MHz; also @30), modetest 3440x1440@50 stable (user), and back on its own after a hot flip (link retrained HBR3 x2). RTL8156 2.5G NIC direct on Type-C, hot flips reverse → normal → reverse: 5 Gbps and 2.5G link each time, iperf3 from this VM ~1.8 Gbit/s to the board and ~1.0–1.2 Gbit/s back (needs arp_ignore/announce + a source policy route on the board, removed afterwards), no xHCI errors.
  - Next: send Tested-by for the OOB cache patch (with the user's OK); remove `drm.debug=0x100` from the edge entry when done.
- armbian-build `extensions` 7.4 DT synced to local v2 (byte-identical again), as a separate commit "rockchip64-7.4: mekotronics-r58x-pro: DT fixes from review" (user's choice: not folded into the DT rework commit).

## Series

1. `dt-bindings: vendor-prefixes: Add Mekotronics`
2. `dt-bindings: arm: rockchip: Add Mekotronics R58X-Pro`
3. `arm64: dts: rockchip: Add Mekotronics R58X-Pro`

## Reviewer checklist (from lore research, `lore/research/rk3588-*`)

- Three patches: prefix, binding, dts. The binding goes before the dts. The file is named `rk3588-<vendor>-<board>.dts`. `CHECK_DTBS=y` must be clean; Rob dropped Vicharak over an rk806 warning.
- checkpatch `--strict`. No more than one resend per 24h. Reply to Sashiko instead of pinging.
- Regulators:
  - Fixed regulators are named `regulator-*`.
  - Drop supplies that nothing consumes.
  - No always-on/boot-on as a workaround (`vdd_npu_s0`).
- LEDs use `function` + `color`, not `label`.
- Every GPIO used gets a pinctrl entry. PCIe resets use the GPIO-function pinctrl (`e95e4fcdc454`).
- Ethernet: `rgmii-id` with no MAC delays (Lunn). Otherwise add a comment explaining why.
- No `mem-supply` on CPU nodes.
- Codec mclk pinctrl goes on the codec. Use `I2S0_8CH_MCLKOUT_TO_IO`.
- No undocumented compatibles and no unexplained enabled nodes.
- Key threads:
  - YY3588 `20260610-yy3588-board-v1-0-4bb7176b6826@superkali.me`
  - OPi 5 Pro v10 `20260511025352.106126-1-dennis@ausil.us`
  - Axon (Heiko/Krzysztof) `10605990.5OynTdThKG@phil`
  - LubanCat 4 (Lunn) `1ac2d0f4-e027-4633-9d34-2709cb3e43ec@lunn.ch`

## Changes vs the Armbian DT

- Dropped:
  - The LCD node.
  - `&i2c5`, which has no known use.
  - The `rs485`/`rs232` aliases.
  - `mem-supply` on the CPU nodes.
  - The `pcie30_avdd*` regulators, which have no consumer.
  - `linux,rs485-enabled-at-boot-time`.
  - All `//` comments.
  - always-on/boot-on on `vcc5v0_host`/`otg`, and always-on on `vdd_npu_s0`.
  - The `wifi_host_wake_irq` pinctrl.
- Ethernet: gmac1 changed to `rgmii-id` with no delays. gmac0 keeps `rgmii-rxid` + `tx_delay = <0x44>`, with a comment (see the tests below). `snps,reset-*` moved to PHY `reset-gpios` with pinctrl.
- WiFi PCIe reset: changed from GPIO4_A5 (Armbian; that pin is uart3m2 TX, RS232) to GPIO1_B4, as in the vendor DT.
- Pinctrl and names:
  - LEDs use `function`/`color` and one shared pinctrl group. The power LED is `default-state = "on"`.
  - gpio-keys nodes are renamed `key-volume-*`.
  - PCIe reset pinctrl added.
  - hdmirx 5V detect changed to `pcfg_pull_none`, as in the YY3588 fix.
- es8388: the mclk pinctrl moved to the codec node.
- hdmi0: `frl-enable-gpios` GPIO4_B1 added (the vendor `enable-gpios`).
- Added `adc-keys` Recovery on saradc ch1 at 17 mV, as on other RK3588 boards. The vendor dtsi has an adc key at that threshold. **Verify with evtest.**
- Added, from the vendor DT:
  - **Type-C**: fusb302 on i2c6@0x22 (IRQ GPIO3_C7). VBUS `vcc5v0_otg` (GPIO4_A7). SBU dc GPIOs are GPIO0_C6/D3. DP altmode goes to dp0 (VP1) through usbdp_phy0, which uses the new `ports` scheme (`861e77f3314e`).
  - **DP**: dp1 (VP2) → full-size `dp-connector`, with `usbdp_phy1` lane mux `<0 1 2 3>`. `usb_host1_xhci` is therefore USB 2.0 only (`maximum-speed`, u2phy only).
  - ~~SD~~: dropped from v1, see "SD tests".
  - **USB3 host2**: `usb_host2_xhci` on `combphy2_psu`.
- eMMC stays at HS200. Armbian says HS400 "causes immediate trouble"; retest later.

## Decisions (user, 2026-11-18)

- Vendor prefix description: "Mekotronics Co., Ltd.", with `Link: https://www.mekotronics.com`.
- dts copyright: Ricardo Pardini only.
- uart0 (RS485) stays a plain UART with no rs485 properties. Userspace uses TIOCSRS485 if needed.
- Power LED: `default-state = "on"` (Armbian had `heartbeat`).
- Ordering:
  - Check with `scripts/dtc/dt-check-style --mode=strict <dts>`. It's in-tree since 2026-05, and its help calls it "required for new submissions".
  - Node names use the tool's natural sort. In that sort `regulator-vcc-1v1-*` comes after `regulator-vcc12v-*`.
  - Leave as Rockchip practice (Jonas on NanoPi R28S v6, Sept 2026, merged that way):
    - pinctrl-names before pinctrl-0, and no blank line before status.
    - aliases first in root.
    - adc-keys `linux,code` before press-threshold.
    - rk860x `fcs,suspend-voltage-selector` before regulator-*.
    - rk806 dcdc→pldo→nldo.
  - Names fixed by bindings are left as they are: AVDD-supply, clock_in_out, simple-audio-card,*.
  - The remaining strict findings are only those.

## Board tests (user)

First boot on 2026-11-18, Armbian bleedingedge 7.4.0-rc3, board at 192.168.66.175.


| What | Result |
|---|---|
| boot / dmesg clean | 7.4.0-rc3 bleedingedge boots, LCD overlay applied. dmesg is clean except for the pcie2x1l0 pin conflict (fixed, see below) |
| gmac0 / gmac1 (iperf3 both directions) | gmac0 `rgmii-id` **fails** (RX CRC errors, then end0 dead, 2 of 2 boots). gmac0 `rgmii-rxid`+0x44: clean. gmac1 `rgmii-id`: clean. gmac1 rxid+0x42: clean. ~945 Mbit/s each way in the clean cases |
| eMMC (HS200) | OK, HS200 8-bit at 187.5 MHz |
| SD card | **dropped from v1** (see below) |
| NVMe (pcie3x4) | OK (WD SN570) |
| SATA | ahci probes, link down (no disk?) |
| USB2 ports / USB3 host2 port | host2 xhci has SS (5000M); host1 is HS only, as intended. Devices not yet tested |
| Type-C host + device, both orientations, PD | host 5 Gbps OK in normal orientation; reverse works only after a usbdp PHY re-init (driver issue, see below). Port is source-only |
| Type-C DP altmode | dropped from the series (untested) |
| HDMI0 out (+ audio) | HDMI-A-1 connected; HDMI0 sound card present |
| DP out (dp1) | OK: HPD on GPIO3_D5 (dp1m0) follows the plug, EDID read (Dell U3415W), link trains at HBR2 x4 (monitor asks for swing level 3). The 1080p modetest pattern is stable with the monitor on the DP input. It flashed in the monitor's PIP mode, and the Dell drops HPD when DP isn't its active input. AUX timeouts only while HPD is low |
| HDMI-in (v4l2) | video nodes present |
| es8388 headphones | OK (2026-11-19, final dtb): speaker-test L/R correct and clean. Level is low with old Apple 4-pole in-ears, and only plays when the plug is fully seated (the earlier "silent" runs were most likely plug seating, not a codec latch). In-phase vs out-of-phase L/R only slightly different, so not a clear CTIA/OMTP mismatch |
| es8388 mic | Routing correct: the jack mic is on **LINPUT2** (as in the DT). RINPUT2 is silent. **Capture needs ES8388 reg 0x2B = 0x80 (`slrck`, ADC uses DACLRC)**: without it, SDI0 stays high and every sample is -1 (checked with GPIO1 EXT_PORT sampling: only MCLK/SCLK/LRCK toggle). The upstream es8328 driver never writes 0x2B; the vendor es8323 driver writes 0x80. Driver gap, not DT: keep the DT as it is (user, 2026-11-19); a driver fix can be a separate series. Speech level weak at +12 dB PGA (~-55 dBFS) |
| GPU (Mali-G610) | 2026-11-20: panthor probes; kmscube (Debian, installed with user OK; `sleep N \| kmscube -D /dev/dri/card1`, it quits on stdin EOF) renders via Mesa 25.0.7 Panfrost, GLES 3.1, spinning cube seen by the user on DP-1 and on HDMI-A-1. kmscube has no connector option: force the other one off with `echo off > /sys/class/drm/card1-DP-1/status`, then `detect` |
| RTC hym8563 | OK, rtc0 reads time |
| WiFi BCM43752 / BT | OK after the reset fix (GPIO1_B4): enumerates, scans. BT hci0 OK |
| LEDs, vol keys, recovery key | 3 LEDs, power on. evtest (2026-11-19): volume dial gives clean KEY_VOLUMEUP/DOWN pairs; recovery (button nearest the USB 3.0 Type-A) gives KEY_VENDOR, SARADC ch1 ~4085 idle / 39-44 pressed (~17-19 mV). The other button is the hardware reset (not in DT) |
| RS232 (uart3) / RS485 (uart0) | |
| NPU | 2026-11-20: Mesa Teflon/Rocket MobileNet v1 (`ghcr.io/rpardini/mesa-teflon-etnaviv-rocket-docker`): first run failed (`vdd_npu_s0: disabling` at ~32 s, then "failed to set domain 'nputop' on" + NPU job timeouts). **Fix: `&pd_npu { domain-supply = <&vdd_npu_s0>; }`**, which the original Armbian DT already had and the 2026-11-18 rework had dropped (14 of 17 upstream RK3588 NPU boards have it; amended into the dts patch, backup `backup/b4-meko-r58x-pro-pre-pd-npu-20261120`, and in Armbian). After: regulator stays on, classification OK (military uniform 0.87, ~12.7 ms/inference) |

## Apply check on mmind (2026-11-20)

- `kernel-mmind/v7.5-armsoc/dts64` at 30eb5fd93649 (2026-11-13): all 3 patches apply strictly (`git apply --check` on a clean checkout, no 3-way). rockchip.yaml entry (MangoPi M28K < Mekotronics < mqmaker), vendor-prefixes (megachips < mekotronics < mele) and Makefile (lubancat-5io < mekotronics < mnt-reform2) stay sorted.
- CHECK_DTBS W=1 there: only `vop@fdd90000: 'reset-names', 'resets' do not match`, which rock-5b also gets on that tree (from mmind f245313cd545 "Add RK3588 VOP2 resets", binding update not in that branch). Not ours.
- Scratch worktree: session scratchpad `wt-mmind`.

## Regression review vs the original Armbian DT (2026-11-20)

Structural diff (cpp + dtc -s of both, per node/property) of the original Armbian 7.4 DT (before the rework) against the series. Lost in the 2026-11-18 rework and restored:
- `&pd_npu { domain-supply }` (NPU jobs timed out) and `&pd_gpu { domain-supply = <&vdd_gpu_s0>; }` (36/38 upstream GPU boards have it).
- `pcfg_pull_up` on pcie30x4-pwren (GPIO1_C4), wifi-pwren (GPIO1_B1) and hdmirx-5v-det (GPIO1_D5), as in vendor + Armbian (the rework had changed them to pull_none without reason).
- WiFi host-wake pinctrl (GPIO1_A7 pull-down) on pcie2x1l0, after pcie2_0_rst (as rk3588-evb1-v10).
Backup: `backup/b4-meko-r58x-pro-pre-armbian-regress-20261120`. Board OK after: both domains hold their supply, PCIe/NVMe/WiFi up.

Intended differences (OK): rgmii-id on gmac1, Type-C/DP1/host2 additions, aliases/rs485 flag/i2c5/cpu mem-supply dropped, unused pcie30 avdd regulators dropped, vcc5v0_host has consumers (u2phy), rtc clock-frequency dropped, power LED default-on, frl-enable-gpios (maps vendor enable-gpios, common pattern).

Naming review (2026-11-20, user: avoid reviewer nags): LEDs `led-0/1/2` (leds-gpio binding preferred form), `dp-con` (Rockchip precedent; alt mode would hang off the usb-c-connector, so no second dp-connector). Backup `backup/b4-meko-r58x-pro-pre-naming-20261120`. Kept: `key-volume-*` (most common arm64), regulator-* names/labels consistent and all used, pinctrl group names (free-form). dt-check-style reports outside the cover's list also follow Rockchip majority: `linux,code` before `press-threshold-microvolt` (21/22), `fcs,suspend-voltage-selector` before `regulator-name` (32/36), rk806 dcdc→pldo→nldo, aliases first, `ROCKCHIP_VOP2_EP_*` unit addresses. Lore research: Krzysztof/Heiko nag on regulator-* consistency, unused regulators, odd sorting, double blank lines; all clean.

## Armbian (armbian-build `extensions`)

- `rockchip64-7.4` (edge since 2026-11-20; bleedingedge is 7.5): the DT is byte-identical to the kernel series. Keep it in sync on every revision (`cp` from the worktree).
- The segment LCD is the overlay `rockchip-rk3588-mekotronics-r58x-pro-lcd.dtso`, enabled with `overlays=mekotronics-r58x-pro-lcd`. It's on by default for non-vendor branches through `DEFAULT_OVERLAYS` in the board `.csc`.
- `rockchip64-7.3` (edge) and the u-boot v2026.10 copy keep the old DT, with the LCD inline. On edge, the default overlay is just "not found".
- The old variant with the LCD inline is kept as backup branch `backup/extensions-meko-lcd-inline-20261118`.
- `lcd-clock.service` (board .csc) used `/sys/devices/platform/lcd_vk2c21/display`, which only exists with the vendor DT; with the overlay the node is `segment-lcd`, so the service was skipped every minute. Fixed 2026-11-20 (in Armbian and on the board): it now uses `/sys/bus/platform/drivers/lcd-vk2c21/*/display`.

### Ethernet delay tests (2026-11-18)

- Method: on the board, set `arp_ignore=1`/`arp_announce=2` plus per-source policy routes (both ports are on one subnet, so otherwise all TX goes out through end0). Then a 120 s iperf3 run from this VM per port and direction, followed by pings to the gateway (`-I`, 56/1400 bytes) and `mmc_rx_crc_error`. Script: session scratchpad `ethtest.sh`.
- A, both `rgmii-id`: end0 had 1011 CRC errors during the first run, then 100% loss. The first boot also had 315 CRC errors and lost pings.
- B, both rxid (0x44/0x42): everything clean.
- C, gmac0 rxid 0x44 + gmac1 `rgmii-id`: everything clean. This is what the series uses.
- Precedent for rxid+tx_delay with a comment: YY3588 (66f407e2c3b9), QuartzPro64, OPi 5.
- The board currently boots this dtb. The CI dtb is saved as `/boot/dtb/rockchip/rk3588-mekotronics-r58x-pro.dtb.orig-ci`.

### Type-C tests (2026-11-18)

- A USB-C stick (works on other hosts) and a USB-C 2.5G NIC were used.
- fusb302 (ID 0x91) only saw `cc1=Rd` once, briefly, on the first plug. The flow was SRC_ATTACH_WAIT → Try.SNK → SRC_TRYWAIT_UNATTACHED, then CC went Open. After that it sees nothing on either CC, in either orientation:
  - TOGSS stays 0 (toggle running) and there are no IRQs (pin high).
  - Setting `preferred_role=source` and restarting the port didn't help.
  - Most mainline RK3588 fusb302 boards use `try-power-role = "source"`; this DT and the vendor's use `"sink"`.
- Forcing VBUS on (GPIO4_A7 through devmem) sets fusb302 STATUS0.VBUSOK, so VBUS sensing on this connector is wired. But with usb_role=host, neither the HS nor the SS xHCI port sees a connect (portsc RxDetect). Reverted afterwards.
- The old Armbian DT had no fusb302: vcc5v0_otg always-on, usb_host0_xhci `dr_mode = "host"`, `u2phy0_otg` commented "for fc000000.usb UDC", usbdp_phy0 `dp-lane-mux = <2 3>`.
- Vendor DT: dp0 is `disable`d, so DP alt mode was likely never functional there either.
- **Root cause of no detection:** the source PDO was 5V/3A, so tcpm used Rp-3.0. With Rp-3.0 the fusb302 hardware toggle never reports a sink: TOGSS stays 0, tested by hand over i2c with every POWER setting. With Rp-default or Rp-1.5 it reports SRC on CC2 right away. Manual MDAC sweep: CC lines float at about 0 V and the partner's Rd reads about 1.64 V. Fixed in the series: `power-role = "source"` (the user confirmed the board can't be powered from USB-C), `source-pdos` 5V/1.5A (as on Jaguar), no try-power-role or sink PDOs.
- With that fix: attach, orientation, VBUS and host role all work. A USB-C 2.5G NIC enumerates at 5 Gbps in normal orientation.
- **Reverse orientation:** tcpm reports `reverse` and the usbdp PHY flags "re-init required", but the PHY is only re-initialized from `rk_udphy_power_on()` (dwc3 phy_init). With a dwc3 rebind plus `usb_role=host`, the log shows "reinit PHY ... flipped=yes" and the NIC enumerates at 5 Gbps in reverse. So the wiring is fine in both orientations, and the problem is in the driver: the usbdp/dwc3 path doesn't re-init on orientation change. Under the old Armbian DT (no fusb302) reverse didn't work at all.
- **Decision (user):** drop DP alt mode from the series (untested; the vendor DT has dp0 disabled). dp0, altmodes, SBU dc GPIOs and usbdp_phy0 port@2/@3 are removed, and the full-size DP is now DRM `DP-1`. The reverse-orientation limitation is noted in the cover letter.

### Type-C reverse orientation, root cause (2026-11-19)

- Known upstream issue. Sebastian Reichel's usbdp series lists it from the start ("Switching the USB-C connector orientation during hotplug breaks USB3 speed, as the PHY is not being re-initialized"); Sashiko flagged our exact case on several versions.
- Merged in 7.4: only the flag (`phy_needs_reinit`, part 2). USB3 re-init happens only via dwc3 `phy_init` (probe/rebind), which matches what we saw.
- Pending fix: usbdp part3 v18 `<20261119-b4-rockchip-usbdp-cleanup-part3-v18-0-fb325e336494@collabora.com>` ("Re-init PHY on mux change") + dwc3 Rockchip glue v19 `<20261114-b4-rockchip-dwc3-rockchip-glue-v19-0-b79fb5f4b42a@collabora.com>` (USBDP PHY reset quirk). The re-init goes through the mode-switch path (`typec_set_mode`).
- Sebastian, part3 v18 cover: orientation-switch without mode-switch is a DT bug ("mode-switch should be added"; jaguar is one of the two upstream DTs doing it). **Series now has `mode-switch` on usbdp_phy0** (user, 2026-11-19; backup `backup/b4-meko-r58x-pro-pre-mode-switch-20261119`). CHECK_DTBS clean.
- Vendor kernel 6.1.172 (installed alongside, extlinux menu): reverse orientation enumerates at 5000M on hotplug with no rebind. It re-creates the xHCI on attach (new xhci-hcd instance), i.e. dwc3 re-init → PHY re-init. Wiring is fine both ways.
- Cover: point to the pending fix with lore links, not our own analysis (user).
- Tested with Sebastian's series on the board (2026-11-19/20): hotplug normal/reverse/normal, PHY re-init `flipped=yes/no` each time, SuperSpeed every time; cold boot reverse OK. Tested-by tags to send: [`tested-by-pending.md`](tested-by-pending.md).

### Vendor kernel audio (2026-11-19)

- Vendor driver sets 0x2B = 0x80 (slrck) itself. Capture works; jack mic on LINPUT2 (left) at the same weak level as mainline+slrck (~-50 dBFS speech, -62 floor). Confirms DT routing.
- Vendor headphone playback does not work at all: the vendor DT's card routing ("Headphone" ← LOUT1) doesn't connect to the es8323 driver's widgets (Headphone "in 0", Left Out 1 "out 0"), so DAPM never powers the DAC.
- Mainline es8328 labels Output 1 as -30 dB/1 dB steps; the register (and vendor es8323) is -45 dB/1.5 dB steps.

### Board boot setup (2026-11-19)

- DP alt mode retest prepared (2026-11-20, user looking for a USB-C→DP cable): worktree branch `test/meko-dp-altmode-20261120` = series + the dropped altmode blocks (dp0/VP1, connector altmodes + SBU port@2, usbdp_phy0 SBU dc GPIOs + port@2/@3; sdmmc stays out). CHECK_DTBS clean. On the board as extlinux entry `mainline-altmode` (`rk3588-mekotronics-r58x-pro-altmode-test.dtb`, built with `DTC_FLAGS=-@` so the LCD overlay applies). Needs dw-dp v12 OOB HPD (in the Armbian kernel).
- Worktree dtbs built without `DTC_FLAGS=-@` have no `__symbols__`; the LCD overlay then can't apply.
- DP alt mode test (2026-11-20), USB-C→DP cable to the Dell's full-size DP input:
  - Mainline (`mainline-altmode`): Discover Identity/SVIDs (0xff01)/Modes (VDO 0x405) → Enter Mode → DP Status → DP Configure OK; PHY "reinit ... USB3=off and DP=on (4 lanes)", `flipped=no` and (after flipping the USB-C end) `flipped=yes`; partner `configuration: sink`, pin assignment C. OOB HPD reaches dw-dp ("Force HPD connected=no" on unplug). But the adapter never sends an Attention with HPD: `hpd=0`, DP connectors disconnected, monitor "no DP cable".
  - Vendor kernel with dp0 enabled (`vendor-dp0` extlinux entry, fdtput copy of the vendor dtb: dp0 + VP1 endpoint + route-dp0 okay): same VDM sequence, same missing HPD.
  - **The cable is dead**: it doesn't work on another host either (user). Board side looks fine both ways; inconclusive for a picture. DP alt mode stays out of v1 unless a working cable turns up; test setup (branch `test/meko-dp-altmode-20261120`, extlinux `mainline-altmode`/`vendor-dp0`) is kept for that.
- **DP alt mode test 2 (2026-11-20): works.** Apple USB-C Digital AV Multiport Adapter (05ac:1463 billboard, 05ac:1017/1018 hubs; HDMI only plugged in, no power in, nothing on USB-A) → small HDMI monitor (EDID "RTK 32V3H-H6A", native 1080p60, preferred DTD 720p).
  - Branch `test/meko-dp-altmode-v2-20261120` = local v2 (Sashiko fixes) + the altmode commit picked from `test/meko-dp-altmode-20261120` (clean pick). CHECK_DTBS: only the `pcie@fe150000` / `pcie-ep@fe150000` unique_unit_address warning from `rk3588-extra.dtsi`. Installed on the board as `rk3588-mekotronics-r58x-pro-altmode-test.dtb` in the bleedingedge dtb dir (v1-based one kept as `.v1-20261120`); kernel 7.4.0-rc3-bleedingedge.
  - Partner modes: DP (SVID ff01, VDO 0xc05: pin assignments C, D) + two Apple SVID 05ac modes. Adapter picks **pin assignment D** (2 DP lanes + USB3); orientation reverse. `hpd=1`.
  - DPCD: rev 1.4, max HBR3, 2 lanes; DP branch OUI 00-10-fa "cHDMIb" (Apple DP→HDMI). With dp0 enabled, the Type-C output is DRM `DP-1` (fde50000, VP1) and the full-size DP becomes `DP-2`.
  - fbcon came up at 720p; `modetest -M rockchip -s 87@84:1920x1080-60`: stable 1080p60, perfect picture (user). The adapter's USB3.1 hub enumerates at 5 Gbps in reverse orientation after the mode change (usbdp part3 re-init path).
  - **Boot-time HPD race:** the adapter's DP Status/Attention with HPD arrives at ~3.2 s, before dw-dp (module) binds at ~5.0 s; typec_displayport logs "no extcon found for current port, not notifying hpd change" and nothing re-checks HPD later, so DP-1 stays disconnected after a cold boot. Workaround: `echo 0 > /sys/class/typec/port0-partner/port0-partner.0/active; echo 1 > .../active` (or replug). Driver issue (dw-dp OOB HPD / typec_displayport), not DT.
    - Correction (later the same day): "no extcon found" is harmless noise. Once dw-dp is bound, OOB HPD works: after a hot replug/flip, dw-dp retrains on its own (`0x100 <- 1e 82`, HBR3 x2) and the picture comes back. Only the very first HPD at boot (before dw-dp binds) is lost.
  - **USB-A on the adapter** (SanDisk Extreme Pro, 0781:5588):
    - First plug (reverse orientation): enumerated at 5 Gbps, one SS reset + READ I/O error, dropped after ~17 s; adapter SS hub "set hub depth failed", xHCI port power cycle, stick fell back to 480M. The picture glitched and then went "no signal" with DRM still reporting DP-1 connected/enabled; no Type-C/PD or PHY events logged (drm debug was off). Picture came back after re-entering the alt mode (`active` 0/1). Not reproduced afterwards.
    - USB2 fallback: 800 MiB at 37.6 MB/s, clean.
    - After an adapter replug, reverse: 1.6 GiB at 203 MB/s at 5 Gbps, no errors, picture clean (user).
  - **Orientation change** (hot flip reverse → normal, adapter with HDMI + stick): `orientation normal`, DP alt mode re-entered (pin D, hpd=1), dw-dp retrained automatically, picture back without intervention (user); stick at 5 Gbps, 1.6 GiB at 220 MB/s, picture clean. A few "PD retry failed" during SRC_STARTUP (known, harmless).
  - Hot flip back normal → reverse: same result (auto retrain, picture back, stick 221 MB/s at 5 Gbps), and 1080p60 modetest stable in reverse (user). User then OK'd folding DP alt mode into v2.

- `/boot/extlinux/extlinux.conf`: `edge` (default since 2026-11-20; Armbian edge 7.4 + its dtb + LCD overlay), `mainline` (bleedingedge 7.4 + series dtb + LCD overlay) and `vendor` (6.1.172 vendor-rk35xx, `rk3588-blueberry-edge-v12-maizhuo-linux.dtb`). boot.scr stays as fallback; `/boot/Image`, `dtb`, `uInitrd` symlinks point at 7.4 edge.
- Armbian rockchip64-7.4 test patches (b4 dumps, not committed yet): rk35xx-1240 dwc3 glue v19, 1241 usbdp part3 v18, 1242 fusb302 probe cleanup v1, 1243 inno-usb2 clock fix v4, 1244 drm/bridge include removal (941e3acfb358, prereq for 1245), 1245 dw-dp improvements v12.
- Reference tree: worktree `kernel-collabora-rockchip-devel` (detached `kernel-collabora-rk3588/rockchip-devel`, same base as the series).

### SD tests (2026-11-18)

- Native card detect (sdmmc_det, GPIO0_A4) doesn't fire on hot-plug while dw_mmc is runtime-suspended: the IRQ count stays 0. With `cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>` plus a GPIO-function pinctrl group (as on rock-5a and OPi 5), detection works.
- The card never answers: CMD0 goes out, then CMD8 and all CMD55 return -110 at 400/300/200 kHz. `vcc_3v3_s0` is on and `vccio_sd_s0` is at 3.3 V. The data/cmd lines (GPIO4_D0/D1/D4) twitch on insert.
- The SoC's `sdmmc_pwren` (GPIO0_A5) is used by spi2m2 (the PMIC), so it's not that.
- User: SD worked on the vendor OS, but only in slow mode. No Armbian DT for this family ever had sdmmc.
- **Decision (user):** drop sdmmc from v1. Keep the cd-gpios variant for when it's revisited. Next ideas: dump the vendor kernel's GPIO and regulator state with a card inserted, and look for a switched VDD or a level shifter enable.
