# Radxa NIO-12L (Genio 1200 / MT8395): mainline u-boot in Armbian

Work of 2026-11-07/08. Mainline u-boot (v2027.01-rc1) now replaces the vendor u-boot (MediaTek aiot 2022.10) as BL33 on the NIO-12L.
It is the default for `BRANCH=edge`. Vendor TF-A, OP-TEE, libdram/libbase and the FIP packaging are unchanged.

## Status (10th boot, warm reboot, all OK)

| Feature | State | Notes |
|---|---|---|
| Boot to Linux (UFS) | OK | bootstd runs Armbian's unchanged `boot-genio.cmd` |
| RAM size autodetect | OK | 16 GiB from the TF-A/libdram boot argument; kernel DT memory node fixed up |
| UFS, SD | OK | SD runs at HS 50 MHz (no MT6360 driver, so no UHS 1.8 V) |
| Env | OK | UFS LUN1 (`scsi 1:0`) offset 0x0, same spot as Collabora/vendor builds; `fw_env.config` follows |
| Ethernet | OK | DHCP, ping, wget (HTTP) with lwIP; MAC passed to Linux |
| `serial#` / `ethaddr` | OK | from the UFS serial; stable MAC `12:f3:ae:d1:ac:1e` |
| USB-C gadget (UMS) | OK | `ums 0 scsi 2` (UFS, 4 KiB sectors), `ums 0 usb 0` |
| USB-A ports | OK | VIA VL805 xHCI behind PCIe (`pcie0`); cold and warm boot |
| LEDs, preboot blink | built | `blue:heartbeat`, `red:panic`; not explicitly checked |
| OP-TEE 3.19 | OK (11th boot) | BL2 loads BL32; Linux `optee: revision 3.19`, `/dev/tee0`; u-boot optee driver probes. Details: `genio-optee.md` |
| On-board u-boot update (`write_uboot_platform`) | built, **untested** | all updates so far used `cat fip.img > /dev/sda` |

## Repos and branches

- `armbian-build`, branch `extensions`: 27 commits on top of `93209f021` (last 3: OP-TEE), reworked history.
  - **Not pushed yet**: it is 24 ahead / 21 behind `armbian-armsurvivors/extensions`, so it needs `git push --force-with-lease armbian-armsurvivors extensions`.
  - Backups: `extensions-backup-pre-rework` (before restructuring), `extensions-backup-pre-bodies` (before the patch-summary messages).
- `u-boot-genio-mainline`, branch `armbian/genio-nio12l`: off `v2027.01-rc1`, 22 commits; the source of the patches.
  - Backup: `armbian/genio-nio12l-backup-pre-trailers`.
  - `ARMBIAN:` commits (DT/dtsi) and `configs: radxa nio-12l` commits are shipped as overlay files, not patches.
- `u-boot-genio-vendor`: reference only (vendor 2022.10 + Armbian patches).
- Commit trailer everywhere: `Assisted-by: Claude Opus 5.5` (never `Co-Authored-By`).

## Armbian layout

- `config/sources/families/genio.conf`:
  - `GENIO_MAINLINE_UBOOT=yes` switches `BOOTSOURCE` (`MAINLINE_UBOOT_SOURCE`), `BOOTBRANCH=tag:v2027.01-rc1`, `BOOTPATCHDIR=v2027.01`, `BOOTDIR=…-mainline`.
  - `write_uboot_platform` writes `fip.img` to UFS LUN0 on the board. It finds LUN0 through sysfs, checks the `UFS_BOOT` header and size, uses `dd conv=fsync`, then `cmp`. It skips loop devices, so the image build never writes it.
- `config/boards/radxa-nio-12l.conf`:
  - `BRANCH=edge` defaults to mainline; mainline `BOOTCONFIG=mt8395_radxa_nio_12l_defconfig`.
  - The vendor env hook is skipped for mainline.
  - Extra configs hook (mainline only): lwIP, wget, DNS, NFS, MII, EFI debug, regulator cmd, btrfs/LZO/ZSTD, DM_GPIO + LEDs + preboot blink, no fastboot. No wget HTTPS, because there is no RNG.
  - Firmware trim: `armbian-firmware-full` 2.4G → 86M.
