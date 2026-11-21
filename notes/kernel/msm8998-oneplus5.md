# K33: OnePlus 5 (cheeseburger, MSM8998) on mainline, for Armbian

- Branch `mainline/msm8998-oneplus5`, base `v7.4-rc3`, worktree `~/linuxdev/kernel-msm8998` (build dir `.build`).
- Goal: Armbian `msm8998` family (`edge` = `tag:v7.4-rc3`), board `oneplus-cheeseburger.wip`, patches in
  `armbian-build/patch/kernel/archive/msm8998-7.4/`. Headless first, then panel/GPU/etc. as far as they work.
- Plan: `~/.claude/plans/armbian-build-years-ago-i-peaceful-meadow-of-fd2dd403-2039-4c84-9836-d3ac202dd5a7.md`.
- 2023 attempt (dead at v6.1.1): `armbian-build/userpatches/` (`oneplus5.wip`, `msm8998.conf`, `fastboot_image.sh`,
  `initramfs_usb_gadget/`, `kernel/msm8998-edge/`, `oneplus5.README.md`), kernel branch
  `kernel-rpardini-linux/armbian-next-msm8998-6.1-20231025`.

## Sources (remotes, all fetch=n in remotes.tsv)

| Remote / series | What we take |
|---|---|
| `kernel-msm8998-mainline` `qcom-msm8998-6.1.y` | the OnePlus 5 stack (Jami Kettunen et al.); forward-port source |
| `kernel-msm8998-mainline` `qcom-msm8998-6.18.y` | Nubia-only, nothing for OnePlus |
| `kernel-sdm660-mainline` `qcom-sdm660-7.2.y` | 7.2-rebased SMMU (TTBR1 skip, mss identity), WLED irq fix, DSI reset, Yassine's `pmi8998_fg` + fixes |
| `kernel-somainline` `topic/cpr3hh` (2024-07) | CPR3+ (= Konrad's v15 `20240708-topic-cpr3h-v15`) + qcom-hw CPRh/OSM + msm8998 SAW/cpufreq DT |
| lore `20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com` | Dmitry's icc-rpm based MSM8998 interconnect (8 patches), replaces the 2020 driver |

Research mboxes: `lore/research/msm8998-cpr3/`.

## Triage of the 6.1 stack

- Already upstream: SMB2 charger (now `qcom_smbx`), RRADC, RMI4 F1A, AW9523 binding, sagit DT, cpufreq-dt blocklist,
  `qcom,freq-domain` binding, mmcc enabled by default.
- Dropped:
  - pm8998 VADC channels (buggy: both REF_GND)
  - a5xx "TTBR1 extravaganza" (sdm660 runs a5xx with the TTBR1 skip only)
  - a540 MODULE_FIRMWARE (msm has none upstream; Armbian initramfs hook adds fw)
  - ath10k fake-MSA hack → DT `qcom,no-msa-ready-indicator` on the OP5 wifi node
  - WIP reserved-mem renames, defconfigs, -O3/A73/initcall tweaks, Nubia/Fxtec/Sony DTs
- Deferred:
  - SMMU bypass/secure context banks (2-5, LPASS IOMMU = audio)
  - SPMI haptics: upstream `qcom,spmi-haptics.yaml` is now PMIH0108; ours would need renaming
  - audio (wcd9335/lpass/TFA9890; was disabled on OP5 in 2023 anyway)
- Ported by hand:
  - gcc critical flags (MISC part upstream)
  - panels → `devm_drm_panel_alloc()` / `drm_of_get_panel_orientation()`
  - DT dsi labels → `mdss_dsi0*`, pinctrl `-state` names
  - simple-battery moved out of reserved-memory
  - fg node `battery@4000`
  - CPR common move onto upstream `drivers/pmdomain/qcom/cpr.c`
  - qcom-cpufreq-hw: 3-way replay of upstream 6.10→7.4 delta onto the CPRh version (+ Shikra LUT mask)
  - `devm_pm_opp_attach_genpd` → `devm_pm_domain_attach_list()`

## Build state (2026-11-21)

- 62 commits. `make O=.build Image modules dtbs` clean (no warnings) with the trimmed config.
- Trimmed config seeded from `userpatches/config/kernel/linux-msm8998-edge.config` (ARCH_QCOM only, ~1640 syms) + CPR3,
  qcom-hw cpufreq, SPM, icc msm8998 (y), RPM/SMD bits built in, panels/fg/IPA (m). Copy at the Armbian config.
- `CHECK_DTBS` on cheeseburger: only undocumented-binding warnings (8998 cpufreq-hw, OSM OPP props, F1A `syna,codes`,
  panel `port`/`rotation`). Expected for Armbian-only.
- Cosmetic leftovers: panel Kconfig order/blank line (S6E3FA5/FC1), OnePlus dtsi node order.

## Armbian (extensions branch, 2026-11-21)

- Commits: "rpardini: drop 2023 oneplus5/msm8998 userpatches" (old files shadowed the new family), "bsp: usb-gadget-network:
  optional ACM serial function", "msm8998: new family (edge 7.4) and OnePlus 5 (cheeseburger) board, WIP".
- Image builds: `compile.sh build BOARD=oneplus-cheeseburger BRANCH=edge RELEASE=trixie BUILD_MINIMAL=yes EXPERT=yes`.
  Outputs `*.boot_msm8998-oneplus-cheeseburger.img` (30MB), `*.rootfs.img` (1.5GB; armbian-firmware dropped, only the
  OnePlus firmware repo is shipped: qcom/, qca/, ath10k/).
- Firmware fetch runs inside the bsp hook (`fetch_sources_tools` only runs for u-boot artifacts).
- `zz-update-abl-kernel` is generic (`packages/bsp/qcom-abl/`); kebab/elish still use their own copies.

## Phone testing (2026-11-21, x13s root@192.168.66.19, phone serial c212167d)

- Setup on x13s: adb, fastboot, mkbootimg, qdl 2.8 (trixie-backports) installed. Work dir `/root/op5/`:
  - `boot.img`/`rootfs.img` (Armbian build), `unpacked/` (kernel+ramdisk from boot.img)
  - `try.sh <name> "<extra cmdline>"` (env `KERNEL=`, `RAMDISK_OFFSET=`): repack + `fastboot boot`, watches 180s for
    gadget (cdc_acm/ncm) or crashdump (05c6:900e); on crashdump auto `qdl ramdump` (KMSG, PMSG, DDRCS0_0 2GB, ...) into
    `/root/op5/ramdump/<name>-<time>/`.
  - kernels: `dbg-kernel` (patched, +simpledrm/pstore), `fix-kernel` (dbg + SMMU fix), `up-kernel` (plain v7.4-rc3),
    `old-kernel`/`old2-kernel` (2023 6.1 branch; old2 = RPM builtin + simpledrm). All are Image.gz+dtb.
- Phone: unlocked, non-A/B, boot 64MB, userdata ~53GB. Nothing flashed yet (only `fastboot boot`).
- USB in Android was flaky through the hub; fastboot/crashdump enumerate fine.
- Recovery from crashdump/EDL loop: unplug USB, hold Power 30-40s, Vol Up + Power, replug.
- Crash dumps: OnePlus XBL exposes KMSG.txt at 0xac17e00c (downstream ramoops layout) = garbage for us; the real log is
  in DDRCS0_0.BIN (phys 0x40000000+): `dd skip=0x6C000000` (ramoops at 0xac000000) + `strings`, from `Linux version 7.4`.
  Only dump in ONE qdl run: any qdl ramdump session ends with a reset (lost one dump that way).

### Findings

1. All 7.4 kernels (patched, upstream) crashed into crashdump ~25s after `fastboot boot`, screen stayed on logo.
   Cause (from RAM dump): MMSS SMMU probe puts MDSS into a translated domain while MDP still scans out the splash
   (`arm-smmu cd00000.iommu: Unhandled context fault ... iova=0x9d638b00` inside cont_splash 0x9d400000) → firmware reset.
   Fix committed on K33: "iommu/arm-smmu-qcom: Use identity domain for MSM8998 MDSS" (+`qcom,msm8998-mdss` in
   qcom_smmu_client_of_match). NOT yet in armbian patch dir / not rebuilt via Armbian.
2. With the fix (`fix-kernel`): no crash (no white LED), but screen goes black and no USB gadget within 180s.
   Tried `pd_ignore_unused`, and `modprobe.blacklist=msm,panel_samsung_s6e3fa5`: still black, no gadget.
3. Forced panic (`rdinit=/nonexistent rootdelay=20 panic=1 qcom_scm.download_mode=1`) rebooted to Android, not
   crashdump: SCM download mode doesn't stick. Long-press Power on a hung kernel also went to Android.
4. Ramdisk at 64MB (`RAMDISK_OFFSET=0x04000000`) didn't change the crash (before the fix). Image sizes: 6.1 13.8MiB,
   7.4 17.9MiB, Armbian 7.4 27MiB (arm64 header image_size) — not proven relevant.
5. 2023 6.1 kernel with the 7.4 initramfs: ABL stayed in fastboot (never left), or "powered by android" hang — not a valid
   baseline (modules mismatch; RPM bits are modules there).
- Caveat: test kernels are local builds (`kernel-msm8998/.build`, LOCALVERSION=-edge-msm8998, config = trimmed +
  DRM=y/DRM_SIMPLEDRM/PSTORE) booted with the Armbian initramfs: module vermagic/CRCs may not match → initramfs modules
  (rmi, i2c-qup, msm, gadget-related?) may fail to load. Gadget needs dwc3/qusb2/configfs (builtin) + regulators.

## Resume here

- Get logs from the non-crashing hang (black screen, no gadget). Ideas:
  - Match the downstream ramoops layout in the OP5 DT (console at 0xac17e000, size 0x40000; pmsg 0xac1bf000) so XBL's
    KMSG.txt segment, or a later dump, contains our console; then trigger crashdump.
  - Or make the kernel itself crash after ~30s in a way the firmware dumps (eg. the old SMMU fault: temporarily drop
    the identity fix after initramfs? or a deliberate bad MMIO / `sysrq-trigger c` from an initramfs hook) to capture
    the log in DDRCS0_0.
  - Build the test kernel through Armbian instead (matching modules/initramfs), with the SMMU fix + simpledrm/pstore.
- Check the USB gadget path in isolation: initramfs `usb-gadget` premount script, dwc3 peripheral mode, `/sys/class/udc`.
- Also add `qcom,msm8998-mdss` fix + simpledrm/pstore config to armbian (`patch/kernel/archive/msm8998-7.4`, config).
- Worktrees: `kernel-msm8998` (K33), `kernel-msm8998-up` (detached v7.4-rc3), `kernel-msm8998-old` (2023 6.1 branch;
  `.config` has RPM builtin + simpledrm). The two extra worktrees can be removed when done.
