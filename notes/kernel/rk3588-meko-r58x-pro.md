# K30: Mekotronics R58X-Pro (RK3588) upstream DT

- Branch `b4/rk3588-mekotronics-r58x-pro` (b4 prep, cover strategy commit), worktree `kernel-rk3588-meko-r58x-pro`, base `kernel-torvalds/master` (v7.4-rc2+). Check that it applies on `kernel-mmind/v7.5-armsoc/dts64` before sending.
- Sources:
  - Armbian DT: `armbian-build/patch/kernel/archive/rockchip64-7.4/dt/rk3588-mekotronics-r58x-pro.dts`. The u-boot v2026.10 `dt_upstream_rockchip` copy is identical.
  - Vendor 6.1 DT: `kernel-armbian-linux-rockchip/rk-6.1-rkr7.2:arch/arm64/boot/dts/rockchip/rk3588-blueberry-edge-v12{.dtsi,-maizhuo-linux.dts}` (+ `rk3588-blueberry.dtsi`).
  - No public schematic exists.
- Not in the series: the VK2C21 segment LCD (stays in Armbian only).

## Resume here (paused 2026-11-18)

- **Series state:** 3 patches plus the cover, all checks clean (`CHECK_DTBS`, dt-check-style with only the known exceptions). Changes made today, each with a `backup/b4-meko-r58x-pro-pre-*-20261118` branch:
  1. WiFi PCIe reset → GPIO1_B4.
  2. gmac0 `rgmii-rxid` + `tx_delay` 0x44, with a one-line comment.
  3. Type-C source-only, 1.5 A PDO.
  4. DP altmode dropped.
  5. sdmmc dropped.
- **Cover letter:** has paragraphs on dt-check-style, gmac0 and Type-C (reverse orientation and altmode). The working copy is in the session scratchpad (`meko-cover.txt`) and may be gone; to edit, regenerate it from the cover commit and use `GIT_EDITOR="cp <file>" b4 prep --edit-cover`.
- **armbian-build `extensions`:** the 7.4 DT is byte-identical to the series. The user pushes and builds in CI.
- **Board (192.168.66.175 end0 / .174 end1, root ssh):**
  - The final series dtb (without sdmmc) is copied to `/boot/dtb/rockchip/` but **not booted yet**. The CI one is saved as `.dtb.orig-ci`.
  - Tools installed: iperf3, evtest, alsa-utils, i2c-tools, gpiod, libdrm-tests (modetest), edid-decode.
  - Helper scripts in `/root`: `dpwatch.sh`, `dpauto.sh` (start modetest on HPD), `usbwatch.sh`, `cdwatch.sh`, `gpiowatch.sh`.
  - modetest needs stdin held open (`sleep N | modetest ...`).
  - Use 1080p on the Dell DP monitor, not PIP mode.
- **Plan agreed 2026-11-19 (board offline then):** when the board is back, rebuild the dtb, deploy it, then reboot (check the boot config first). Then run only **keys (evtest: volume dial, recovery adc key) + es8388 audio**. The other tests below are skipped. Cover (user, 2026-11-19): replace the itemised "Tested:" line with one short sentence covering only what was exercised. Precedent: YY3588 "tested on the board", Axon Lite/LubanCat 4 "boots to userspace...". Untested-but-enabled nodes (USB-A, SATA, RS232/RS485, HDMI-in) stay as they are and the cover says nothing about them. If a reviewer asks, answer "per schematic/vendor DT" (cf. Charkov on OPi 5 Pro v6: "Not tested, not needed, why bother?").
- **Done 2026-11-19:** keys pass. Audio: headphones work; the mic needs the es8328 `slrck` driver fix (see Board tests). The cover's "Tested:" TODO is replaced by one sentence (eMMC + NVMe boot, both GbE, USB 3.0 over Type-C, HDMI/DP out, headphone audio, RTC, WiFi/BT, LEDs, keys); backup `backup/b4-meko-r58x-pro-pre-tested-20261119`. Next: the user's wording review of the cover and the 3 commits, then the "Before sending" checks.
- **Remaining board tests (the user plugs things in, skipped per the plan above):**
  - USB-A devices
  - SATA disk
  - evtest for the volume dial and the recovery adc key
  - es8388 headphones/mic (aplay/arecord)
  - RS232 (uart3) / RS485 (uart0)
  - HDMI-in (v4l2)
  - NVMe load
  - Then fill the cover letter's "Tested:" line.
