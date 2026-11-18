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
- Ethernet: `rgmii-rxid` + `tx_delay` changed to `rgmii-id` with no delays (**needs a board test**). `snps,reset-*` moved to PHY `reset-gpios` with pinctrl.
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

## Board tests (user)

| What | Result |
|---|---|
| boot / dmesg clean | |
| gmac0 / gmac1 with rgmii-id (iperf3 both directions) | |
| eMMC (HS200) | |
| SD card | |
| NVMe (pcie3x4) | |
| SATA | |
| USB2 ports / USB3 host2 port | |
| Type-C host + device, both orientations, PD | |
| Type-C DP altmode | |
| HDMI0 out (+ audio) | |
| DP out (dp1) | |
| HDMI-in (v4l2) | |
| es8388 headphones / mic | |
| RTC hym8563 | |
| WiFi BCM43752 / BT | |
| LEDs, vol keys, recovery key | |
| RS232 (uart3) / RS485 (uart0) | |
| NPU probe | |

## Armbian (armbian-build `extensions`)

- `rockchip64-7.4` (bleedingedge): the DT is byte-identical to the kernel series. Keep it in sync on every revision (`cp` from the worktree).
- The segment LCD is the overlay `rockchip-rk3588-mekotronics-r58x-pro-lcd.dtso`, enabled with `overlays=mekotronics-r58x-pro-lcd`. It's on by default for non-vendor branches through `DEFAULT_OVERLAYS` in the board `.csc`.
- `rockchip64-7.3` (edge) and the u-boot v2026.10 copy keep the old DT, with the LCD inline. On edge, the default overlay is just "not found".
- The old variant with the LCD inline is kept as backup branch `backup/extensions-meko-lcd-inline-20261118`.
