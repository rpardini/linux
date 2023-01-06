#### kernel patching: 23 total patches; 23 applied; 17 with problems; 9 not_mbox; 13 needs_rebase; 2 invalid_diff

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[/opt/build_armbian/extensions/cache/patch/kernel-drivers/]` `5.15_mvebu_cdd39e74d3031865` | `(+0/-0)[]` | e7ec8de5b85b091aa522804b905a394288d77822 `?` | `Armbian Autopatcher` _[AUTOGEN] /opt/build_armbian/extensions/cache/patch/kernel-drivers/5.15_mvebu_cdd39e74d3031865_ |
| ⚠️`[not_mbox]`  | `0001-cpuidle-mvebu-indicate-failure-to-enter-deeper-sleep` | `(+5/-1)[1M]` | 3ea9ad5f9a230c035f31a49ead0abd9623754688 `cpuidle-mvebu-v7.c` | `Igor Pecovnik` _[ARCHEOLOGY] Patches for Marvell Armada, kernel 4.3 and 4.4_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `09-pci-link-retraining` | `(+79/-6)[3M]` | 9b4b99cf5432f19bdae5d60790f24bcd428b4fb3 `aspm.c`, `quirks.c`, `pci.h` | `Heisath` _[ARCHEOLOGY] Add PCIe Wifi quirks patch for Atheros and Qualcomm cards_ |
| ❌`[invalid_diff]`  ⚠️`[needs_rebase]`  | `10-mvebu-clearfog-pcie-updates` | `(+0/-0)[]` | b1624ed7be9de4faf6ddd2e7cbee157b539057fb `?` | `Russell King` _mvebu/clearfog pcie updates_ |
| ⚠️`[needs_rebase]`  | `11-implement-slot-capabilities-SSPL` | `(+23/-0)[1M]` | 598da0156717530ebbc9768e4da1bf1da6fb0946 `pci-mvebu.c` | `Russell King` _implement slot capabilities (SSPL)_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+1108/-0)[2M, 1A]` | 18a76f2867a40ad24cc0a2e098d05385db15c52d `mv88e6xxx_debugfs.c`, `chip.c`, `chip.h` | `Vivien Didelot` _net: dsa: mv88e6xxx: add debugfs interface_ |
| ✅  | `12-net-dsa-mv88e6xxx` | `(+4/-1)[1M]` | 95db217a581590621d5e81a076163dfc6b67e4bd `mv88e6xxx_debugfs.c` | `Russell King` _net: dsa: mv88e6xxx: debugfs hacks to fix the compile_ |
| ✅  | `12-net-dsa-mv88e6xxx` | `(+3/-0)[1M]` | e8445fc5ecdcf114d365e71ef22416be7a475c8f `port.h` | `Russell King` _Revert "net: dsa: mv88e6xxx: remove LED control register"_ |
| ❌`[invalid_diff]`  ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+0/-0)[]` | 31eb2b49bfe160a8589eae97c9edfa4c8d9b5929 `?` | `Russell King` _net: dsa: program 6176 LED registers_ |
| ⚠️`[needs_rebase]`  | `12-net-dsa-mv88e6xxx` | `(+12/-0)[1M]` | b10eab02f3bf757ab45b4d505ae44e6ad077d6d5 `chip.c` | `Russell King` _net: dsa/mv88e6xxx: add support for rate-matching PHYs_ |
| ⚠️`[needs_rebase]`  | `20-pcie-bridge-emul` | `(+27/-26)[1M]` | 640884e93c9b94d684c8ca016af55e172c590803 `pci-bridge-emul.c` | `Russell King` _PCI: pci-bridge-emul: re-arrange register tests_ |
| ⚠️`[needs_rebase]`  | `20-pcie-bridge-emul` | `(+58/-18)[2M]` | da89a6bfdc5292be58e33e2433222a8502f62455 `pci-bridge-emul.c`, `pci-bridge-emul.h` | `Russell King` _PCI: pci-bridge-emul: add support for PCIe extended capabilities_ |
| ✅  | `412-ARM-dts-armada388-clearfog-emmc-on-clearfog-base` | `(+63/-0)[1M, 1A]` | 773a869e663fd6fba6c6ba0e1a98f157fdce2d73 `armada-38x-solidrun-microsom-emmc.dtsi`, `armada-388-clearfog-base.dts` | `Russell King` _ARM: dts: armada388-clearfog: emmc on clearfog base_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `91-01-libata-add-ledtrig-support` | `(+66/-0)[3M]` | bc1733a9f17808d5816580ba0bdfd1723d35e610 `libata-core.c`, `Kconfig`, `libata.h` | `Gauthier Provost` _[ARCHEOLOGY] Helios4 - Add missing Enable-ATA-port-LED-trigger.patch in mvebu-[default|next]_ |
| ✅  | `91-02-Enable-ATA-port-LED-trigger` | `(+2/-0)[2M]` | ca94886e8d808764471a477ad3d77204f2d65071 `mvebu_v7_defconfig`, `Kconfig` | `aprayoga` _Enable ATA port LED trigger_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `92-mvebu-gpio-add_wake_on_gpio_support` | `(+35/-2)[1M]` | bcb2df3637ff4490ef1ba22915be7a6e244786c0 `gpio-mvebu.c` | `Aditya Prayoga` _[ARCHEOLOGY] kernel: mvebu-next: Add Wake on GPIO support_ |
| ⚠️`[needs_rebase]`  | `92-mvebu-gpio-remove-hardcoded-timer-assignment` | `(+154/-83)[1M]` | 05e1f0dc460e695e9ea7e178ed52870e40f45c0e `gpio-mvebu.c` | `Heisath` _Removes the hardcoded timer assignment of timers to pwm controllers_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `94-helios4-dts-add-wake-on-lan-support` | `(+12/-0)[1M]` | 79d71328a4f384aed10068fa0864237f852eed27 `armada-388-helios4.dts` | `Aditya Prayoga` _[ARCHEOLOGY] mvebu-next: helios4: Add Wake on LAN support_ |
| ⚠️`[not_mbox]`  ⚠️`[needs_rebase]`  | `compile-dtb-with-symbol-support` | `(+3/-0)[1M]` | bfb6c54ce1d988cd5c9f5b7df29e5cc0ec2cd2de `Makefile.lib` | `Aditya Prayoga` _[ARCHEOLOGY] Added overlay support_ |
| ⚠️`[not_mbox]`  | `dts-disable-spi-flash-on-a388-microsom` | `(+1/-0)[1M]` | 3e4cb32377e0cb2ee7305b19dda8aef9865b5e6c `armada-38x-solidrun-microsom.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Move mvebu DEFAULT, NEXT and DEV branch to next kernel (LTS) and U-boot #1426 (#1487)_ |
| ⚠️`[not_mbox]`  | `general-increasing_DMA_block_memory_allocation_to_2048` | `(+1/-1)[1M]` | 6b45ba4b09f706a36a4cceed62ae8bbcbdba97ac `dma-mapping.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ⚠️`[not_mbox]`  | `unlock_atheros_regulatory_restrictions` | `(+9/-16)[1M]` | 2cb62a976627a085e7b0c2539f641438a8285898 `regd.c` | `Igor Pecovnik` _[ARCHEOLOGY] A set of patches enables consumer grade Atheros wireless card 5Ghz AP mode + working hostapd example_ |
| ✅  | `use-1000BaseX-clearfog-switch` | `(+2/-8)[1M]` | 642f08c0cf5e75688699f900051e2286512006a9 `armada-388-clearfog.dts` | `Russell King` _ARM: dts: armada388-clearfog: use 1000BaseX mode for 88e6176 switch_ |


