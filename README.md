#### kernel patching: 19 total patches; 19 applied; 14 with problems; 8 not_mbox; 11 needs_rebase

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[/opt/build_armbian/extensions/cache/patch/kernel-drivers/]` `6.1_mvebu_cdd39e74d3031865` | `(+0/-0)[]` | 7944a2e150b7af72121a1e7e21dcf1cfa0e8c71a `?` | `Armbian Autopatcher` _[AUTOGEN] /opt/build_armbian/extensions/cache/patch/kernel-drivers/6.1_mvebu_cdd39e74d3031865_ |
| ⚠️`[not_mbox]`  | `0001-cpuidle-mvebu-indicate-failure-to-enter-deeper-sleep` | `(+5/-1)[1M]` | 2614db725e37f8480899cfb37ad0c41f37b34ad6 `cpuidle-mvebu-v7.c` | `Igor Pecovnik` _[ARCHEOLOGY] Patches for Marvell Armada, kernel 4.3 and 4.4_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `09-pci-link-retraining` | `(+79/-6)[3M]` | 677b615b17a30d33fc919324776374e6a5035bba `aspm.c`, `quirks.c`, `pci.h` | `Heisath` _[ARCHEOLOGY] Add PCIe Wifi quirks patch for Atheros and Qualcomm cards_ |
| ⚠️`[needs_rebase]`  | `10-mvebu-clearfog-pcie-updates` | `(+86/-0)[4M]` | d67cdb6fb29d96488f741ec722a7151693fde636 `pci-mvebu.c`, `aspm.c`, `pci-bridge-emul.c`, `portdrv_core.c` | `Russell King` _mvebu/clearfog pcie updates_ |
| ✅  | `11-implement-slot-capabilities-SSPL` | `(+20/-0)[1M]` | a126d2cf35746edeea537cb1c3b09542b511ea17 `pci-mvebu.c` | `Russell King` _implement slot capabilities (SSPL)_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+1108/-0)[2M, 1A]` | 97c5c647cb76a645ae7aefc982bcd39d494727ff `mv88e6xxx_debugfs.c`, `chip.c`, `chip.h` | `Vivien Didelot` _net: dsa: mv88e6xxx: add debugfs interface_ |
| ✅  | `12-net-dsa-mv88e6xxx` | `(+3/-0)[1M]` | 581f076aba245dfd156eace556a171d545c58911 `port.h` | `Russell King` _net: dsa: mv88e6xxx: debugfs hacks to fix the compile_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+20/-0)[1M]` | 7e84c7edf8851a77f64c51c666c812a72eae3de3 `chip.c` | `Russell King` _net: dsa: program 6176 LED registers_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+12/-0)[1M]` | 357eb698ce35cb9429f46c319ec6a7b59fcc0b9e `chip.c` | `Russell King` _net: dsa/mv88e6xxx: add support for rate-matching PHYs_ |
| ⚠️`[needs_rebase]`  | `20-pcie-bridge-emul` | `(+10/-5)[1M]` | 58f66860afdac9fb6d8475b613dd2d17b91406e7 `pci-bridge-emul.c` | `Russell King` _PCI: pci-bridge-emul: re-arrange register tests_ |
| ✅  | `412-ARM-dts-armada388-clearfog-emmc-on-clearfog-base` | `(+63/-0)[1M, 1A]` | 325493e9486e017cf7a6560d8ca9c8ce97b0f7ed `armada-38x-solidrun-microsom-emmc.dtsi`, `armada-388-clearfog-base.dts` | `Russell King` _ARM: dts: armada388-clearfog: emmc on clearfog base_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `92-mvebu-gpio-add_wake_on_gpio_support` | `(+35/-2)[1M]` | ea27c9dd0221d7d2ad6e1a0cfa00f45e6868019a `gpio-mvebu.c` | `Aditya Prayoga` _[ARCHEOLOGY] kernel: mvebu-next: Add Wake on GPIO support_ |
| ⚠️`[needs_rebase]`  | `92-mvebu-gpio-remove-hardcoded-timer-assignment` | `(+154/-83)[1M]` | e293d531d1914a4e5803280e6f746945b7f39b06 `gpio-mvebu.c` | `Heisath` _Removes the hardcoded timer assignment of timers to pwm controllers_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `94-helios4-dts-add-wake-on-lan-support` | `(+12/-0)[1M]` | b6d38a8b6f3b52afbe2fa3e85ee8930ceee29c4c `armada-388-helios4.dts` | `Aditya Prayoga` _[ARCHEOLOGY] mvebu-next: helios4: Add Wake on LAN support_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `compile-dtb-with-symbol-support` | `(+3/-0)[1M]` | 53ee61b1c680f0f56a42b72a6f04bdf8c9fb637c `Makefile.lib` | `Aditya Prayoga` _[ARCHEOLOGY] Added overlay support_ |
| ⚠️`[not_mbox]`  | `dts-disable-spi-flash-on-a388-microsom` | `(+1/-0)[1M]` | a8b93ba99e7cd6972433db7941be6d4ca9b48ab6 `armada-38x-solidrun-microsom.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Move mvebu DEFAULT, NEXT and DEV branch to next kernel (LTS) and U-boot #1426 (#1487)_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `general-increasing_DMA_block_memory_allocation_to_2048` | `(+1/-1)[1M]` | 0bfa459b3efd150a1baf02ef1406aacfa2b2b579 `dma-mapping.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ⚠️`[not_mbox]`  | `unlock_atheros_regulatory_restrictions` | `(+9/-16)[1M]` | 2340a8f422294b7838a9753141f0f53d238d9b83 `regd.c` | `Igor Pecovnik` _[ARCHEOLOGY] A set of patches enables consumer grade Atheros wireless card 5Ghz AP mode + working hostapd example_ |
| ✅  | `use-1000BaseX-clearfog-switch` | `(+2/-8)[1M]` | 717532863cbb0318e8f33b4360a48c6c01cd6f6a `armada-388-clearfog.dts` | `Russell King` _ARM: dts: armada388-clearfog: use 1000BaseX mode for 88e6176 switch_ |


