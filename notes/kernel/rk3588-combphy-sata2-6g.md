# RK3588 naneng-combphy: SATA pipe_con1 register offset (K9)

Status ID: **K9**. U-Boot twin: **U1** (same table, same bug). Prepared 2026-11-08 and **not sent**.

## The bug

`drivers/phy/rockchip/phy-rockchip-naneng-combphy.c`, `rk3588_combphy_grfcfgs`:
- `.pipe_con1_for_sata = { 0x0000, 2, 0, 0x00, 0x2 }`. It should be offset `0x0004` (php_grf CON1[2:0] = 2).
- Because of this, CON1 is never written and SATA trains only at 1.5 Gb/s.
- Rockchip fixed this in its BSP in 2022 ("config sata2 rate to 6G for rk3588", rockchip-linux/kernel 2f5fe2c0bbd4).
- Still wrong in torvalds/master and next-20261105 as of 2026-11-08. lore has no prior patch for it.

Tested (by the user) with an mSATA SSD on sata2 (combphy2_psu): 1.5 → 6.0 Gb/s, 124 → 421 MB/s O_DIRECT reads.
Only sata2 was tested.

## Branch / worktree

- `b4/rk3588-combphy-sata2-6g` on v7.4-rc1, worktree `/opt/linuxdev/kernel-rk3588-combphy-sata2-6g`
- Single patch with a b4 cover. The cover note goes below the cut: vendor commit title, only sata2 tested, U-Boot fix sent separately.
- change-id `20261024-rk3588-combphy-sata2-6g-03bb30151552`, renamed from `…-v7-3-y-…`, which was never sent.
- The old branch `b4/rk3588-combphy-sata2-6g-v7.3.y` (on v7.3) was deleted 2026-11-08, locally and on the fork.
- The new branch was pushed to the fork as `linuxdev-work/b4/rk3588-combphy-sata2-6g`.
- Armbian: `kernel/archive/rockchip64-7.{3,4}/914-*`

## Decisions (user, 2026-11-08)

- No `Fixes:` and no `Cc: stable`. It's sent as a normal patch.
- Keep the Mixtile Blade 3 out of commit message and cover: it isn't in mainline, so it shouldn't be the focus.
- Ignore Arthur Fabre's 2026-02-21 report "Rock 5 ITX shared SATA broken by 'fix phy reset'" (sata1, bisected to fbcbffbac994). It may be related but is unproven.
- No `Assisted-by:`.
- Recipients come from `b4 prep --auto-to-cc`: Vinod, Neil, Mani, Heiko, plus linux-phy, linux-arm-kernel, linux-rockchip and LKML. Yifeng Zhao (BSP fix author) is Cc'd from inside the patch.

## Before sending

1. **Signed-off-by** has to be added by the user (AI must not add it, per Documentation/process/coding-assistants.rst):
   `cd /opt/linuxdev/kernel-rk3588-combphy-sata2-6g && git commit --amend -s --no-edit`
2. **Signing / B4 Relay** isn't set up on this VM yet (no patatt, GPG or b4 relay config). Copy the Mac setup over:
   the key (patatt ed25519 or GPG), `patatt.signingkey`, `b4.send-endpoint-web`. Check with `b4 send --dry-run`.
   The same applies to K4 and K4b. Confirmed: `b4 send -o` stops with "CRITICAL: patatt.signingkey is not set".
3. `b4 prep --check` passes 1/1. There's no `Assisted-by` (user: the kernel doesn't take it anymore). b4 seems to fill in the SoB when rendering, but add it explicitly anyway.
4. Run `b4 send --dry-run`, then send.

## Checks run

- `make W=1 drivers/phy/rockchip/phy-rockchip-naneng-combphy.o` (arm64 defconfig plus `PHY_ROCKCHIP_NANENG_COMBO_PHY=y`, build dir `.build`): clean.
