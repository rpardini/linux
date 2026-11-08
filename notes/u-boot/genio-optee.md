# Radxa NIO-12L (Genio 1200 / MT8395): OP-TEE actually running

Work of 2026-11-08. Armbian built OP-TEE and packed it into the FIP, but OP-TEE never ran. It now runs and Linux uses it.
Related: `genio-mainline-work.md` (mainline u-boot), boot logs in `genio-mainline/`.

## Symptom (`genio-mainline/000.10th.boot.txt`)

- BL2 loads image id 3 (BL31) and 5 (BL33), never 4 (BL32).
- BL31: `WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK` and `ERROR: Error initializing runtime service opteed_fast`.
- Linux: `optee: api uid mismatch`, then `optee firmware:optee: probe with driver optee failed with error -22`.
- It affects vendor and mainline u-boot alike: the problem is on the TF-A side, and the NIO-12L is the only genio board in Armbian.

## Root cause

- The FIP was fine. `fiptool info fip.bin` lists `Secure Payload BL32 (Trusted OS) … --tos-fw`.
- Addresses agree:
  - TF-A `BL32_BASE` 0x43200000, `BL32_LIMIT` 0xa00000
  - OP-TEE `CFG_TZDRAM_START` 0x43200000, TZDRAM 10 MiB + SHMEM 2 MiB
  - Linux DT `optee@43200000` reserves 12 MiB (`no-map`)
- Vendor TF-A (`gitlab.com/mediatek/aiot/bsp/trusted-firmware-a`, commit `decacb88cfe8`): `plat/mediatek/mt8195/bl2_plat_setup.c` (and `common/mtk_bl2_common.c`) add the BL32 load entry and the BL31→BL32 handoff only under **C** `#ifdef NEED_BL32`.
- `NEED_BL32=yes` on the make command line is only a **make** variable: it adds BL32 to the FIP. No `add_define` turns it into `-DNEED_BL32` for mt8195, so BL2 compiled the entry out.
- Command-line `CFLAGS` reach every TF-A compile (`make_helpers/build_macros.mk:307`); `KCFLAGS` is not used by TF-A.

## Fix (armbian-build branch `extensions`, not pushed)

| Commit | Change |
|---|---|
| `0bc8600fa` genio: load OP-TEE: pass -DNEED_BL32 to TF-A | `config/sources/families/genio.conf`, `mediatek_genio_build_atf`: `-DNEED_BL32` in the `CFLAGS=` of `common_tfa_args`. This was the user's choice over a TF-A patch. It is not in `mediatek_vendor_cflags_modern_gcc`, which exists only for gcc ≥ 13. |
| `8aedea542` radxa-nio-12l: OP-TEE DRAM size 16 GiB | `MEDIATEK_GENIO_OPTEE_DRAM_SIZE="0x400000000"` in the board file. OP-TEE `plat-mediatek/main.c` does `register_ddr(CFG_DRAM_BASE, CFG_DRAM_SIZE)`: the non-secure DDR it accepts for dynamic shared memory. The genio default of 8 GiB would reject Linux buffers above 0x240000000 on 16 GiB boards. A larger value is harmless on 4/8 GiB boards (`CFG_CORE_ARM64_PA_BITS=36`, `paddr_size_t` is 64-bit). |
| `dba61dd44` radxa-nio-12l: u-boot: enable TEE/OP-TEE | Mainline u-boot extra-configs hook: `CONFIG_TEE`, `CONFIG_OPTEE`, `CONFIG_CMD_OPTEE`. The DT already has `firmware/optee` (`linaro,optee-tz`, smc). |

Build check: BL2's `bl2_mem_params_descs` now has the BL32 entry (image base `0x431fffe4`, pc `0x43200000`). OP-TEE's `out/arm-plat-mediatek/conf.mk` has `CFG_DRAM_SIZE=0x400000000`.
Deb: `linux-u-boot-radxa-nio-12l-edge_…2027.01-rc1-Sdfcf-Pd8b4-H8c4e-…deb`. It was flashed with `cat fip.img > /dev/sda` + `cmp` (OK).

## Verified on the board (`genio-mainline/000.11th.boot.optee.txt`)

- BL2: `Loading image id=4 at address 0x431fffe4`, `Image id=4 loaded: 0x431fffe4 - 0x4325f790`.
- BL31: `Initializing BL32`. OP-TEE banner `OP-TEE version: ab5d0acf (gcc 14.2.0) … aarch64` (3.19 based) with the usual "configuration might be insecure" warning. All 8 CPUs initialize. No "No OPTEE" warning.
- u-boot `dm tree`: `tee 0 [ + ] optee`. The `optee` self-test command was not run.
- Linux:
  - `optee: revision 3.19 (00000000ab5d0acf)`, `optee: dynamic shared memory is enabled`, `optee: initialized driver`
  - `/dev/tee0` and `/dev/teepriv0` exist
