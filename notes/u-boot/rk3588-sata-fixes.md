# U-Boot RK3588 on-board SATA fixes (U1)

Status ID: **U1**. Kernel twin of patch 3: **K9** (sent 2026-11-09). Prepared 2026-11-09 and **not sent**.
Debugging history: `BLADE3-SATA-REPORT.md`.

## Series

Cover: "rockchip: rk3588: fix on-board SATA". 3 patches:
1. `ata: dwc_ahci: fall back to the PHY in the sata-port subnode`: the RK3588 DT puts the PHY in `sata-port@0`, so probe always failed ("can't get the phy from DT"). Cc Jonas Karlman.
2. `ata: ahci: return the last LBA from emulated READ CAPACITY`: since 5f7c06bdc3c6 (the scsi +1 fix), AHCI disks are reported one sector too large, and UMS dies on the backup GPT. `Fixes: 5f7c06bdc3c6`, Cc Julius Lehmann.
   - Checked 2026-11-09: the +1 is still in `scsi_read_capacity()` on main.
   - `scsi_emul.c` was fixed together with 5f7c06bdc3c6, so `ahci.c` is the only emulation left unadjusted.
3. `phy: rockchip: naneng-combphy: fix RK3588 SATA pipe_con1 register offset`: same as K9 (sata2-only, TRM V1.0 Part1 §6.17).
   - `Fixes: c5b4a012bca8`.
   - `Link:` to the BSP commit and to the K9 patch (`20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net`).
   - Cc Yifeng Zhao.
   - The cover has the same neutral PCIe link-reset-grant note as K9.

## Branch / worktree

- `b4/rk3588-sata-fixes`, worktree `/opt/linuxdev/u-boot-rk3588-sata-fixes`, on upstream **`main`** (934995f642a, v2027.01-rc1-341).
  - U-Boot renamed master → main. `origin/master` (on GitHub and on git.u-boot-project.org) is frozen at v2026.07.
- change-id `20261024-rk3588-sata-fixes-v2027-01-892bf10a3512`, revision 1 (kept from the old branch).
- The old fork branch `linuxdev-work/b4/rk3588-sata-fixes-v2027.01` (on v2026.10+) has the pre-TRM text with Assisted-by. Delete it once the new branch is pushed.
- Local backup: `backup/u1-pre-reword` (rebased, pre-reword).
- Armbian: `u-boot/v2026.10/general-*`.

## Decisions (user, 2026-11-09)

- Slug `rk3588-sata-fixes`.
- No `Assisted-by`. The user adds their own SoB.
- Board-neutral: no Blade 3 (not upstream) and no Armbian mention. "mSATA SSD on sata2 (combphy2_psu)".
- Rebased onto main, since these are fixes.
- Recipients come from `b4 prep --auto-to-cc`:
  - To: u-boot@lists.u-boot-project.org, Simon Glass, Kever Yang, Eugen Hristev
  - Cc: Tom Rini, Peng Fan, Quentin Schulz, plus in-patch Cc's (Jonas, Julius, Yifeng)
  - Jon Lin (in the old To) is no longer suggested.

## Checks (2026-11-09)

- Overlap: none. lei on the u-boot list for dwc_ahci.c, ahci.c and the combphy since mid-2025 found only unrelated patches. On main since the old base, only `8c1d2b441f9` (ahci_generic.c, unrelated).
- `b4 prep --check`: 3/3 clean.
- `coolpi-cm5-evb-rk3588_defconfig` (DWC_AHCI, NANENG_COMBOPHY, SCSI_AHCI) built with `KCFLAGS=-Werror` in `.build/coolpi-cm5-evb`: clean, apart from missing-blob warnings.
- `b4 send --dry-run`: 4 messages, openpgp `X-Developer-Signature`, via B4 Relay.

## Before sending

1. The user adds their SoB to the 3 patches, eg. `git rebase -x 'git commit --amend -s --no-edit' HEAD~3`. A b4 rewrite afterwards (eg. `--auto-to-cc`) drops commit signatures, and that's fine.
2. gpg-agent unlocked, then `b4 send`.
3. After sending: `20-lore.sh all U1`, STATUS `sent v1`, push the branch and tag, delete the old `-v2027.01` fork branch and `backup/u1-pre-reword`.