- **Before sending:**
  - The user reviews all wording and adds their SoB.
  - `b4 prep --check`, `--auto-to-cc`, `b4 send --dry-run`.
  - Check that the series still applies on `kernel-mmind/v7.5-armsoc/dts64`.
  - Never send without an explicit OK.
- **Optional later:**
  - usbdp/dwc3 driver fix so the PHY re-inits on orientation change.
  - SD slot debug (vendor kernel GPIO/regulator dump).
  - DP altmode, if a USB-C DP sink turns up.

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
| NPU | 2026-11-20: Mesa Teflon/Rocket MobileNet v1 (`ghcr.io/rpardini/mesa-teflon-etnaviv-rocket-docker`): first run failed (`vdd_npu_s0: disabling` at ~32 s, then "failed to set domain 'nputop' on" + NPU job timeouts). **Fix: `&pd_npu { domain-supply = <&vdd_npu_s0>; }`** (14 of 17 upstream RK3588 NPU boards have it; amended into the dts patch, backup `backup/b4-meko-r58x-pro-pre-pd-npu-20261120`, armbian 54669da48). After: regulator stays on, classification OK (military uniform 0.87, ~12.7 ms/inference) |

## Armbian (armbian-build `extensions`)

- `rockchip64-7.4` (bleedingedge): the DT is byte-identical to the kernel series. Keep it in sync on every revision (`cp` from the worktree).
- The segment LCD is the overlay `rockchip-rk3588-mekotronics-r58x-pro-lcd.dtso`, enabled with `overlays=mekotronics-r58x-pro-lcd`. It's on by default for non-vendor branches through `DEFAULT_OVERLAYS` in the board `.csc`.
- `rockchip64-7.3` (edge) and the u-boot v2026.10 copy keep the old DT, with the LCD inline. On edge, the default overlay is just "not found".
- The old variant with the LCD inline is kept as backup branch `backup/extensions-meko-lcd-inline-20261118`.
- `lcd-clock.service` (board .csc) used `/sys/devices/platform/lcd_vk2c21/display`, which only exists with the vendor DT; with the overlay the node is `segment-lcd`, so the service was skipped every minute. Fixed 2026-11-20 (armbian 2591fe880, and on the board): it now uses `/sys/bus/platform/drivers/lcd-vk2c21/*/display`.

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

- `/boot/extlinux/extlinux.conf`: `mainline` (default; 7.4 + series dtb + LCD overlay) and `vendor` (6.1.172 vendor-rk35xx, `rk3588-blueberry-edge-v12-maizhuo-linux.dtb`). boot.scr stays as fallback; `/boot/Image`, `dtb`, `uInitrd` symlinks point at 7.4.
- Armbian rockchip64-7.4 test patches (b4 dumps, not committed yet): rk35xx-1240 dwc3 glue v19, 1241 usbdp part3 v18, 1242 fusb302 probe cleanup v1, 1243 inno-usb2 clock fix v4, 1244 drm/bridge include removal (941e3acfb358, prereq for 1245), 1245 dw-dp improvements v12.
- Reference tree: worktree `kernel-collabora-rockchip-devel` (detached `kernel-collabora-rk3588/rockchip-devel`, same base as the series).

### SD tests (2026-11-18)

- Native card detect (sdmmc_det, GPIO0_A4) doesn't fire on hot-plug while dw_mmc is runtime-suspended: the IRQ count stays 0. With `cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>` plus a GPIO-function pinctrl group (as on rock-5a and OPi 5), detection works.
- The card never answers: CMD0 goes out, then CMD8 and all CMD55 return -110 at 400/300/200 kHz. `vcc_3v3_s0` is on and `vccio_sd_s0` is at 3.3 V. The data/cmd lines (GPIO4_D0/D1/D4) twitch on insert.
- The SoC's `sdmmc_pwren` (GPIO0_A5) is used by spi2m2 (the PMIC), so it's not that.
- User: SD worked on the vendor OS, but only in slow mode. No Armbian DT for this family ever had sdmmc.
- **Decision (user):** drop sdmmc from v1. Keep the cd-gpios variant for when it's revisited. Next ideas: dump the vendor kernel's GPIO and regulator state with a card inserted, and look for a switched VDD or a level shifter enable.
