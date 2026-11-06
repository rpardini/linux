# HDMI black-screen-on-wake — CM3588 NAS + 4K TV

Board: FriendlyElec CM3588 NAS (RK3588), `rk3588-friendlyelec-cm3588-nas.dts`
Kernel: 6.1.115-vendor-rk35xx (Rockchip vendor / Armbian)
Sink: "Beyond TV" (cheap 4K TV), connected to **HDMI0** (`fde80000.hdmi`, dw-hdmi-**qp**)
Userspace: **Kodi** (GBM/KMS), console/fbcon shown sometimes.

## Symptom

After the TV is powered off **for a while** and turned back on, sometimes there is
**no HDMI signal** — requires a reboot to recover. Short standby cycles recover fine.

During a live black-screen event:
- `/sys/class/drm/card0-HDMI-A-1/status` = `connected`
- EDID reads back perfectly (`edid-decode` clean)
- dmesg on the re-enable still prints `hdptx phy pll locked!` / `hdptx phy lane locked!`

## Root cause: SCDC scrambling not re-asserted on the "same-mode" wake path

The TV needs **HDMI 2.0 scrambling** for 4K60. Its EDID (HDMI 2.0 mode) advertised:
- CTA: `VIC 97: 3840x2160 60Hz -> 594 MHz TMDS` (the active mode)
- HDMI Forum VSDB: `Max TMDS Character Rate 600 MHz`, **SCDC Present**,
  `Supports scrambling for <= 340 Mcsc`

Any TMDS character rate **> 340 MHz** is only legal if the source writes the sink's
**SCDC** registers over DDC/I2C to set `TMDS_Bit_Clock_Ratio = 1/40` and
`Scrambling_Enable = 1`. If the sink isn't told, it receives a scrambled 594 MHz
stream it cannot descramble -> black screen, while HPD stays high and EDID still reads.

Code path (`drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c`):

1. SCDC/scrambling programming is gated on `!hdmi->update` (`dw_hdmi_qp_setup`, ~line 2574):
   ```c
   if (!link_cfg->frl_mode && dw_hdmi_support_scdc(...) && !hdmi->update) {
       if (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK) {   // > 340 MHz
           drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
           drm_scdc_set_scrambling(hdmi->ddc, 1);       // the write the sink needs
           hdmi_writel(hdmi, 1, SCRAMB_CONFIG0);
           msleep(100);
       } else { /* <=340 MHz: scrambling OFF */ }
   }
   ```
   When `hdmi->update` is true, the whole block is **skipped**.

2. `hdmi->update = true` is set when the wake mode equals the current mode (~line 3261):
   same `mpixelclock` && same `mtmdsclock` && `mode.clock <= 600000` && `!hdmi->disabled`.
   Many TVs keep HPD asserted in standby, so the SoC never sees a disconnect and
   `hdmi->disabled` stays false -> the wake takes this seamless "update" fast-path.

3. A TV powered fully off **resets its SCDC registers to default** (scrambling OFF,
   1/10 ratio). On wake the source re-locks the PHY at scrambled 594 MHz but, on the
   `update` path, never rewrites the sink SCDC -> mismatch -> black screen.

### Why it matches every observation
- `connected` + EDID reads: HPD high, DDC works; only the SCDC handshake is wrong.
- `phy ... locked!` even on failure: those are `dev_err`-level **success** prints of the
  source PHY's own PLL/lane bits (`phy-rockchip-samsung-hdptx-hdmi.c:944,978`); they say
  nothing about the sink descrambling.
- Only after off **"for a while"**: brief standby keeps sink SCDC state (works); full
  power-off resets it (needs a rewrite the update-path skips).
- **Intermittent**: depends on whether the wake lands on the same fractional variant
  (594000 vs 593407 kHz = 60.00 vs 59.94 Hz) as `previous_mode`. Same -> `update=true` ->
  SCDC skipped -> black. Different -> full modeset -> SCDC rewritten -> works.
- Reboot always fixes it: cold bring-up is a full modeset (`update=false`).
- Dropping to 4K30/24/1080p worked: those are <=340 MHz -> scrambling not used at all.

`POST_BUF_EMPTY irq err at vp0` flooding + boot-time
`rockchip-dmc dmc: failed to get vop bandwidth to dmc rate` are a **separate, secondary**
VOP2/DDR-bandwidth marginality — NOT the black-screen cause. The CEC `... timed out`
messages just line up with TV-off windows and are harmless.

## The general rule