- `patch/u-boot/v2027.01/`:
  - root: the 4 common patches (ported from v2026.10; separate submission), `0000.patching_config.yaml`, and the overlays `defconfig/`, `dt_upstream_mediatek/` (Armbian kernel DT: v7.3 + genio-7.3 patches 3000-3003) and `dt_uboot/` (`mt8395-radxa-nio-12l-u-boot.dtsi`). Overlays only work from the root, not from `board_*`.
  - `board_radxa-nio-12l/`: 14 patches `0010`…`0140`, one armbian commit each. Patches sort globally by filename across root and board dirs.

## u-boot patches (`board_radxa-nio-12l/`)

| # | Patch | Why |
|---|---|---|
| 0010 | mt8195: DRAM size from TF-A boot argument | 4/8/16 GiB variants; mem_map follows |
| 0020 | generic `board/mediatek/mt8195` + default env | load addrs, boot_targets, `fdtfile` from defconfig |
| 0030 | tools: mtk_image UFS support | `bl2.img` with `media=ufs` (byte-identical to vendor) |
| 0040 | mtk-pwrap: match any PMIC compatible | `mt6365, mt6359` → PMIC/regulators work |
| 0050 | clk: mt8195 pericfg_ao gates | Ethernet, ETHER domain, PCIe, USB clocks |
| 0060 | power: MT8195 power domain driver | 35 domains, generated from Linux |
| 0070 | configs: mt8195 enable power domains | |
| 0080 | dwc_eth_qos_mtk: mt8195 | pericfg base 0xfd0 |
| 0090 | ufs: `ufs_get_serial()` | board identity |
| 0100 | mt8195: serial# + stable MAC from UFS serial | sha256, locally administered |
| 0110 | pci gen3: clk bulk | MT8195 has 6 clocks in another order |
| 0120 | phy: minimal MT8195 PCIe PHY | powers `PCIE_PHY` domain; no efuse calibration |
| 0130 | mt8195: map PCIe windows as MMIO | `MTK_MEM_MAP_MMIO_SIZE=0x40000000`; else abort on BAR access |
| 0140 | mt8195: undo Linux PCIe IOMMU routing | clear `PERICFG_IOMMU_1` (0x11003714) bits 16-19; else xHCI timeouts after warm reboot |

u-boot dtsi (`dt_uboot/`) disables `mmc0` (no eMMC; shares `vemc_1`/`vufs` with UFS, so probing it killed UFS). It also makes `ssusb0` a peripheral with forced VBUS, and disables `ssusb2` (no ports) and `pcie1` (Wi-Fi only).

## Board facts learned (the hard way)

- UFS LUNs: LUN0 = 4 MiB boot LU (`fip.img` at offset 0, Linux `/dev/sda`), LUN1 = 4 MiB (env), LUN2 = rootfs (`/dev/sdc`).
- No eMMC, but the DT enables `mmc0`; its supplies are UFS's.
- USB-A ports: VIA VL805/806 (`1106:3483`) on `pcie0` x1, not on any MT8195 USB controller. `ssusb2` has no ports. The vendor u-boot never supported USB-A (no PCI at all).
- USB-C (`ssusb0`) with role switch; the TCPC and SD supplies are on the MT6360 (no u-boot driver; BL2 powers the LDOs).
- Linux leaves `PERICFG_IOMMU_1` PCIe bits set across a warm reboot.
- BL2 did not load OP-TEE: vendor BL2 needs the C define `NEED_BL32`; the make variable only fills the FIP. Fixed with `-DNEED_BL32` in genio.conf (2026-11-08).
- OP-TEE `CFG_DRAM_SIZE` limits dynamic SHM; set to 16 GiB for the NIO-12L.
- Vendor TF-A: no SMCCC TRNG; there is no MT8195 RNG driver in u-boot, so no TLS (wget HTTPS). Vendor and upstream TF-A have a TRNG only for MT8186/MT8188 (MT8188: `TRNG_BASE` 0x1020f000). MT8195 devapc has the same `TRNG_APB_S` slot, so porting is possible but unverified.

## Build and deploy

