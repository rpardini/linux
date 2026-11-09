# RK3588 naneng-combphy: SATA pipe_con1 register offset (K9)

Status ID: **K9**. U-Boot twin: **U1** (same table, same bug). Prepared 2026-11-08, reworded 2026-11-09 (TRM, Fixes, stable); being sent by the user.

## The bug

`drivers/phy/rockchip/phy-rockchip-naneng-combphy.c`, `rk3588_combphy_grfcfgs`:
- `.pipe_con1_for_sata = { 0x0000, 2, 0, 0x00, 0x2 }`. It should be offset `0x0004` (php_grf CON1[2:0] = 2).
- Because of this, CON1 is never written and SATA trains only at 1.5 Gb/s.
- Rockchip fixed this in its BSP in 2022 ("config sata2 rate to 6G for rk3588", rockchip-linux/kernel 2f5fe2c0bbd4).
- Still wrong in torvalds/master and next-20261105 as of 2026-11-08. lore has no prior patch for it.

Tested (by the user) with an mSATA SSD on sata2 (combphy2_psu): 1.5 → 6.0 Gb/s, 124 → 421 MB/s O_DIRECT reads.
Only sata2 was tested.

## TRM (RK3588 TRM V1.0 Part1, 6.17 PHP_GRF; PDFs in ~/linuxdev/reference-material, text via pdftotext)

- PHP_GRF_PHP_CON0 (0x0000): sata0_phy_spdmode [6:5], rx_err [7]; sata1_phy_spdmode [10:9], rx_err [11]. pipe_con0_for_sata already sets both to 6G. PCIe link_rst_grt bits [4:0]: pie4l=pcie3x4, pcie2l=pcie3x2, pcie1l0/1/2.
- PHP_GRF_PHP_CON1 (0x0004): only sata2_phy_rx_err [2] and sata2_phy_spdmode [1:0]. So the bug is **sata2-only**.
- The stray 0x2 write to CON0[2:0] turns on the pcie3x2 link reset grant. No known effect, since no driver uses these bits and dw-rockchip re-inits the RC on link-down. The cover mentions it neutrally (user decision 2026-11-09).
- Original code: a03c44277253 (v6.4, Lucas Tanure, PCIe2 series v2, https://lore.kernel.org/all/20230314135555.44162-4-lucas.tanure@collabora.com/). It is now the `Fixes:` target.

## Branch / worktree

- `b4/rk3588-combphy-sata2-6g` on v7.4-rc1, worktree `/opt/linuxdev/kernel-rk3588-combphy-sata2-6g`
- Single patch with a b4 cover. The cover note goes below the cut: what it does; how it was found (BSP commit title) plus the TRM; the PCIe grant-bit note; only sata2 tested, U-Boot fix sent separately.
- change-id `20261024-rk3588-combphy-sata2-6g-03bb30151552`, renamed from `…-v7-3-y-…`, which was never sent.
- The old branch `b4/rk3588-combphy-sata2-6g-v7.3.y` (on v7.3) was deleted 2026-11-08, locally and on the fork.
- The new branch was pushed to the fork as `linuxdev-work/b4/rk3588-combphy-sata2-6g`.
- Armbian: `kernel/archive/rockchip64-7.{3,4}/914-*`

## Decisions (user, 2026-11-08)

- ~~No `Fixes:`/stable~~. Reversed 2026-11-09 after the TRM confirmation: `Fixes: a03c44277253` plus `Cc: stable@vger.kernel.org` (submitting-patches.rst, stable-kernel-rules.rst). The cover's no-Fixes paragraph and the thread link were dropped. auto-to-cc then added the Fixes authors (Andrew Powers-Holmes, Lucas Tanure) as To.
- Keep the Mixtile Blade 3 out of commit message and cover: it isn't in mainline, so it shouldn't be the focus.
- Ignore Arthur Fabre's 2026-02-21 report "Rock 5 ITX shared SATA broken by 'fix phy reset'" (sata1, bisected to fbcbffbac994). It may be related but is unproven.
- No `Assisted-by:`.
- Recipients come from `b4 prep --auto-to-cc`: Vinod, Neil, Mani, Heiko, Andrew Powers-Holmes, Lucas Tanure (Fixes authors; the 2023 collabora address may bounce), plus linux-phy, linux-arm-kernel, linux-rockchip and LKML. stable and Yifeng Zhao (BSP fix author) are Cc'd from inside the patch.

## Before sending

1. Signed-off-by: added by the user on 2026-11-08.
2. Signing: GPG key set up on this VM on 2026-11-08 (see AGENTS.md). `b4 send --dry-run` produces an openpgp-sha256 `X-Developer-Signature`.
3. `b4 prep --check` passes 1/1. There's no `Assisted-by` (user: the kernel doesn't take it anymore).
4. 2026-11-09:
   - commit message corrected to sata2-only, with a TRM citation
   - `Fixes:` and `Cc: stable` added
   - cover reworded (TRM, PCIe grant-bit note)
   - both commits re-signed (G)
   - backup branch `backup/k9-pre-trm-reword` (pre-TRM text)
5. The dry-run is OK, with an openpgp signature. The user sends it via b4 themselves (2026-11-09). Afterwards: `20-lore.sh all K9`, update STATUS to `sent v1`, push the branch and the `sent/` tag to the fork, delete the backup branch.
6. U1 (U-Boot twin): apply the same sata2-only correction before it is sent.

## Checks run

- `make W=1 drivers/phy/rockchip/phy-rockchip-naneng-combphy.o` (arm64 defconfig plus `PHY_ROCKCHIP_NANENG_COMBO_PHY=y`, build dir `.build`): clean.
