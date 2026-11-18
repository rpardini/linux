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
  - **SD**: `sdmmc` 4-bit SDR104, with `vccio_sd_s0` as vqmmc and no vmmc (the vendor has none either).
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
| SD card | mmc1 probes; no card inserted |
| NVMe (pcie3x4) | OK (WD SN570) |
| SATA | ahci probes, link down (no disk?) |
| USB2 ports / USB3 host2 port | host2 xhci has SS (5000M); host1 is HS only, as intended. Devices not yet tested |
| Type-C host + device, both orientations, PD | fusb302 registers (SNK_UNATTACHED, role device). Not yet tested with anything attached |
| Type-C DP altmode | DP-1 connector present, disconnected |
| HDMI0 out (+ audio) | HDMI-A-1 connected; HDMI0 sound card present |
| DP out (dp1) | DP-2 connector present, disconnected |
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
