#### kernel patching: 20 total patches; 20 applied; 14 with problems; 8 not_mbox; 11 needs_rebase

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[/opt/build_armbian/extensions/cache/patch/kernel-drivers/]` `6.1_mvebu_cdd39e74d3031865` | `(+0/-0)[]` | 8c9776a815ec7b73b0806c6b5efac4c5afaa8b3f `?` | `Armbian Autopatcher` _[AUTOGEN] /opt/build_armbian/extensions/cache/patch/kernel-drivers/6.1_mvebu_cdd39e74d3031865_ |
| ⚠️`[not_mbox]`  | `0001-cpuidle-mvebu-indicate-failure-to-enter-deeper-sleep` | `(+5/-1)[1M]` | ad800b46d5dddf3d7456dbdca7bb869c958333af `cpuidle-mvebu-v7.c` | `Igor Pecovnik` _[ARCHEOLOGY] Patches for Marvell Armada, kernel 4.3 and 4.4_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `09-pci-link-retraining` | `(+79/-6)[3M]` | abc89f4cc2a17441796374a0cecc4739603a1b3f `aspm.c`, `quirks.c`, `pci.h` | `Heisath` _[ARCHEOLOGY] Add PCIe Wifi quirks patch for Atheros and Qualcomm cards_ |
| ⚠️`[needs_rebase]`  | `10-mvebu-clearfog-pcie-updates` | `(+86/-0)[4M]` | 2e12dfbd23885eaa6eb524cb447800b9498bce9e `pci-mvebu.c`, `aspm.c`, `pci-bridge-emul.c`, `portdrv_core.c` | `Russell King` _mvebu/clearfog pcie updates_ |
| ✅  | `11-implement-slot-capabilities-SSPL` | `(+20/-0)[1M]` | ae8b36515c427a271790bd5e228d9c95194f853c `pci-mvebu.c` | `Russell King` _implement slot capabilities (SSPL)_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+1108/-0)[2M, 1A]` | d2c1634d1266fc95cd572ebd9fc9dc9b6f084421 `mv88e6xxx_debugfs.c`, `chip.c`, `chip.h` | `Vivien Didelot` _net: dsa: mv88e6xxx: add debugfs interface_ |
| ✅  | `12-net-dsa-mv88e6xxx` | `(+4/-1)[1M]` | 4ba64ba8374c39c6142d7c836969b6d316860fc1 `mv88e6xxx_debugfs.c` | `Russell King` _net: dsa: mv88e6xxx: debugfs hacks to fix the compile_ |
| ✅  | `12-net-dsa-mv88e6xxx` | `(+3/-0)[1M]` | da696745646b586a4aad6f2a0655ed81a68ac066 `port.h` | `Russell King` _Revert "net: dsa: mv88e6xxx: remove LED control register"_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+20/-0)[1M]` | 0b0e7d406d42688cc0e7571f4a5f2145c09b71b9 `chip.c` | `Russell King` _net: dsa: program 6176 LED registers_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+12/-0)[1M]` | 0e6a3afc032015a6b08c5e8d5e301c84b2c7c43c `chip.c` | `Russell King` _net: dsa/mv88e6xxx: add support for rate-matching PHYs_ |
| ⚠️`[needs_rebase]`  | `20-pcie-bridge-emul` | `(+10/-5)[1M]` | 4664faad9791c229fa894d0e3a5d14413443e62b `pci-bridge-emul.c` | `Russell King` _PCI: pci-bridge-emul: re-arrange register tests_ |
| ✅  | `412-ARM-dts-armada388-clearfog-emmc-on-clearfog-base` | `(+63/-0)[1M, 1A]` | a3153b286facf1d65f7bd0859f6b5aa01ee59ba0 `armada-38x-solidrun-microsom-emmc.dtsi`, `armada-388-clearfog-base.dts` | `Russell King` _ARM: dts: armada388-clearfog: emmc on clearfog base_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `92-mvebu-gpio-add_wake_on_gpio_support` | `(+35/-2)[1M]` | 4ccf648cf7688d5ff3f53e87bb718deab47c3050 `gpio-mvebu.c` | `Aditya Prayoga` _[ARCHEOLOGY] kernel: mvebu-next: Add Wake on GPIO support_ |
| ⚠️`[needs_rebase]`  | `92-mvebu-gpio-remove-hardcoded-timer-assignment` | `(+154/-83)[1M]` | e3f7d556e5ad2d4b612753818183f4b6e3000b42 `gpio-mvebu.c` | `Heisath` _Removes the hardcoded timer assignment of timers to pwm controllers_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `94-helios4-dts-add-wake-on-lan-support` | `(+12/-0)[1M]` | f9efbb5923d7e5c0baecd391d4cd1d35f56ff139 `armada-388-helios4.dts` | `Aditya Prayoga` _[ARCHEOLOGY] mvebu-next: helios4: Add Wake on LAN support_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `compile-dtb-with-symbol-support` | `(+3/-0)[1M]` | b3386dc06fcf5a640b79ee397317f6372342d83d `Makefile.lib` | `Aditya Prayoga` _[ARCHEOLOGY] Added overlay support_ |
| ⚠️`[not_mbox]`  | `dts-disable-spi-flash-on-a388-microsom` | `(+1/-0)[1M]` | 22e561b9749148a44a4934d23bee40ae2ddd6986 `armada-38x-solidrun-microsom.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Move mvebu DEFAULT, NEXT and DEV branch to next kernel (LTS) and U-boot #1426 (#1487)_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `general-increasing_DMA_block_memory_allocation_to_2048` | `(+1/-1)[1M]` | 0ea176259f78e0689bd9649bef1af3f1b052f471 `dma-mapping.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ⚠️`[not_mbox]`  | `unlock_atheros_regulatory_restrictions` | `(+9/-16)[1M]` | d1468d99dd2b35903a33cccb38926562cffe5034 `regd.c` | `Igor Pecovnik` _[ARCHEOLOGY] A set of patches enables consumer grade Atheros wireless card 5Ghz AP mode + working hostapd example_ |
| ✅  | `use-1000BaseX-clearfog-switch` | `(+2/-8)[1M]` | 482a613e4f1c91f1bbe3b36eb4f40f5216a4901c `armada-388-clearfog.dts` | `Russell King` _ARM: dts: armada388-clearfog: use 1000BaseX mode for 88e6176 switch_ |