```bash
# armbian (no Docker; user config)
cd /opt/linuxdev/armbian-build
PREFER_DOCKER=no ./compile.sh rpardini-generic uboot BOARD=radxa-nio-12l BRANCH=edge   # GENIO_MAINLINE_UBOOT=no for vendor
# image (no k8s):
PREFER_DOCKER=no ./compile.sh rpardini-generic build BOARD=radxa-nio-12l BRANCH=edge RELEASE=trixie \
  BUILD_MINIMAL=no CLOUD_IMAGE=yes BUILD_DESKTOP=no ENABLE_EXTENSIONS="ufs,cloud-metadata"

# deploy to board (ssh root@192.168.66.83)
scp output/debs/linux-u-boot-radxa-nio-12l-edge_*<PHASH>*.deb root@192.168.66.83:/root/
# on board:
dpkg -i /root/linux-u-boot-…deb
F=/usr/lib/linux-u-boot-edge-radxa-nio-12l/fip.img
cat $F > /dev/sda && sync /dev/sda && echo 3 > /proc/sys/vm/drop_caches && cmp -n $(stat -c%s $F) $F /dev/sda

# local u-boot dev build (out of tree)
cd /opt/linuxdev/u-boot-genio-mainline
make O=<scratch>/build-nio mt8395_radxa_nio_12l_defconfig && make O=<scratch>/build-nio -j$(nproc) </dev/null
```

Gotchas:
- After a vendor-mode build, `output/radxa-nio-12l-trixie-fip.img` holds the vendor FIP. A cached mainline build does not re-export it; extract it from the `.deb`.
- Run `make` with `</dev/null` and a fresh defconfig: a stale `.config` makes `make` wait forever on Kconfig prompts.
- The ufs extension image uses 4 KiB sectors: `losetup -b 4096 -P` to mount it.
- Currently on the board: u-boot `Pd8b4-H8c4e` (with OP-TEE).

## Logs (`linuxdev-status/notes/u-boot/genio-mainline/`)

| File | What |
|---|---|
| `000.1st.bootlog.txt`, `1st.boot.more.info.txt`, `1st.boot.actual.boot.txt` | first mainline boot: 16 GiB OK, pwrap "pmic slave not found"; boots Linux from UFS |
| `000.2nd.boot.bootlog.txt`, `2nd.boot.more.info.txt` | after the pwrap fix: UFS dies when probing `mmc0` (shared supplies); SD works with a card |
| `000.3rd.boot.complete.txt` | `mmc0` disabled: clean boot to login |
| `000.4th.with.ether.txt` | Ethernet works (legacy net), serial#/ethaddr; VPPSYS0 message; USB-A missing |
| `5th.boot.more.info.txt` | lwIP: dhcp/ping/wget OK, UMS over USB-C OK, USB-A still missing |
| `000.6th.boot.full.with.linux.lsusb.txt` | regulator status, dm tree, Linux `lsusb -t` showing the VL805 on PCIe |
| `000.7th.boot.usb.start.with.pcie.txt` | PCIe link OK, `usb start` → Synchronous Abort (unmapped PCIe window) |
| `000.8th.boot.txt` | MMIO fixed; xHCI command timeouts (IOMMU bits, warm reboot) |
| `000.9th.boot.txt` | IOMMU bits cleared in u-boot: USB-A OK after a warm reboot; `ums 0 usb 0` |
| `000.10th.boot.txt` | final, reworked history (`Pd8b4`): everything OK, boots to login |
| `000.11th.boot.optee.txt` | OP-TEE runs (BL2 image id 4, OP-TEE banner, Linux optee 3.19, `/dev/tee*`); CAPT-k8s image (PXE first is expected) |

## Open items / next steps

- Test `write_uboot_platform`: `armbian-install` option 5, or `FORCE_UBOOT_UPDATE=yes dpkg -i …`, then `cmp` and reboot.
- Push `armbian-build` `extensions` (force); delete the backup branches when happy.
- `pxe-over-http-v0.patch` still has 4 `Co-Authored-By: Claude Opus 4.8` lines (copied unchanged from v2026.10).
- Check the LEDs/preboot blink, a USB keyboard on USB-A, SD boot priority (SD with an image before UFS), and PXE/HTTP boot.
- Measure the boot time cost of `PCI_INIT_R`.
- OP-TEE: run `optee` in u-boot, tee-supplicant + xtest in Linux, SHM above 8 GiB.

- Cosmetic: VPPSYS0 "failed to get subsys clk" (vppsys0 clock controller missing); the EFI boot manager tries its auto entries first; the `1001` patch prints 34 alias lines on every kernel boot.
- Not done: PCIe PHY efuse calibration; MT6360 driver (SD UHS, USB-C role switch/host); USB-C host role in u-boot; RNG for HTTPS (port MT8188 TRNG to MT8195 TF-A + OP-TEE HWRNG PTA).
- Upstreaming candidates: patches 0010-0140, except the Armbian-specific dts/defconfig/overlays.
- Bump to the final v2027.01 when released (`BOOTBRANCH` + patch dir).
