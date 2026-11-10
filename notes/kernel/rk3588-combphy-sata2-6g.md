# RK3588 naneng-combphy: SATA pipe_con1 register offset (K9)

Status ID: **K9**. U-Boot twin: **U1** (same table, same bug). **Sent v1 2026-11-09** by the user via b4: `20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net` (https://patch.msgid.link/20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net). Tag `sent/20261024-rk3588-combphy-sata2-6g-03bb30151552-v1` is GPG-signed.

## The bug

`drivers/phy/rockchip/phy-rockchip-naneng-combphy.c`, `rk3588_combphy_grfcfgs`:
- `.pipe_con1_for_sata = { 0x0000, 2, 0, 0x00, 0x2 }`. It should be offset `0x0004` (php_grf CON1[2:0] = 2).
- Because of this, CON1 is never written and SATA trains only at 1.5 Gb/s.
- Rockchip fixed this in its BSP in 2022 ("config sata2 rate to 6G for rk3588", rockchip-linux/kernel 2f5fe2c0bbd4).
- Still wrong in `kernel-torvalds/master` and next-20261105 as of 2026-11-08. lore has no prior patch for it.

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

## Sent / after sending

- v1 sent 2026-11-09. The SoB, the GPG signature (openpgp-sha256 `X-Developer-Signature`) and `b4 prep --check` 1/1 were all done before sending.
- Sashiko v1: Reviewed, "No issues found" (`lore/topics/K9/sashiko/v1.md`). No list replies yet: lore has 4 list copies of the patch. Rechecked 2026-11-09 afternoon: unchanged.
- The backup branch `backup/k9-pre-trm-reword` was deleted 2026-11-09.
- b4 bumped the local branch to revision 2 after sending, which left both branch commits **unsigned**: b4's pygit2 rewrite drops GPG signatures by design. The sent tag is still signed. That's fine: b4 doesn't need signed commits, since the mails are patatt-signed. Don't re-sign (user, 2026-11-09; see AGENTS.md).
- Still to do: v2 per Sebastian's review (below).

## v1 review (lore, checked 2026-11-10)

Sebastian Reichel, 2026-11-10 00:29, `<avJULe_00cHwMh4X@venus>`. `Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>` conditional on:
- [x] Authorship: the patch is 1:1 from Yifeng Zhao, so he should be the author. Trailers: `Fixes:`, `Cc: stable`, `Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>`, bracket note, `Signed-off-by: Ricardo Pardini`. His example drops the BSP `Link:` and the `Cc: Yifeng`.
- [x] Drop the last sentence of the TRM paragraph ("Rockchip fixed this in their BSP kernel in 2022 ..."): irrelevant in the git log.
- [x] Put the pcie3x2 link reset grant side effect (stray write to PHP_GRF_PHP_CON0[2:0]) in the commit message.
- [x] Below the fold: drop the three paragraphs that repeat the commit message. Keep "only sata2 tested / U-Boot fix sent separately".

User's reply, 2026-11-10 02:30, `<f225b5f6-13eb-40d0-a9ca-7efab0e6876c@pardini.net>`: thanks; v2 prepared, waiting a bit before sending; asked for Tested-by from &sata2 board owners.
- In mainline, &sata2 is enabled on RK3588 only in `rk3588-firefly-itx-3588j.dts` and `rk3588-roc-rt.dts` (v7.4-rc1 / torvalds 2026-11-08). The other &sata2 users are RK356x, which uses a different grfcfg table and isn't affected.
- Lucas Tanure (v1 To:) is not on the reply's Cc.

## v2 (prepared 2026-11-10; user sends later this week)

- Yifeng's SoB is copied word for word from BSP commit 2f5fe2c0bbd4. Bracket note `[rewrite commit message]` (user's choice; precedents: c9211fa2602b, feb69bccf5d3, 98dcc6be3859). R-b collected with `b4 -n trailers -u` (DKIM ✗ for collabora.com).
- Below the fold: the sata2-only note + `[1]` link to U1 v1, plus Changes in v2.
- Backup branch `backup/k9-pre-v2`. Checks: `b4 prep --check` clean, `b4 send --dry-run` OK.
- **b4 0.16 gotcha:** don't run `b4 prep --auto-to-cc` when the cover has a `---` Changes section. Send parses To/Cc above the `---`, but auto-to-cc reads the raw cover, finds nothing, and appends a duplicate block at the end, which then leaks into the mail body.
- Before sending: rerun `scripts/20-lore.sh all K9` for any Tested-by, then `b4 trailers -u`.
- U1 3/3 (U-Boot twin): same Yifeng authorship question, still open.

## Checks run

- `make W=1 drivers/phy/rockchip/phy-rockchip-naneng-combphy.o` (arm64 defconfig plus `PHY_ROCKCHIP_NANENG_COMBO_PHY=y`, build dir `.build`): clean.
