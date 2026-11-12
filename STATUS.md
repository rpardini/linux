# LinuxDev work status

Human-edited tracker for kernel / u-boot work that used to live in Mac-local `/Volumes/LinuxDev`.
Branch-level data the scripts need lives in `topics.tsv` (keep the IDs in sync); everything here is free-form.

- Lore, my posts: <https://lore.kernel.org/all/?q=f%3Aricardo%40pardini.net>
- Forks: kernel `rpardini/linux` (remote `kernel-rpardini-linux`), vendor 6.1 `rpardini/armbian-linux-rockchip-rk3588` (remote `kernel-rpardini-armbian-linux-rockchip-rk3588`), u-boot `rpardini/armbian-patched-u-boot` (remote `uboot-rpardini-armbian`). Remotes are prefixed per clone (`kernel-*`, `uboot-*`, `armbian-*`); list in `remotes.tsv`.
- Armbian patch paths are relative to `armbian-build/patch/`.
- Branch names below are **local** names. On the forks everything lives under `linuxdev-work/`: `b4/x` → `linuxdev-work/b4/x`, `mainline/x` → `linuxdev-work/mainline/x`, `armbian-tree/x` (full Armbian-patched trees) → `linuxdev-work/armbian-tree/x`, `rk61/x` → `linuxdev-work/rk61/x`. `11-vm-checkout.sh` maps them back, so b4 branches stay `b4/*` locally. Pre-existing un-prefixed copies on the forks (old `b4/*`, `pxe-http-boot`, the x13s branch…) are leftovers that can be deleted.
- Status words: `merged` · `sent vN` · `prepared` (b4 ready, unsent) · `wip` · `needs port` (only exists on an Armbian tree; picks do not apply on plain upstream) · `armbian-only` · `debug` · `parked` · `landed` · `drop`

Inventory as of 2026-11-06 (kernel v7.3 / u-boot v2026.10).

## Sent series: links

Per-series links for what's on the lists. Lore `b:` search by change-id catches every version plus replies. Local copies: `lore/topics/<ID>/` (refresh: `scripts/20-lore.sh all <ID>`). Last checked 2026-11-11.

### K4: RTL8125 PCIe Ethernet in DT (sent v6)

- Lore, v6 thread: <https://lore.kernel.org/all/20261109-rk3588-dts-rtl-eth-describe-dt-alias-v6-0-91f1efefba0b@pardini.net/>
- Lore, all versions: <https://lore.kernel.org/all/?q=b%3A20260524-rk3588-dts-rtl-eth-describe-dt-alias-c1ed187b7c50>
- Patchwork, linux-rockchip (v6 cover): <https://patchwork.kernel.org/project/linux-rockchip/cover/20261109-rk3588-dts-rtl-eth-describe-dt-alias-v6-0-91f1efefba0b@pardini.net/>
- Sashiko:
  - v6 (no findings): <https://sashiko.dev/#/patchset/20261109-rk3588-dts-rtl-eth-describe-dt-alias-v6-0-91f1efefba0b%40pardini.net>
  - v5 (2/7 with findings): <https://sashiko.dev/#/patchset/20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6%40pardini.net>
  - v1–v4: `lore/topics/K4/sashiko/v{1..4}.md` (each has its web link)

### K4b: dt-bindings: net: realtek,rtl8125 (merged into net-next)

- Applied to net-next by Jakub Kicinski 2026-11-11: <https://git.kernel.org/netdev/net-next/c/711c458f6f34>
- Lore, v1 thread: <https://lore.kernel.org/all/20261109-dt-bindings-net-realtek-rtl8125-v1-1-cff4b8a8be66@pardini.net/>
- Patchwork:
  - netdevbpf: <https://patchwork.kernel.org/project/netdevbpf/patch/20261109-dt-bindings-net-realtek-rtl8125-v1-1-cff4b8a8be66@pardini.net/>
  - devicetree: <https://patchwork.kernel.org/project/devicetree/patch/20261109-dt-bindings-net-realtek-rtl8125-v1-1-cff4b8a8be66@pardini.net/>
- Sashiko v1 (no findings): <https://sashiko.dev/#/patchset/20261109-dt-bindings-net-realtek-rtl8125-v1-1-cff4b8a8be66%40pardini.net>

### K9: RK3588 naneng-combphy SATA pipe_con1 (sent v1, v2 prepared)

