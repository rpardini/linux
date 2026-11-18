# K30: Mekotronics R58X-Pro (RK3588) upstream DT

- Branch `b4/rk3588-mekotronics-r58x-pro` (b4 prep, cover strategy commit), worktree `kernel-rk3588-meko-r58x-pro`, base `kernel-torvalds/master` (v7.4-rc2+). Check that it applies on `kernel-mmind/v7.5-armsoc/dts64` before sending.
- Sources:
  - Armbian DT: `armbian-build/patch/kernel/archive/rockchip64-7.4/dt/rk3588-mekotronics-r58x-pro.dts`. The u-boot v2026.10 `dt_upstream_rockchip` copy is identical.
  - Vendor 6.1 DT: `kernel-armbian-linux-rockchip/rk-6.1-rkr7.2:arch/arm64/boot/dts/rockchip/rk3588-blueberry-edge-v12{.dtsi,-maizhuo-linux.dts}` (+ `rk3588-blueberry.dtsi`).
  - No public schematic exists.
- Not in the series: the VK2C21 segment LCD (stays in Armbian only).

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
| es8388 headphones / mic | card rockchip-es8388 present |
| RTC hym8563 | OK, rtc0 reads time |
| WiFi BCM43752 / BT | OK after the reset fix (GPIO1_B4): enumerates, scans. BT hci0 OK |
| LEDs, vol keys, recovery key | 3 LEDs, power on. gpio-keys + adc-keys inputs registered; evtest TODO |
| RS232 (uart3) / RS485 (uart0) | |
| NPU probe | OK (accel0) |

## Armbian (armbian-build `extensions`)

- `rockchip64-7.4` (bleedingedge): the DT is byte-identical to the kernel series. Keep it in sync on every revision (`cp` from the worktree).
- The segment LCD is the overlay `rockchip-rk3588-mekotronics-r58x-pro-lcd.dtso`, enabled with `overlays=mekotronics-r58x-pro-lcd`. It's on by default for non-vendor branches through `DEFAULT_OVERLAYS` in the board `.csc`.
- `rockchip64-7.3` (edge) and the u-boot v2026.10 copy keep the old DT, with the LCD inline. On edge, the default overlay is just "not found".
- The old variant with the LCD inline is kept as backup branch `backup/extensions-meko-lcd-inline-20261118`.

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

### SD tests (2026-11-18)

- Native card detect (sdmmc_det, GPIO0_A4) doesn't fire on hot-plug while dw_mmc is runtime-suspended: the IRQ count stays 0. With `cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>` plus a GPIO-function pinctrl group (as on rock-5a and OPi 5), detection works.
- The card never answers: CMD0 goes out, then CMD8 and all CMD55 return -110 at 400/300/200 kHz. `vcc_3v3_s0` is on and `vccio_sd_s0` is at 3.3 V. The data/cmd lines (GPIO4_D0/D1/D4) twitch on insert.
- The SoC's `sdmmc_pwren` (GPIO0_A5) is used by spi2m2 (the PMIC), so it's not that.
- User: SD worked on the vendor OS, but only in slow mode. No Armbian DT for this family ever had sdmmc.
- **Decision (user):** drop sdmmc from v1. Keep the cd-gpios variant for when it's revisited. Next ideas: dump the vendor kernel's GPIO and regulator state with a card inserted, and look for a switched VDD or a level shifter enable.
