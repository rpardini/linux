# U-Boot v2026.07 → v2026.10 (64-bit only)

Range: `v2026.07..v2026.10`, ~1480 commits. Devicetrees resynced to Linux v7.1 (`dts/upstream`).

## 1. Rockchip

### New boards
- **RK3568**: 9Tripod X3568 v4 ([`b5deaa71fbe`](https://github.com/u-boot/u-boot/commit/b5deaa71fbe))
- **RK3568**: LinkEase EasePi R1 router ([`3a8b3cdd83a`](https://github.com/u-boot/u-boot/commit/3a8b3cdd83a), `easepi-r1-rk3568_defconfig`)
- **RK3568**: Anbernic RG-DS dual-screen handheld ([`1998fe69f7e`](https://github.com/u-boot/u-boot/commit/1998fe69f7e), `anbernic-rg-ds-rk3568_defconfig`; Kconfig target guard fixed in [`508732ba45b`](https://github.com/u-boot/u-boot/commit/508732ba45b))
- **RK3588S**: Firefly ROC-RK3588S-PC ([`15387d5a90a`](https://github.com/u-boot/u-boot/commit/15387d5a90a), `roc-pc-rk3588s_defconfig`)

### Fixes / enhancements
- rk3576: `force_jtag` disabled by default ([`c8cac405f29`](https://github.com/u-boot/u-boot/commit/c8cac405f29))
- rk3568 Jaguar: M.2 NVMe PERST# driven low in `spl_board_init` ([`6037673a10f`](https://github.com/u-boot/u-boot/commit/6037673a10f))
- rk3568 NanoPi R5: drop duplicated sdhci node ([`f079d8059da`](https://github.com/u-boot/u-boot/commit/f079d8059da))
- sdram: fix DRAM bank initialization ([`5602e89a834`](https://github.com/u-boot/u-boot/commit/5602e89a834))
- OTP nodes aligned with Linux v7.1 for RK3528/RK356x ([`d4140de41eb`](https://github.com/u-boot/u-boot/commit/d4140de41eb))
- Pinctrl: `RK_GPIOn`/`RK_FUNC_n` defines replaced ([`2f783e53754`](https://github.com/u-boot/u-boot/commit/2f783e53754), [`e504d9cffba`](https://github.com/u-boot/u-boot/commit/e504d9cffba))
- GPT capsule-update helpers built only with `PARTITION_TYPE_GUID` ([`3bc0f812735`](https://github.com/u-boot/u-boot/commit/3bc0f812735))
- fastboot: fix RK3328 buffer-address default ([`1dac5d806ba`](https://github.com/u-boot/u-boot/commit/1dac5d806ba))
- rockusb: terminate full-speed descriptors ([`8caa41dc679`](https://github.com/u-boot/u-boot/commit/8caa41dc679))
- mtd rockchip_nfc: fix ECC setup ([`d97d3df79e7`](https://github.com/u-boot/u-boot/commit/d97d3df79e7))
- Clang `asm-operand-widths` warning fixed ([`07ab38e11f5`](https://github.com/u-boot/u-boot/commit/07ab38e11f5))
- Related: dwc3 `xhci_deregister()` before reset ([`d8f9c5595a8`](https://github.com/u-boot/u-boot/commit/d8f9c5595a8)); dwc3-generic ref-clock lookup/error fixes ([`84de44e5e71`](https://github.com/u-boot/u-boot/commit/84de44e5e71), [`369d71b895b`](https://github.com/u-boot/u-boot/commit/369d71b895b)), which affect RK3399/RK3568/RK3588 USB3

## 2. Amlogic (Meson)

No new boards or SoC support this cycle; housekeeping only.
- Power domain drivers (`meson-gx-pwrc`, `meson-ee-pwrc`, `meson-secure-pwrc`) and `reset-meson`: ops made static/const
- `meson-gx-pwrc-vpu`, `meson-ee-pwrc`: use `dev_read_phandle_with_args()` for sysctrl phandles ([`788259b6c96`](https://github.com/u-boot/u-boot/commit/788259b6c96), [`8e873d7ad3e`](https://github.com/u-boot/u-boot/commit/8e873d7ad3e))
- DT sync (v7.1): small `meson-axg.dtsi` and `meson-gxl-s905d-p230.dts` changes
- Docs: Beelink GT1 Ultimate, JetHub J80/J100 updates
- Indirect: dwc3-generic fixes (above) affect Amlogic USB

## 3. General (boot / EFI / net / FIT)

### Boot flow
- **bootdev**: scan continues at each lower priority level when a higher-priority hunt fails, e.g. failing NVMe no longer blocks USB ([`264ba13f147`](https://github.com/u-boot/u-boot/commit/264ba13f147))
- **bootm**: `IH_TYPE_KERNEL_NOLOAD` improvements: entry point optional, load-address warning for FIT, cache flush fix, larger decompression headroom (4x → 8x), overflow fix
- **bootmenu**: quit logic fix ([`1cc0442ede5`](https://github.com/u-boot/u-boot/commit/1cc0442ede5))
- **bootretry**: only reinit `retry_time` when env var touched ([`4cb0bd4702a`](https://github.com/u-boot/u-boot/commit/4cb0bd4702a))
- **fastboot**: new keyed-abort option, any key aborts ([`b6de000aead`](https://github.com/u-boot/u-boot/commit/b6de000aead))
- Android boot: bounds/leak fixes in boot image, bootconfig, AVB paths

### FIT / verification
- dm-verity: FIT can generate DM verity cmdline params ([`cafe3d6e90e`](https://github.com/u-boot/u-boot/commit/cafe3d6e90e)); roothash covered by config signature ([`2601d94691c`](https://github.com/u-boot/u-boot/commit/2601d94691c))
- `default` config read from the `configurations` node ([`646be6d5cd3`](https://github.com/u-boot/u-boot/commit/646be6d5cd3)); default config preferred on best-match ties ([`574b1adad70`](https://github.com/u-boot/u-boot/commit/574b1adad70))
- `CONTROL_DTB_AS_FIT` knob ([`7779540f093`](https://github.com/u-boot/u-boot/commit/7779540f093)); FIT verification fixed in SPL ([`e50ee1acd4a`](https://github.com/u-boot/u-boot/commit/e50ee1acd4a))
- Many FIT/FDT bounds-check hardening fixes (external data offset/size, recursion depth, hashed-strings)

### EFI
- Secure Boot variables measured into correct PCR when DeployedMode set; GetEventLog return fix without TPM; DTB measurement size fix
- Frame buffer address fix ([`0786aea4659`](https://github.com/u-boot/u-boot/commit/0786aea4659))
- `efi mem` and `efidebug memmap` output unified; ISA-specific memory attributes printed
- Fixes: variable enumeration uninitialized GUID, sigstore parse leak/overrun, `efi_disconnect_controller` EFI_EXIT, `EFI_VARIABLES_PRESEED` build, `efi_http_instance` free
- efi_selftest: block IO revision/pointers test

### Network
- **lwIP**: new `tftpsrv` command ([`0601d2d9a29`](https://github.com/u-boot/u-boot/commit/0601d2d9a29)); HTTP client abort, cancelable DNS callbacks, wget abort returns `ERR_ABRT`, DHCP can stop without releasing lease, DHCP fine-timer fix, chained pbuf TX handling, sntp/wget leak fixes
- Hardening: NFS read/readlink bounds, IPv6 payload length validation, DHCPv6 DUID bounds, IP fragment reassembly OOB write fix
- `srand_mac()` crash fix with `DM_RNG`

### Misc
- `bi_dram[]` moved from `bd` to `gd` (treewide; [`1174c99ab42`](https://github.com/u-boot/u-boot/commit/1174c99ab42)), may affect out-of-tree board code
- `cmd: ufetch` fixes; `fw_env` NVMEM layout detection and lockfile permission fix
- Treewide Kconfig restyle; `tristate` → `bool` for U-Boot options
