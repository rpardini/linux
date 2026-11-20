# K31: Khadas Edge2 MCU + fan control

Efe's series (Muhammed Efe Cetin) to send upstream; we track it because Armbian edge (7.4) depends on it.

## Background

- Armbian carried `rk3588-1041-board-khadas-edge2-mcu.patch` (Efe, 2024) through 7.3.
- 7.4 copy: dropped as "upstreamed" (EvilOlaf, "rockchip64-7.4: drop upstreamed patches", 2026-11-02). It was never upstreamed; it stopped applying because 7.4 reworked khadas-mcu (6277c3cd74f5 per-variant config + VIM4, f9f61c21b942 MFD_CELL_*, c94c97f8c97e VIM4 variant, dad6f7897a93 fan config from platform data). Reported by iav on armbian/build#11460.
- Efe's upstream attempts: v1 2025-06-26, v2 2025-07-22, v3 2025-10-21 `<cover.1761059314.git.efectn@protonmail.com>` (`khadas,mcu-edge2`; Conor acked the binding; lkp W=1 warnings on 3/5; not merged).

## Port (2026-11-20)

Worktree `kernel-khadas-edge2-mcu`, branch `mainline/khadas-edge2-mcu` = v7.4-rc3 + Armbian `rk3588-1040-board-khadas-edge2-add-nodes` + 4 commits (author: user; "Based on Efe's series" + lore link in each; no SoB):

1. dt-bindings: `khadas,edge2-mcu` (user's choice, matches upstream `khadas,vim4-mcu`; Efe's v3 used `khadas,mcu-edge2`). No `fan-supply` for Edge2.
2. mfd: `KHADAS_MCU_EDGE2` variant: VIM4 regmap (Edge2 regs 0x12/0x13 version, 0x2C rest conf, 0x89 LED RAM, 0x8A fan, 0x8B WDT, 0x91 sys rst are identical to VIM4) plus SLEEP_EN 0x2E volatile (as in Efe's); cell `khadas-mcu-edge2-fan`; no user-mem cell.
3. thermal: Edge2 uses the VIM4 fan register and levels 0/30/40/55/75/100 (user's choice: VIM4 levels); dummy regulator for `fan`.
4. dts: `system-controller@18` on i2c2 (before rtc@51), package thermal zone with 5 active trips 45/50/55/60/70 °C → states 1..5 (my pick; Efe had 4 trips 45/55/60/70 in Armbian, 50/60/65/75 in v3).

Checks: W=1 build of `khadas-mcu.o` / `khadas_mcu_fan.o`, CHECK_DTBS `rk3588s-khadas-edge2.dtb`, `dt_binding_check` `mfd/khadas,mcu.yaml`: clean. **Untested on hardware** (no Edge2 here).

Armbian: `rk3588-1041-board-khadas-edge2-mcu.patch` (format-patch of the 4 commits) on `extensions`, commit "rockchip64-7.4: khadas-edge2: restore MCU fan control"; user cuts a separate PR (prtool) and asks Efe to look.

## Next

- Efe reviews/tests on an Edge2; he decides whether to send it upstream (as his v4, on top of the VIM4 rework).