The bug lives entirely in the scrambling path, which is only used when
**TMDS character rate > 340 MHz** (`HDMI14_MAX_TMDSCLK = 340000000`). Any mode at or
below 340 MHz takes the "scrambling OFF" branch, so source and a freshly power-cycled
sink always agree -> the bug cannot trigger.

Sub-340 options on this TV (safe):
- **3840x2160 @ 60 in YCbCr 4:2:0 -> 297 MHz** (keeps 4K & 60Hz; driver halves TMDS for
  4:2:0, `dw-hdmi-qp.c:3258`). Must be *forced* — auto-select prefers RGB (594 MHz).
- 3840x2160 @ 30/25/24 RGB -> 297 MHz
- 2560x1440 @ 60 -> 249 MHz
- 1920x1080 @ 60 -> 148.5 MHz
- 1280x720 @ 60 -> 74.25 MHz

For a media box, real 4K content is film at 24/25/30 Hz (all <=297 MHz); 60 Hz is only
needed for the GUI, where 1080p60 is fine. So 4K50/60 is never actually needed here.

## Fixes applied (config only, no kernel change) — WORKING

1. **Kernel cmdline**: `video=HDMI-A-1:1920x1080@60`
   -> boot logo / fbcon / console come up at 1080p60 (148.5 MHz), safe. (Previously the
   boot modeset came up at 4K60 / 594 MHz.)

2. **Kodi whitelist** (Settings > System > Display):
   - Resolution: `1920x1080`; Adjust refresh rate: On start/stop
   - Whitelist ONLY sub-340 modes: `1920x1080 @ 23.976/24/25/29.97/30/50/59.94/60` and
     `3840x2160 @ 23.976/24/25/29.97/30`. Do NOT whitelist `2160p50` / `2160p60`.
   - Result: 1080p60 GUI, 4K movies play native at <=30 Hz.

3. **Set the TV itself to HDMI 1.4** (strongest fix; makes the bug structurally
   unreachable):
   - The HDMI Forum VSDB disappears from the EDID. `hdmi->scdc.supported` is set true
     ONLY from that block (`drm_edid.c:5772`, via `drm_parse_hdmi_forum_scds`), so it is
     now **false** -> `dw_hdmi_support_scdc()` returns false -> scrambling block skipped
     for every mode, regardless of `hdmi->update`.
   - EDID also drops all 4K50/60 modes and caps `max_tmds_clock = 300 MHz`, so a
     scrambled link can't be requested at all.
   - **Retained**: 4K @ 24/25/30, HDR10 + HLG, BT.2020, audio passthrough (DD+/TrueHD).
   - **Lost** (unwanted here): 4K @ 50/60, ALLM.

Verified after reboot: console at 1080p, Kodi limits to 4K@<=30 Hz. Considered solved.

## The proper kernel fix (deferred — only needed for a real 4K60 RGB sink)

SCDC scrambling state lives in the sink and can be lost across a sink power-cycle, so
the source must re-assert it on **every** enable of a >340 MHz mode. The `!hdmi->update`
guard on the SCDC block is wrong for the resume-from-sink-power-cycle case.

Preferred fix: in `dw_hdmi_qp_setup`, for `mtmdsclock > HDMI14_MAX_TMDSCLK`, re-assert
`drm_scdc_set_high_tmds_clock_ratio(...,1)` + `drm_scdc_set_scrambling(...,1)` even on
the `update` path — ideally guarded by first reading `SCDC_STATUS_FLAGS` and only
rewriting if the sink shows scrambling disabled (avoids adding the `msleep(100)` glitch
to every seamless fractional-refresh switch). Alternative: force a full modeset
(`update=false`) on resume so the existing path runs.

## Key files / references
- `drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c` — SCDC/scrambling gate (~2574),
  `hdmi->update` set (~3261), `HDMI14_MAX_TMDSCLK` (58), 4:2:0 TMDS halving (~3258)
- `drivers/phy/rockchip/phy-rockchip-samsung-hdptx-hdmi.c` — "locked!" success prints
  (944, 978)
- `drivers/gpu/drm/drm_edid.c` — `scdc.supported` set only via HDMI Forum VSDB (5772, 6015)
- `drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c` — `RK_IF_FORMAT_*`, `force-bus-format`
  DT prop (~1753), `hdmi_output_format` connector property (~304) for forcing 4:2:0
- `drivers/gpu/drm/rockchip/rockchip_drm_vop2.c` — POST_BUF_EMPTY (secondary issue)