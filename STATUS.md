# LinuxDev work status

Human-edited tracker for kernel / u-boot work that used to live in Mac-local `/Volumes/LinuxDev`.
Branch-level data the scripts need lives in `topics.tsv` (keep the IDs in sync); everything here is free-form.

- Lore, my posts: <https://lore.kernel.org/all/?q=f%3Aricardo%40pardini.net>
- Forks: kernel `rpardini/linux` (remote `rpardini-linux`), vendor 6.1 `rpardini/armbian-linux-rockchip-rk3588`, u-boot `rpardini/armbian-patched-u-boot` (remote `rpardini-armbian`)
- Armbian patch paths are relative to `armbian-build/patch/`.
- Status words: `merged` · `sent vN` · `prepared` (b4 ready, unsent) · `wip` · `armbian-only` · `debug` · `parked` · `landed` · `drop`

Inventory as of 2026-11-06 (kernel v7.3 / u-boot v2026.10).

## A. Linux mainline

| ID | Topic | Branch | Status | Next | Notes |
|---|---|---|---|---|---|
| A1 | rk3588 NPU enablements | `b4/arm64-dts-rockchip-rk3588-npu-enablements` | merged (v2, v6.20/7.0 cycle) | — | change-id `20251230-arm64-dts-rockchip-rk3588-npu-enablements-1e2830d2e7b0` |
| A2 | Radxa Zero 2: type-C controller, NPU | `b4/arm64-dts-amlogic-radxa-zero2-additions` | merged (v2, v6.20/7.0 cycle) | — | change-id `20260114-arm64-dts-amlogic-radxa-zero2-additions-905549fbed3e` |
| A3 | NanoPC-T6 regulator names per schematic | `b4/rk3588-dts-rockchip-nanopct6-fix-schematic-names` | merged (v1) | — | change-id `20260603-rk3588-dts-rockchip-nanopct6-fix-schematic-names-a1b8d27f82e7` |
| A4 | RTL8125 PCIe Ethernet in DT + `realtek,rtl8125` binding (NanoPC-T6, ROCK 5 family/ITX, CM3588-NAS, R5S, R6C) | `b4/rk3588-dts-rtl-eth-describe-dt-alias-v6` (`-v6-next` variant) | sent v5 (2026-09-10); v6 prepared | send v6? | change-id `20260524-rk3588-dts-rtl-eth-describe-dt-alias-c1ed187b7c50`; Arm: `kernel/archive/rockchip64-7.{3,4}/rk3588-1220-…-many-boards.patch`. Old: `-v5`, `-ALL-BOARDS` |
| A5 | rk35xx MAC addresses from OTP (nvmem cpuid layouts RK3588/RK3568, GMAC + RTL8125 per-board) | `work/rk35xx-mac-from-otp` | wip | wait for dep | **On top of A4 and of someone else's nvmem serial#/cpuid series** — track that series; rebase when it lands |
| A6 | Nio-12L: i2c3 on 40-pin, drop i2c2 drive-strength | `b4/nio-12l-add-i2c-40-pin` | sent v2 (2026-06-24); v3 prepared | ping / resend | change-id `20260624-nio-12l-add-i2c-40-pin-19e0482fd835` |
| A7 | Nio-12L: UFS lanes, onboard LEDs, ASoC mediatek DAI-link refs (+A6) | `work/nio-12l-fixes` | wip | split: DT vs ASoC | Arm: `kernel/archive/genio-7.3/300{3,4}-*` |
| A8 | RK3588 naneng-combphy SATA pipe_con1 offset | `b4/rk3588-combphy-sata2-6g-v7.3.y` | prepared (v1) | send | change-id `20261024-rk3588-combphy-sata2-6g-v7-3-y-03bb30151552`; Arm: `rockchip64-7.{3,4}/914-*`; u-boot twin C1 |
| A9 | Seeed reComputer RK3588 Dev Kit (binding + 15 DT patches) | `work/recomputer-rk3588-devkit` | wip | b4 prep | includes A10 + PWMv4/counter build fixups underneath; alt attempts `v7.2-rc2-…-claude`, `…-copilot-FAIL` |
| A10 | Seeed reComputer RK3576 Dev Kit | `work/recomputer-rk3576-devkit` | wip | b4 prep | fan patch is `[DO-NOT-MERGE]`; carries `pwm`/`counter` rockchip PWMv4 "device flag accessors" fixups (Armbian-only?) ; alt `rk3576-devkit-rework` |
| A11 | Mixtile Blade 3 rework (fan, Type-C roles, RTL8125 behind ASM1182e, CAN2) | `work/mixtile-blade3-rework` | wip | clean up "claude pass" commits | sits on A4 |
| A12 | RK3528 TSADC: binding, thermal driver, dtsi, E24C enable | `work/rk3528-tsadc` | wip | b4 prep | picked from README branch AR1 onto v7.3 |
| A12p | pmdomain/rockchip: dev_err_probe() on probe errors | `work/pmdomain-rockchip-dev-err-probe` | wip | | from AR1; original sat on top of a revert of Bozeman's pmdomain patch |
| A13m | Radxa E24C mainline DT: USB, EEPROM MACs | `work/radxa-e24c-mainline-dt` | wip | | from AR1/AR2; vendor-kernel twin B6c (landed) |
| A14 | fusb302: drain RX FIFO on TX_SUCCESS/GCRCSENT | `work/fusb302-drain-rx-fifo` | wip | send | Arm: `rockchip64-7.{3,4}/912-*`; DEBUG tracing patch only on AR3 |
| A15 | drm/rockchip vop2: arm POST_BUF_EMPTY irq after modeset | `work/vop2-post-buf-empty-irq` | wip | test + send | from AR1; **not in Armbian** |
| A17 | net: stmmac: Phytium DWMAC glue | `work/phytium-stmmac` | wip | | Arm: `uefi-arm64-7.3/0001-*` |
| A18 | X13s: camera rotation; iris accept Gen1 fw; iris fw reload on hang | `work/x13s-iris-camera` | wip | | Arm: `sc8280xp-edge/030{1,3}-*`; notes in `notes/kernel/x13s-*`; Armbian context AR4 |
| A19 | Sunvell T95Z Plus: DT, IR pull-up, blue remote keytable | `work/t95z-plus` | wip | | from AR5 |
| A20 | rk3588: enable NPU on all remaining boards | `work/rk3588-npu-all-boards` | wip | rebase on v7.3, drop what A1 merged | alt `v7.1-rc4-add-rk3588-npu-all{,-sonnet}` |
| A22 | auxdisplay TM16xx: fix SPI autoload (on Jean-François Lessard's TM16xx v6 series) | `work/tm16xx-spi-autoload` | wip | reply on Lessard's thread | branch includes his 6 patches; Arm: `meson64-7.3/general-driver-tm16xx-v6.patch` |

### Armbian-context branches (full patched trees, README commit + my work on top)

| ID | Branch | Holds |
|---|---|---|
| AR1 | `work/armbian/rockchip64-7.2-20260915` | A12, A12p, A13m, A15 + rkvdec VP9 picks |
| AR2 | `work/armbian/rockchip64-7.2-20260813-e24c` | E24C USB + Kwiboo/Bozeman pmdomain picks |
| AR3 | `work/armbian/rockchip64-7.3-20261022-blade3-fusb302` | A14 + fusb302 DEBUG + A8 |
| AR4 | `armbian-armsurvivors-sc8280xp-7.3-20261104-x13s` | A18 + claude notes |
| AR5 | `work/armbian/meson64-7.2-20260923-t95z` | A19, A22 |

## B. Rockchip vendor 6.1 (rkr7.2 / rkr5.1) → armbian/linux-rockchip

| ID | Topic | Branch | Status | Next | Notes |
|---|---|---|---|---|---|
| B1d | Blade 3 fusb302 PD console tracing | `rk61/blade3-fusb302-pd-debug` | debug | keep | DO NOT UPSTREAM |
| B6f | bcmdhd: build SDIO and PCIe as two modules | `rk61/bcmdhd-pcie-sdio` | PR draft open | someone else picking it up | |

### Landed in armbian/linux-rockchip (checked 2026-11-06; not migrated)

| ID | Topic | Old local branch | Landed as |
|---|---|---|---|
| B1 | mfd/clk rk8xx: platform_device_id names | `nyanmisaka-rk-6.1-rkr7.2-fixes-batch1` | rkr7.2 57b1edc5, a79b3a75 |
| B2 | Mixtile Edge 2 clkout2; Blade 3 RTL8125 + fan | `rk-6.1-rkr7.2-mixtile-edge2-blade3-fixes` | rkr7.2 7fab4e2c, d3e25dbc, 5aa56286 |
| B3a | reComputer RK3588: RTL8125 in DT | `rk-6.1-rkr7.2-seeed-rek3588-stable-mac-rtl` | rkr7.2 8a0a8989 |
| B3b | reComputer RK3588: fan curve | `rk-6.1-rkr7.2-rek3588-fine-tune-fan` | rkr7.2 a2d22aab |
| B4a | vk2c21: sysfs brightness | `rk-6.1-rkr7.2-vk2c21-brightness` | rkr7.2 5ef479b1 |
| B4b | Meko R58X-Pro VK2C21 auxdisplay rework | `meko-r58x-pro-LCD-rework` | rkr7.2 f75077c7, 23680736, 0fb7359e, bdbf9f62 |
| B5 | remotectl rockchip-pwm channel-3 IRQ (landed, then reverted) | `input-remotectl-rockchip-pwm-irq-fix`, `rk-6.1-rkr{5.1,7.2}-pwm_remotectl_3chan_revert` | rkr7.2 3626ff8b + revert 057c0edb; rkr5.1 9d6ab8fb + revert fd9f8236 |
| B6b | rk3528: drop pcie2x1 skip-reset-in-config | `rk3528_pcie_fix_rkr7.2` | rkr7.2 4375436b |
| B6c | Radxa E24C: labels/LEDs, EEPROM MACs, eth0 alias | `e24c-fixes` | rkr7.2 428ab271, 7554973e, c5ab76fb, 6b54ea8c |
| B6d | drop in-tree aic8800 sdio | `rk-6.1-rkr7.2-drop-aic8800-sdio-in-tree` | rkr7.2 e27e16b7 |
| B6e | CM3588 dynamic dclk fix | `cm3588-backport-dclk-fix-from-fe` | rkr7.2 45f76186 |
| B6g | stmmac: no IFF_UNICAST_FLT without address regs (+ backport) | `stmmac_unicast_sans_address_registers` | rkr7.2 7a450901, 5ec51316 |

Dropped: B6a `mpp-report-zero-load-for-idle` — not needed on rkr7.2 (Rockchip solved it differently).

## C. U-Boot

| ID | Topic | Branch | Status | Next | Notes |
|---|---|---|---|---|---|
| C1 | RK3588 SATA: combphy pipe_con1, ahci READ CAPACITY last LBA, dwc_ahci sata-port PHY, rk3588 on-board SATA | `b4/rk3588-sata-fixes-v2027.01` | prepared (v1) | send | change-id `20261024-rk3588-sata-fixes-v2027-01-892bf10a3512`; Arm: `u-boot/v2026.10/general-*`; notes `notes/u-boot/BLADE3-SATA-REPORT.md` |
| C2 | tcpm/fusb302: drain RX FIFO, delay BC_LVL; Blade 3 USB-C1 sink-only; Sebastian Reichel's tcpm fixes | `work/blade3-fusb302-tcpm` | wip | | Arm: `u-boot/v2026.10/board_mixtile-blade3/020-*`; reports `notes/u-boot/BLADE3-USBPD-REPORT.md`, `Blade3-usbpd-powering-submit.md` |
| C2a | Armbian context for C2 (+DEBUG, + full PD logs "keep forever") | `work/armbian/blade3-edge-20261022-debug-usbpd` | debug | keep | |
| C3 | PXE/extlinux over HTTP(S) + docs | `work/pxe-http-boot` | wip | b4 prep | Arm: `u-boot/v2026.{07,10}/pxe-over-http-v0.patch`; Armbian context C3a `pxe-http-boot` (has DEBUG) |
| C4 | RK3528: SFC/WDT/VPU/OTP/USB nodes + Radxa E24C board | `work/rk3528-e24c` | wip | | on Kwiboo's WIP rk3528; Arm: `u-boot/v2026.07/board_radxa-e24c/` |
| C5 | RK3588 stable GMAC MAC fdt fixup | `work/rk3588-stable-gmac-mac` | parked | | from `rk3588-stable-gmac-of-wip`; `rk3588-stable-gmac-of` has copilot-iteration history |
| C6 | Genio mt8195 / Nio-12L: boot order, mem size fixup, bind, btrfs, load addrs | `work/genio-mt8195-nio-12l` | armbian-only | | Arm: `u-boot/u-boot-genio/33xx-*` |
| C7 | Blade 3 vendor u-boot PD tracing | `work/armbian/blade3-vendor-20261022-pd-debug` | debug | | from `armbian-armsurvivors-mixtile-blade3-vendor-20261022` (diverged from fork) |

## D. Not migrated (stay on the Mac volume until it's retired)

- Snapshots / mirrors: `*-pristine`, `stable-google-*`, `android_*`, `torvalds-master-*`, `linux-6.19.y`, `friendlyelec_*`, `radxa-linux-*`, `collabora-*`, `kwiboo-*`, `flipperdevices-*`, `v6.18.44-openwrt-*`, `odroid-6.17.y-rebased`, u-boot `v20*-pristine`, `master-*`, `rockchip-linux-v5-*`, `kwiboo-denx-*`.
- Dated integration branches: `rk-6.1-rkr7.2-2026MMDD*`, `rk-6.1-rkr5.1-2026MMDD*`, `nyanmisaka-rk-6.1-rkr7{,.2}`.
- README branches with nothing on top: `armbian-armsurvivors-*` not listed above (u-boot `radxa-e24c-edge-*`, `mixtile-blade3-edge-2026{0411,0718}`, `radxa-nio-12l-*`).
- Superseded: `b4/rk3588-dts-rtl-eth-describe-dt-alias-{v5,ALL-BOARDS}`, `v7.2-rc2-add-recomputer-rk3588-devkit-{claude,copilot-FAIL}`, `v7.1-rc4-add-rk3588-npu-all{,-sonnet}`, `rk3576-devkit-rework`, `meko-r58x-pro-LCD-brightness-claude`, `zero2-stuff`, `radxa-zero2-fusb302-*`, `radxa-e24c-26.07`, `rk3588-stable-gmac-of`, `work-genio-mt8195`, `rpardini-armbian-workbranch` (e24c hang debug), `rk-6.1-rkr7.2-fix-arm-32-bits-build-drop-missing-dt` (in armbian already), the landed B branches listed in section B, `backup/*`, `backup-before-mathh-rework`.
- Dropped: u-boot `v2026.01-opi5plus` (odroid-sm1 regulator-boot-on).

## Scripts

All default to dry-run (print only); `DRY_RUN=0` executes. `ONLY='^(A8|C1)$'` restricts to topic ids.

On the Mac (`LINUXDEV_ROOT=/Volumes/LinuxDev`, the default here):
1. `scripts/01-make-branches.sh` — create `work/*`, `rk61/*` branches (copy, or cherry-pick onto v7.3 / v2026.10; failed picks are reported, not created).
2. `scripts/02-push.sh` — push them, b4 `sent/*` tags and this `status` branch to the forks (no force).
3. `scripts/03-verify.sh` — local vs fork, per topic (read-only).

On a VM / remote host:
```sh
mkdir -p ~/linuxdev && cd ~/linuxdev
git clone -b status --single-branch git@github.com:rpardini/linux.git linuxdev-status
DRY_RUN=0 linuxdev-status/scripts/10-vm-clone-main.sh kernel --blobless   # main tree ~/linuxdev/kernel
DRY_RUN=0 linuxdev-status/scripts/10-vm-clone-main.sh u-boot
DRY_RUN=0 linuxdev-status/scripts/11-vm-checkout.sh A8                    # switch main tree to A8's branch
DRY_RUN=0 linuxdev-status/scripts/11-vm-checkout.sh C1 --worktree         # ~/linuxdev/u-boot-C1
```
