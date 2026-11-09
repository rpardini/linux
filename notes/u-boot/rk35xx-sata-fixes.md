# U-Boot RK3588/RK356x on-board SATA fixes (U1)

Status ID: **U1**. Kernel twin of patch 3: **K9** (sent 2026-11-09). **Sent v1 2026-11-09**: `20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net` (https://patch.msgid.link/20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net). Tag `sent/20261024-rk3588-sata-fixes-v2027-01-892bf10a3512-v1`.
Debugging history: `BLADE3-SATA-REPORT.md`.

## Series

Cover: "rockchip: fix on-board SATA on RK3588 and RK356x" (retitled 2026-11-09, since RK356x sata1/sata2 are affected too). 3 patches:
1. `ata: dwc_ahci: fall back to the PHY in the sata-port subnode`: the RK3588 DT puts the PHY in `sata-port@0`, so probe always failed ("can't get the phy from DT"). Cc Jonas Karlman.
2. `ata: ahci: return the last LBA from emulated READ CAPACITY`: since 5f7c06bdc3c6 (the scsi +1 fix), AHCI disks are reported one sector too large, and UMS dies on the backup GPT. `Fixes: 5f7c06bdc3c6`, Cc Julius Lehmann.
   - Checked 2026-11-09: the +1 is still in `scsi_read_capacity()` on main.
   - `scsi_emul.c` was fixed together with 5f7c06bdc3c6, so `ahci.c` is the only emulation left unadjusted.
3. `phy: rockchip: naneng-combphy: fix RK3588 SATA pipe_con1 register offset`: same as K9 (sata2-only, TRM V1.0 Part1 §6.17).
   - `Fixes: c5b4a012bca8`.
   - `Link:` to the BSP commit and to the K9 patch (`20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net`).
   - Cc Yifeng Zhao.
   - The cover has the same neutral PCIe link-reset-grant note as K9.

## Armbian PR #11101 feedback (merged 2026-10-25; checked 2026-11-09)

- iav, comment 1: the dwc_ahci fix also helps RK3568. It's a **regression** there:
  - RK3566/RK3568 sata1/sata2 broke with U-Boot's v7.1 DT sync (`d0a838bdc62`, 2026-07-29), which brought in Linux 5918bf2a17f4 (Heiko, "Add port subnodes to RK356x SATA controllers"). Only RK3568 sata0 keeps phys on the controller.
  - Boards with DWC_AHCI: ODROID-M1/M1S, BPI-R2 Pro, QNAP TS433, Radxa E25, 9tripod, graperain.
  - U1 patch 1 message and cover point (1) now say so. User decision: no Fixes: tag (it would point at a subtree merge). The Linux change is linked by msgid. Not tested on RK356x.
- iav, comment 2: the READ CAPACITY off-by-one dates from v2025.01, so Armbian boards still on u-boot v2026.07 (eg. helios4) need it too. That's Armbian-only, and the user didn't take it up now.
- CodeRabbit (a), applied: the fallback runs only when phy-names has no "sata-phy" (`dev_read_stringlist_search() < 0`). A declared but failing PHY still fails the probe. Retested OK on 2026-11-09 (see below).
- CodeRabbit (b), multi-port: not changed. Only one PHY is brought up, as before; RK35xx controllers are single-port. The commit message says so.
- Heiko was added to the cover Cc (user, 2026-11-09).
- A reply to iav was drafted for the user to post.
- `gh` isn't logged in: the VM has no browser, and the user didn't want to paste a token. Remind them later. The anonymous API (60/h) works for reading PRs.
- Backup before these changes: `backup/u1-pre-coderabbit`.

## Retest 2026-11-09 (after the review fixes)

- Armbian deb `linux-u-boot-mixtile-blade3-edge … 2026.10-S5508-Pbde9…` (armbian-build `extensions` 222d20421, regenerated from the U1 commits on v2026.10).
- Flashed to the test board's eMMC at 32k. Backup of the old Pa444 build: `/root/uboot-emmc-backup-20261109-023606-Pa444.img` on the board.
- `scsi scan`: the mSATA SSD is found, so the stricter dwc_ahci fallback works. Capacity is 1000215216 x 512, where the Oct 24 log showed 1000215217 (the READ CAPACITY fix). The "SATA link 0 timeout" line was there on Oct 24 too.
- UMS (`ums 0 scsi 0`) wasn't rerun on this build. It worked on the previous build (Pa444), which has the same READ CAPACITY code; only the dwc_ahci probe condition changed since. 6 Gb/s: combphy code unchanged since the earlier test.

## Branch / worktree

- `b4/rk35xx-sata-fixes`, worktree `/opt/linuxdev/u-boot-rk35xx-sata-fixes` (renamed 2026-11-09 from `rk3588-sata-fixes`), on upstream **`main`** (934995f642a, v2027.01-rc1-341).
  - U-Boot renamed master → main. `uboot-upstream/master` (on GitHub and on git.u-boot-project.org) is frozen at v2026.07.
- change-id `20261024-rk3588-sata-fixes-v2027-01-892bf10a3512`, revision 1 (kept from the old branch).
- The old fork branch `linuxdev-work/b4/rk3588-sata-fixes-v2027.01` (on v2026.10+) has the pre-TRM text with Assisted-by. Delete it once the new branch is pushed.
- Local backup: `backup/u1-pre-reword` (rebased, pre-reword).
- Armbian: `u-boot/v2026.10/general-*`.

## Decisions (user, 2026-11-09)

- Slug `rk35xx-sata-fixes` (it was `rk3588-sata-fixes`).
- No `Assisted-by`. The user adds their own SoB.
- Board-neutral: no Blade 3 (not upstream) and no Armbian mention. "mSATA SSD on sata2 (combphy2_psu)".
- Rebased onto main, since these are fixes.
- Recipients come from `b4 prep --auto-to-cc`:
  - To: u-boot@lists.u-boot-project.org, Simon Glass, Kever Yang, Eugen Hristev, Jon Lin (author of the combphy Fixes target c5b4a012bca8; b4 re-added him on the 2026-11-09 auto-to-cc rerun)
  - Cc: Tom Rini, Peng Fan, Quentin Schulz, Heiko Stuebner (by hand), Jonas Karlman (added to the cover by hand on 2026-11-09, so he gets the whole series: he isn't in MAINTAINERS but wrote much of the RK3588 and combphy support), plus in-patch Cc's (Jonas on patch 1, Julius, Yifeng)
  - b4 flags `needs-auto-to-cc` after patch changes, and `b4 send` preflight fails until it is rerun.

## Checks (2026-11-09)

- Overlap: none. lei on the u-boot list for dwc_ahci.c, ahci.c and the combphy since mid-2025 found only unrelated patches. On main since the old base, only `8c1d2b441f9` (ahci_generic.c, unrelated).
- `b4 prep --check`: 3/3 clean.
- `coolpi-cm5-evb-rk3588_defconfig` (DWC_AHCI, NANENG_COMBOPHY, SCSI_AHCI) built with `KCFLAGS=-Werror` in `.build/coolpi-cm5-evb` (inside the worktree): clean, apart from missing-blob warnings.
- `b4 send --dry-run`: 4 messages, openpgp `X-Developer-Signature`, via B4 Relay.

## Sent / after sending

- Sent 2026-11-09 by the user (SoB added via rebase, then auto-to-cc rerun).
- Fork: `linuxdev-work/b4/rk35xx-sata-fixes` and the sent tag were pushed to `uboot-rpardini-armbian`. The old `linuxdev-work/b4/rk3588-sata-fixes-v2027.01` was deleted. The `backup/u1-*` branches were deleted.
- Sashiko: no patchset (API 404) at send time and again on 2026-11-09 afternoon; it seems not to cover the U-Boot list. Refresh with `scripts/20-lore.sh all U1`.
- Lore, 2026-11-09 afternoon: no replies yet (only the 4 sent messages).
- Still to do:
  - Armbian PR: cherry-pick armbian-build `extensions` 222d20421 onto armbian/build main (rpardini/armbian-build).
  - Post the iav reply there, with a link to this series.