- The reflashed image was a CAPT-k8s one; PXE first in `boot_targets` is expected there.

## Security properties (what OP-TEE is worth here)

- HUK (per-chip secret): OP-TEE asks TF-A via SiP `MTK_SIP_GET_HUK` (0x82000010). TF-A derives it with `sec_hacc_derive()` (hardware crypto engine, `PLAT_HW_CRYPTO=1`), because `HUK_EFUSE_HWID` is not set. Linux never sees it. Data sealed with it only unseals on this chip.
- Limits:
  - **No secure boot**: root can flash a modified `fip.img` and get the keys. This protects against disk cloning or theft, not against root on the running node.
  - **No RPMB**: `CFG_REE_FS=y`, `CFG_RPMB_FS` off. Secure storage is encrypted files on the normal filesystem, and rollback is possible.
  - **No hardware RNG**: `CFG_WITH_SOFTWARE_PRNG=y`, `CFG_HWRNG_PTA=n`.
- TAs built in our OP-TEE: `avb`, `pkcs11`, `trusted_keys`.
- Use cases, in order of effort:
  1. PKCS#11 TA: needs `tee-supplicant` + Debian `libckteec0`, nothing to build. SSH host keys or kubelet/node TLS keys that can't be extracted.
  2. Kernel trusted keys (`trusted.source=tee`): disk encryption keys sealed to the chip. Needs `CONFIG_TRUSTED_KEYS` and the TEE in the initramfs.
  3. fTPM (ms-tpm TA, plus u-boot/kernel options): TPM2 for `systemd-cryptenroll`, measured boot, attestation. Weak without secure boot and RPMB.
  4. Vendor-only: secure video path / DRM (not on mainline).
- Decision 2026-11-08: leave OP-TEE running, and don't build xtest until a real use case is chosen. dmesg already proves the TEE works.

## RNG for u-boot wget HTTPS: still blocked

- u-boot `RNG_OPTEE` needs OP-TEE's HWRNG PTA.
- Vendor OP-TEE enables `CFG_HWRNG_PTA` + `CFG_ARM_SMCCC_TRNG` only for MT8188.
- Vendor and upstream TF-A have a TRNG driver only for MT8186/MT8188:
  - vendor: `plat/mediatek/mt8188/drivers/rng/trngv2.c`, `TRNG_SUPPORT := 1`, `TRNG_BASE` = `IO_PHYS + 0x20f000`
  - upstream: `plat/mediatek/drivers/rng/{mt8186,mt8188}`
- MT8195 devapc has the same `TRNG_APB_S` slot between the same neighbours (`INFRACFG_PDN_APB_S`, `GCPU_APB_S`) as MT8188. So it is probably the same IP at the same address, but unverified.
- Porting means a TF-A patch (TRNG for mt8195) plus OP-TEE flags for mt8195, then u-boot `DM_RNG` + `RNG_OPTEE`. Not started.

## If testing later: tee-supplicant and xtest

- `apt install tee-supplicant` (trixie 4.5.0, which works with a 3.19 core); run it as a service or `tee-supplicant -d`. TAs load from `/lib/optee_armtz/`.
- Do not use Debian `optee-test-qemu`: it targets OP-TEE 4.x TAs.
- Build `optee_client` and `optee_test` at tag `3.19.0` natively on the build host:
  - `TA_DEV_KIT_DIR=…/cache/sources/mediatek-optee/optee-os/out/arm-plat-mediatek/export-ta_arm64`
  - `OPTEE_CLIENT_EXPORT=…/optee_client/out/export/usr`
  - `CROSS_COMPILE_HOST= CROSS_COMPILE_TA=`
  - TAs are signed with `keys/default_ta.pem`
- Copy `xtest` to `/usr/bin`, `*.ta` to `/lib/optee_armtz/`, plugins to `/usr/lib/tee-supplicant/plugins/`.
- Run `xtest -l 0`, then the full suite. For SHM above 8 GiB: `stress-ng --vm 1 --vm-bytes 12G --vm-keep` in the background while running `xtest -t regression 1000 4000 7000`.

## Open items

- `optee` self-test in u-boot; xtest only if a use case is chosen.
- Push armbian-build `extensions` (only when asked).
- Possible upstream/vendor report: the TF-A mt8195 platform should `add_define NEED_BL32`.
- RNG port (see above), if wget HTTPS or a better RNG matters.
- u-boot `scriptaddr`/`pxefile_addr_r` = 0x43000000 is just below the OP-TEE region (0x43200000). That is fine for files < 2 MiB, but keep it in mind.
