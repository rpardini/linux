#### kernel patching: 23 total patches; 23 applied; 17 with problems; 9 not_mbox; 13 needs_rebase; 2 invalid_diff

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[/opt/build_armbian/extensions/cache/patch/kernel-drivers/]` `5.15_mvebu_cdd39e74d3031865` | `(+0/-0)[]` | 9283fd90658ff8039fe5e0b8725cd3d8f78c4927 `?` | `Armbian Autopatcher` _[AUTOGEN] /opt/build_armbian/extensions/cache/patch/kernel-drivers/5.15_mvebu_cdd39e74d3031865_ |
| ⚠️`[not_mbox]`  | `0001-cpuidle-mvebu-indicate-failure-to-enter-deeper-sleep` | `(+5/-1)[1M]` | c9cb1677bdc6470b4fc2fa84157fa9e24dc7a7dd `cpuidle-mvebu-v7.c` | `Igor Pecovnik` _[ARCHEOLOGY] Patches for Marvell Armada, kernel 4.3 and 4.4_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `09-pci-link-retraining` | `(+79/-6)[3M]` | 6f64e052f97b3a97952e344d110257ee9a8aca3c `aspm.c`, `quirks.c`, `pci.h` | `Heisath` _[ARCHEOLOGY] Add PCIe Wifi quirks patch for Atheros and Qualcomm cards_ |
| ❌`[invalid_diff]`  ⚠️`[needs_rebase]`  | `10-mvebu-clearfog-pcie-updates` | `(+0/-0)[]` | f1f72bbe5da6d6e97af7112db63677dfce7b171a `?` | `Russell King` _mvebu/clearfog pcie updates_ |
| ⚠️`[needs_rebase]`  | `11-implement-slot-capabilities-SSPL` | `(+23/-0)[1M]` | 6d6441c3deb558af2a4f8b5cc6ce04dcfcf01070 `pci-mvebu.c` | `Russell King` _implement slot capabilities (SSPL)_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+1108/-0)[2M, 1A]` | 04168107fd4f840f3b555e94de434a436c76aa92 `mv88e6xxx_debugfs.c`, `chip.c`, `chip.h` | `Vivien Didelot` _net: dsa: mv88e6xxx: add debugfs interface_ |
| ✅  | `12-net-dsa-mv88e6xxx` | `(+4/-1)[1M]` | dcddf500f2189073968f3eb1fae07df2cc7a7821 `mv88e6xxx_debugfs.c` | `Russell King` _net: dsa: mv88e6xxx: debugfs hacks to fix the compile_ |
| ✅  | `12-net-dsa-mv88e6xxx` | `(+3/-0)[1M]` | 172a5e6dd3f999074fe4b0aef7de4a1f9241ad5a `port.h` | `Russell King` _Revert "net: dsa: mv88e6xxx: remove LED control register"_ |
| ❌`[invalid_diff]`  ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+0/-0)[]` | b0d7313b0acac246a95866e6d04926a819be2b27 `?` | `Russell King` _net: dsa: program 6176 LED registers_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+12/-0)[1M]` | 97c7f2d65fb858dd758f6c52036c3ade66c460c1 `chip.c` | `Russell King` _net: dsa/mv88e6xxx: add support for rate-matching PHYs_ |
| ⚠️`[needs_rebase]`  | `20-pcie-bridge-emul` | `(+27/-26)[1M]` | da1afefae5aaed7c563a06f928b51bd85f1d4375 `pci-bridge-emul.c` | `Russell King` _PCI: pci-bridge-emul: re-arrange register tests_ |
| ⚠️`[needs_rebase]`  | `20-pcie-bridge-emul` | `(+58/-18)[2M]` | 79f674195accb6adcdae4ccef88d0c224bf26598 `pci-bridge-emul.c`, `pci-bridge-emul.h` | `Russell King` _PCI: pci-bridge-emul: add support for PCIe extended capabilities_ |
| ✅  | `412-ARM-dts-armada388-clearfog-emmc-on-clearfog-base` | `(+63/-0)[1M, 1A]` | 005e1a31c116b835ffe1e1fb34038b783ed1ea67 `armada-38x-solidrun-microsom-emmc.dtsi`, `armada-388-clearfog-base.dts` | `Russell King` _ARM: dts: armada388-clearfog: emmc on clearfog base_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `91-01-libata-add-ledtrig-support` | `(+66/-0)[3M]` | 36b18a8a5083d711e3a7ff78ce306033160b6daf `libata-core.c`, `Kconfig`, `libata.h` | `Gauthier Provost` _[ARCHEOLOGY] Helios4 - Add missing Enable-ATA-port-LED-trigger.patch in mvebu-[default|next]_ |
| ✅  | `91-02-Enable-ATA-port-LED-trigger` | `(+2/-0)[2M]` | e7c189b3bdfe99d2f219764b69498bade2fc76b2 `mvebu_v7_defconfig`, `Kconfig` | `aprayoga` _Enable ATA port LED trigger_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `92-mvebu-gpio-add_wake_on_gpio_support` | `(+35/-2)[1M]` | a83875d1e0012e2ce3cbe468b89aad378180522d `gpio-mvebu.c` | `Aditya Prayoga` _[ARCHEOLOGY] kernel: mvebu-next: Add Wake on GPIO support_ |
| ⚠️`[needs_rebase]`  | `92-mvebu-gpio-remove-hardcoded-timer-assignment` | `(+154/-83)[1M]` | ab98697948c8225f1189c3f709e202e62174f3b4 `gpio-mvebu.c` | `Heisath` _Removes the hardcoded timer assignment of timers to pwm controllers_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `94-helios4-dts-add-wake-on-lan-support` | `(+12/-0)[1M]` | b05ee23d53ff33ec534ecf8ad961281dc310958d `armada-388-helios4.dts` | `Aditya Prayoga` _[ARCHEOLOGY] mvebu-next: helios4: Add Wake on LAN support_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `compile-dtb-with-symbol-support` | `(+3/-0)[1M]` | 19b0885e4e78b5b59c267e6a5d87897498c8885d `Makefile.lib` | `Aditya Prayoga` _[ARCHEOLOGY] Added overlay support_ |
| ⚠️`[not_mbox]`  | `dts-disable-spi-flash-on-a388-microsom` | `(+1/-0)[1M]` | cdfff057dea2621cf4fb298273bbfdf7bd4f112f `armada-38x-solidrun-microsom.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Move mvebu DEFAULT, NEXT and DEV branch to next kernel (LTS) and U-boot #1426 (#1487)_ |
| ⚠️`[not_mbox]`  | `general-increasing_DMA_block_memory_allocation_to_2048` | `(+1/-1)[1M]` | 01ab7c28141dc72d5323951d4e38c0bdebfafc20 `dma-mapping.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ⚠️`[not_mbox]`  | `unlock_atheros_regulatory_restrictions` | `(+9/-16)[1M]` | adbb216eefbfc2bf1c6583ad655b07568d679e97 `regd.c` | `Igor Pecovnik` _[ARCHEOLOGY] A set of patches enables consumer grade Atheros wireless card 5Ghz AP mode + working hostapd example_ |
| ✅  | `use-1000BaseX-clearfog-switch` | `(+2/-8)[1M]` | 2b3a8396e13b6ff1e29ff107fd44c15128df646f `armada-388-clearfog.dts` | `Russell King` _ARM: dts: armada388-clearfog: use 1000BaseX mode for 88e6176 switch_ |


