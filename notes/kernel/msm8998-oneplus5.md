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

## Resume here

- Armbian side: family, board, config, patch export, ABL bootenv (non-A/B), firmware fetch, usb gadget ACM.
- Then: build image, test on phone (`fastboot boot` first).