- Lore, v1 thread (Sebastian's review + my T-b request): <https://lore.kernel.org/all/20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net/>
- Lore, all versions: <https://lore.kernel.org/all/?q=b%3A20261024-rk3588-combphy-sata2-6g-03bb30151552>
- Patchwork:
  - linux-phy: <https://patchwork.kernel.org/project/linux-phy/patch/20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net/>
  - linux-rockchip: <https://patchwork.kernel.org/project/linux-rockchip/patch/20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net/>
- Sashiko v1 (no findings): <https://sashiko.dev/#/patchset/20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a%40pardini.net>

### U1: RK3588/RK356x SATA fixes, u-boot (sent v1)

- Lore, v1 thread: <https://lore.kernel.org/u-boot/20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net/>
- Lore, all versions: <https://lore.kernel.org/all/?q=b%3A20261024-rk3588-sata-fixes-v2027-01-892bf10a3512>
- Patchwork, U-Boot (ozlabs, v1 cover): <https://patchwork.ozlabs.org/project/uboot/cover/20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net/>
- Sashiko: none (doesn't cover the U-Boot list)

## Kernel mainline (K)

| ID | Topic | Branch | Status | Next | Notes |
|---|---|---|---|---|---|
| K1 | rk3588 NPU enablements | `b4/arm64-dts-rockchip-rk3588-npu-enablements` | merged (v2, v6.20/7.0 cycle) | — | change-id `20251230-arm64-dts-rockchip-rk3588-npu-enablements-1e2830d2e7b0` |
| K2 | Radxa Zero 2: type-C controller, NPU | `b4/arm64-dts-amlogic-radxa-zero2-additions` | merged (v2, v6.20/7.0 cycle) | — | change-id `20260114-arm64-dts-amlogic-radxa-zero2-additions-905549fbed3e` |
| K3 | NanoPC-T6 regulator names per schematic | `b4/rk3588-dts-rockchip-nanopct6-fix-schematic-names` | merged (v1) | — | change-id `20260603-rk3588-dts-rockchip-nanopct6-fix-schematic-names-a1b8d27f82e7` |
| K4 | RTL8125 PCIe Ethernet in DT (NanoPC-T6, ROCK 5 family/ITX, CM3588-NAS, R5S, R6C) | `b4/rk3588-dts-rtl-eth-describe-dt-alias-v6-v7.4` | sent v6 (2026-11-09; v7.4-rc1, binding split out to K4b) | await review (Heiko); binding dep K4b now in net-next. Checked lore 2026-11-11: no list replies; Sashiko v6 6/6 no findings. Links: [Sent series](#k4-rtl8125-pcie-ethernet-in-dt-sent-v6) | change-id `20260524-rk3588-dts-rtl-eth-describe-dt-alias-c1ed187b7c50`; worktree `kernel-rk3588-rtl-eth`; Arm: `kernel/archive/rockchip64-7.4/rk3588-1220-…-many-boards.patch` (b4 dump; 7.3 hand-made, v6 does not apply); notes `notes/kernel/rk3588-rtl8125-dt.md`; lore `lore/topics/K4` |
| K4b | dt-bindings: net: `realtek,rtl8125` (split from K4 v5 1/7, Rob's R-b) | `b4/dt-bindings-net-realtek-rtl8125` | merged (v1 applied to net-next 2026-11-11, `711c458f6f34`; mainline in the 7.5 merge window) | — (drop the Armbian patch once the tree has it). Sashiko v1 no findings. Links: [Sent series](#k4b-dt-bindings-net-realtekrtl8125-merged-into-net-next) | change-id `20261108-dt-bindings-net-realtek-rtl8125-991226c1733f`; base net-next/main; worktree `kernel-rtl8125-binding`; Arm: `kernel/archive/rockchip64-7.4/rk3588-1219-dt-bindings-net-realtek-rtl8125-v1.patch`; notes `notes/kernel/rk3588-rtl8125-dt.md` |
| K6 | rk35xx MAC addresses from OTP (nvmem cpuid layouts RK3588/RK3568, GMAC + RTL8125 per-board) | `mainline/rk35xx-mac-from-otp` | wip | wait for dep | **On top of K4 and of someone else's nvmem serial#/cpuid series** — track that series; rebase when it lands |
| K7 | Nio-12L: i2c3 on 40-pin, drop i2c2 drive-strength | `b4/nio-12l-add-i2c-40-pin` | sent v2 (2026-06-24); v3 prepared | ping / resend | change-id `20260624-nio-12l-add-i2c-40-pin-19e0482fd835` |
| K8 | Nio-12L: UFS lanes, onboard LEDs, ASoC mediatek DAI-link refs (+K7) | `mainline/nio-12l-fixes` | wip | split: DT vs ASoC | Arm: `kernel/archive/genio-7.3/300{3,4}-*` |
| K9 | RK3588 naneng-combphy SATA pipe_con1 offset (SATA stuck at 1.5 Gb/s) | `b4/rk3588-combphy-sata2-6g` | sent v1 (2026-11-09, Fixes + stable); v2 prepared | send v2 later this week (user). v2 does Sebastian Reichel's review (Yifeng Zhao author + SoB, `[rewrite commit message]`, R-b collected). Replied 2026-11-10 asking for T-b from &sata2 board owners (Firefly ITX-3588J, ROC-RK3588-RT). Checked lore 2026-11-11: no T-b yet. Sashiko v1 no findings. Links: [Sent series](#k9-rk3588-naneng-combphy-sata-pipe_con1-sent-v1-v2-prepared) | change-id `20261024-rk3588-combphy-sata2-6g-03bb30151552`; worktree `kernel-rk3588-combphy-sata2-6g`; Arm: `rockchip64-7.{3,4}/914-*`; u-boot twin U1; notes `notes/kernel/rk3588-combphy-sata2-6g.md` |
| K10 | Seeed reComputer RK3588 Dev Kit (binding + 15 DT patches) | `mainline/recomputer-rk3588-devkit` | wip | b4 prep | includes K11 + PWMv4/counter build fixups underneath; alt attempts `v7.2-rc2-…-claude`, `…-copilot-FAIL` |
| K11 | Seeed reComputer RK3576 Dev Kit | `mainline/recomputer-rk3576-devkit` | wip | b4 prep | fan patch is `[DO-NOT-MERGE]`; carries `pwm`/`counter` rockchip PWMv4 "device flag accessors" fixups (Armbian-only?) ; alt `rk3576-devkit-rework` |
| K12 | Mixtile Blade 3 rework (fan, Type-C roles, RTL8125 behind ASM1182e, CAN2) | `mainline/mixtile-blade3-rework` | wip | clean up "claude pass" commits | sits on K4 |
| K13 | RK3528 TSADC: binding, thermal driver, dtsi, E24C enable | — (on KA1; was `mainline/rk3528-tsadc`) | needs port | port onto v7.3, then b4 prep | conflicts in `rockchip_thermal.c` at patch 2/4 (binding applies); picks in `topics.tsv` (commented-out row) |
| K14 | pmdomain/rockchip: dev_err_probe() on probe errors | — (on KA1; was `mainline/pmdomain-rockchip-dev-err-probe`) | needs port | port onto v7.3 | conflicts in `pm-domains.c`; from KA1; original sat on top of a revert of Bozeman's pmdomain patch |
| K15 | Radxa E24C mainline DT: USB, EEPROM MACs | — (on KA1/KA2; was `mainline/radxa-e24c-mainline-dt`) | needs port | port onto v7.3 | `rk3528-radxa-e24c.dts` is not in v7.3; from KA1/KA2; vendor-kernel twin RK11 (landed) |
| K16 | fusb302: drain RX FIFO on TX_SUCCESS/GCRCSENT | `mainline/fusb302-drain-rx-fifo` | wip | send | Arm: `rockchip64-7.{3,4}/912-*`; DEBUG tracing patch only on KA3 |
| K17 | drm/rockchip vop2: arm POST_BUF_EMPTY irq after modeset | `mainline/vop2-post-buf-empty-irq` | wip | test + send | from KA1; **not in Armbian** |
| K18 | net: stmmac: Phytium DWMAC glue | `mainline/phytium-stmmac` | wip | | Arm: `uefi-arm64-7.3/0001-*` |
| K19 | X13s: camera rotation; iris accept Gen1 fw; iris fw reload on hang | — (on KA4; was `mainline/x13s-iris-camera`) | needs port | port onto v7.3 | camera rotation applies; iris patches conflict in `iris_platform_vpu3x.c`; Arm: `sc8280xp-edge/030{1,3}-*`; notes in `notes/kernel/x13s-*`; Armbian context KA4 |
| K20 | Sunvell T95Z Plus: DT, IR pull-up, blue remote keytable | — (on KA5; was `mainline/t95z-plus`) | needs port | port onto v7.3 | `meson-gxm-t95z-plus.dts` is not in v7.3; from KA5 |
| K21 | rk3588: enable NPU on all remaining boards | `mainline/rk3588-npu-all-boards` | wip | rebase on v7.3, drop what K1 merged | alt `v7.1-rc4-add-rk3588-npu-all{,-sonnet}` |
| K22 | auxdisplay TM16xx: fix SPI autoload (on Jean-François Lessard's TM16xx v6 series) | `mainline/tm16xx-spi-autoload` | wip | reply on Lessard's thread | branch includes his 6 patches; Arm: `meson64-7.3/general-driver-tm16xx-v6.patch` |
| K23 | MediaTek MT8195 HDMI CEC: binding, `drivers/media/cec` driver, drm/mediatek HDMI v2 CEC notifier, mt8195.dtsi, Nio-12L enable | `b4/mt8195-cec` | prepared (v1, 6 patches, board-tested 2026-11-12 vs Blade 3 HDMI-in; cec-compliance clean) | review wording, SoB, send; TV test optional (sparse clean) | change-id `20261108-b4-mt8195-cec-7f2840a477aa`; Arm: `kernel/archive/genio-7.3/310{0..4}-*` + `CONFIG_CEC_MTK=m`; vendor ref `kernel-mediatek-aiot/mtk-v6.6`; notes `notes/kernel/mt8195-cec.md` |
| K24 | snps_hdmirx (RK3588 HDMI RX): CEC adapter takes the source's PA from its own EDID (should be the parent, 0.0.0.0), so `--tv` gets LA 14 | — | parked | analyze + fix later | found with K23 (Blade 3 RX); notes `notes/kernel/snps-hdmirx-cec-phys-addr.md` |
| K25 | MT8195 HDMI unplug: `vblank wait timed out` WARN in `mtk_crtc_atomic_disable` + runtime PM underflow (ETHDR / MDP-RDMA) | — | parked | prove pre-existing (build without K23 `3102`), check lore, analyze | found with K23 hotplug test; likely not CEC; notes `notes/kernel/mt8195-hdmi-unplug-vblank-warn.md` |

### Kernel Armbian trees (KA; full patched trees, README commit + my work on top)

| ID | Branch | Holds |
|---|---|---|
| KA1 | `armbian-tree/rockchip64-7.2-20260915` | K13, K14, K15, K17 + rkvdec VP9 picks |
| KA2 | `armbian-tree/rockchip64-7.2-20260813-e24c` | E24C USB + Kwiboo/Bozeman pmdomain picks |
| KA3 | `armbian-tree/rockchip64-7.3-20261022-blade3-fusb302` | K16 + fusb302 DEBUG + K9 |
| KA4 | `armbian-tree/sc8280xp-7.3-20261104-x13s` | K19 + claude notes |
| KA5 | `armbian-tree/meson64-7.2-20260923-t95z` | K20, K22 |

## Rockchip vendor 6.1 (RK; rkr7.2 / rkr5.1) → armbian/linux-rockchip

| ID | Topic | Branch | Status | Next | Notes |
|---|---|---|---|---|---|
| RK1 | Blade 3 fusb302 PD console tracing | `rk61/blade3-fusb302-pd-debug` | debug | keep | DO NOT UPSTREAM |
| RK2 | bcmdhd: build SDIO and PCIe as two modules | `rk61/bcmdhd-pcie-sdio` | PR draft open | someone else picking it up | |

### Landed in armbian/linux-rockchip (checked 2026-11-06; not migrated)

| ID | Topic | Old local branch | Landed as |
|---|---|---|---|
| RK3 | mfd/clk rk8xx: platform_device_id names | `nyanmisaka-rk-6.1-rkr7.2-fixes-batch1` | rkr7.2 57b1edc5, a79b3a75 |
| RK4 | Mixtile Edge 2 clkout2; Blade 3 RTL8125 + fan | `rk-6.1-rkr7.2-mixtile-edge2-blade3-fixes` | rkr7.2 7fab4e2c, d3e25dbc, 5aa56286 |
| RK5 | reComputer RK3588: RTL8125 in DT | `rk-6.1-rkr7.2-seeed-rek3588-stable-mac-rtl` | rkr7.2 8a0a8989 |
| RK6 | reComputer RK3588: fan curve | `rk-6.1-rkr7.2-rek3588-fine-tune-fan` | rkr7.2 a2d22aab |
| RK7 | vk2c21: sysfs brightness | `rk-6.1-rkr7.2-vk2c21-brightness` | rkr7.2 5ef479b1 |
| RK8 | Meko R58X-Pro VK2C21 auxdisplay rework | `meko-r58x-pro-LCD-rework` | rkr7.2 f75077c7, 23680736, 0fb7359e, bdbf9f62 |
| RK9 | remotectl rockchip-pwm channel-3 IRQ (landed, then reverted) | `input-remotectl-rockchip-pwm-irq-fix`, `rk-6.1-rkr{5.1,7.2}-pwm_remotectl_3chan_revert` | rkr7.2 3626ff8b + revert 057c0edb; rkr5.1 9d6ab8fb + revert fd9f8236 |
| RK10 | rk3528: drop pcie2x1 skip-reset-in-config | `rk3528_pcie_fix_rkr7.2` | rkr7.2 4375436b |
| RK11 | Radxa E24C: labels/LEDs, EEPROM MACs, eth0 alias | `e24c-fixes` | rkr7.2 428ab271, 7554973e, c5ab76fb, 6b54ea8c |
| RK12 | drop in-tree aic8800 sdio | `rk-6.1-rkr7.2-drop-aic8800-sdio-in-tree` | rkr7.2 e27e16b7 |
| RK13 | CM3588 dynamic dclk fix | `cm3588-backport-dclk-fix-from-fe` | rkr7.2 45f76186 |
| RK14 | stmmac: no IFF_UNICAST_FLT without address regs (+ backport) | `stmmac_unicast_sans_address_registers` | rkr7.2 7a450901, 5ec51316 |

Dropped: `mpp-report-zero-load-for-idle` — not needed on rkr7.2 (Rockchip solved it differently).

## U-Boot (U; UA = Armbian trees)

| ID | Topic | Branch | Status | Next | Notes |
|---|---|---|---|---|---|
| U1 | RK3588/RK356x SATA: dwc_ahci sata-port PHY, ahci READ CAPACITY last LBA, combphy pipe_con1 (sata2 6G, K9 twin) | `b4/rk35xx-sata-fixes` | sent v1 (2026-11-09, main v2027.01-rc1+) | await review. Checked lore 2026-11-11: no replies; 3/3 may need the same Yifeng authorship as K9 v2; no Sashiko (U-Boot list not covered). Links: [Sent series](#u1-rk3588rk356x-sata-fixes-u-boot-sent-v1) | change-id `20261024-rk3588-sata-fixes-v2027-01-892bf10a3512`; worktree `u-boot-rk35xx-sata-fixes`; Arm: `u-boot/v2026.10/rk35xx-sata-fixes-v1.patch`; notes `notes/u-boot/rk35xx-sata-fixes.md`, `notes/u-boot/BLADE3-SATA-REPORT.md` |
| U2 | tcpm/fusb302: drain RX FIFO, delay BC_LVL; Blade 3 USB-C1 sink-only; Sebastian Reichel's tcpm fixes | — (on UA1; was `mainline/blade3-fusb302-tcpm`) | needs port | port onto v2026.10 | `rk3588-mixtile-blade3-u-boot.dtsi` is not in v2026.10; Arm: `u-boot/v2026.10/board_mixtile-blade3/020-*`; reports `notes/u-boot/BLADE3-USBPD-REPORT.md`, `Blade3-usbpd-powering-submit.md` |
| UA1 | Armbian context for U2 (+DEBUG, + full PD logs "keep forever") | `armbian-tree/blade3-edge-20261022-debug-usbpd` | debug | keep | |
| U3 | PXE/extlinux over HTTP(S) + docs | `mainline/pxe-http-boot` | wip | b4 prep | Arm: `u-boot/v2026.{07,10}/pxe-over-http-v0.patch`; Armbian context UA2 `armbian-tree/pxe-http-boot` (has DEBUG) |
| U4 | RK3528: SFC/WDT/VPU/OTP/USB nodes + Radxa E24C board | `mainline/rk3528-e24c` | wip | | on Kwiboo's WIP rk3528; Arm: `u-boot/v2026.07/board_radxa-e24c/` |
| U5 | RK3588 stable GMAC MAC fdt fixup | `mainline/rk3588-stable-gmac-mac` | parked | | from `rk3588-stable-gmac-of-wip`; `rk3588-stable-gmac-of` has copilot-iteration history |
| U6 | Genio mt8195 / Nio-12L: boot order, mem size fixup, bind, btrfs, load addrs | `mainline/genio-mt8195-nio-12l` | armbian-only | | Arm: `u-boot/u-boot-genio/33xx-*` |
| UA3 | Blade 3 vendor u-boot PD tracing | `armbian-tree/blade3-vendor-20261022-pd-debug` | debug | | from `armbian-armsurvivors-mixtile-blade3-vendor-20261022` (diverged from fork) |

## Not migrated (stay on the Mac volume until it's retired)

- Snapshots / mirrors: `*-pristine`, `stable-google-*`, `android_*`, `torvalds-master-*`, `linux-6.19.y`, `friendlyelec_*`, `radxa-linux-*`, `collabora-*`, `kwiboo-*`, `flipperdevices-*`, `v6.18.44-openwrt-*`, `odroid-6.17.y-rebased`, u-boot `v20*-pristine`, `master-*`, `rockchip-linux-v5-*`, `kwiboo-denx-*`.
- Dated integration branches: `rk-6.1-rkr7.2-2026MMDD*`, `rk-6.1-rkr5.1-2026MMDD*`, `nyanmisaka-rk-6.1-rkr7{,.2}`.
- README branches with nothing on top: `armbian-armsurvivors-*` not listed above (u-boot `radxa-e24c-edge-*`, `mixtile-blade3-edge-2026{0411,0718}`, `radxa-nio-12l-*`).
- Superseded: `b4/rk3588-dts-rtl-eth-describe-dt-alias-{v5,ALL-BOARDS}` (`-v6` and `-v6-next`/K5 deleted 2026-11-08, after K4's `-v6-v7.4` replaced them), `v7.2-rc2-add-recomputer-rk3588-devkit-{claude,copilot-FAIL}`, `v7.1-rc4-add-rk3588-npu-all{,-sonnet}`, `rk3576-devkit-rework`, `meko-r58x-pro-LCD-brightness-claude`, `zero2-stuff`, `radxa-zero2-fusb302-*`, `radxa-e24c-26.07`, `rk3588-stable-gmac-of`, `work-genio-mt8195`, `rpardini-armbian-workbranch` (e24c hang debug), `rk-6.1-rkr7.2-fix-arm-32-bits-build-drop-missing-dt` (in armbian already), the landed B branches listed in section B, `backup/*`, `backup-before-mathh-rework`.
- Dropped: u-boot `v2026.01-opi5plus` (odroid-sm1 regulator-boot-on).

## Scripts

All default to dry-run (print only); `DRY_RUN=0` executes. `ONLY='^(K9|U1)$'` restricts to topic ids.

On the Mac (`LINUXDEV_ROOT=/Volumes/LinuxDev`, the default here):
1. `scripts/01-make-branches.sh` — create `mainline/*`, `armbian-tree/*`, `rk61/*` branches (copy, or cherry-pick onto v7.3 / v2026.10; failed picks are reported, not created).
2. `scripts/02-push.sh` — push them as `linuxdev-work/<branch>`, plus b4 `sent/*` tags and this `linuxdev-work/status` branch (remote `linuxdev-status-rpardini`), no force.
3. `scripts/03-verify.sh` — local vs fork, per topic (read-only).

Anywhere: `scripts/20-lore.sh init|mine|topic <ID>|sashiko <ID>|all <ID>|up` — lore mail via lei + Sashiko reviews into `$LINUXDEV_ROOT/lore` (how-to: `notes/lore-lei.md`). Agent instructions: `AGENTS.md`.

On a VM / remote host:
```sh
mkdir -p ~/linuxdev && cd ~/linuxdev
git clone -o linuxdev-status-rpardini -b linuxdev-work/status --single-branch git@github.com:rpardini/linux.git linuxdev-status
DRY_RUN=0 linuxdev-status/scripts/10-vm-clone-main.sh kernel --blobless   # main tree ~/linuxdev/kernel
DRY_RUN=0 linuxdev-status/scripts/10-vm-clone-main.sh u-boot
DRY_RUN=0 linuxdev-status/scripts/11-vm-checkout.sh K9                    # switch main tree to K9's branch
DRY_RUN=0 linuxdev-status/scripts/11-vm-checkout.sh U1 --worktree         # ~/linuxdev/u-boot-<slug|U1> (slug column in topics.tsv)
```
