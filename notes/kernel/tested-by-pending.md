# Tested-by tags to send (others' series)

Tested-by tags we owe to other people's series: what we tested, and the message to reply to. **Nothing gets sent
without the user's explicit OK.** Reply to the cover letter, or to individual patches if only some were exercised.
After sending, move the entry to "Sent".

Tag: `Tested-by: Ricardo Pardini <ricardo@pardini.net> # Mekotronics R58X-Pro (RK3588)`

## Pending

### Sebastian Reichel: usb: dwc3: introduce Rockchip glue driver v19

- Reply to: `<20261114-b4-rockchip-dwc3-rockchip-glue-v19-0-b79fb5f4b42a@collabora.com>` (cover, 6 patches)
- Tested 2026-11-19 together with usbdp part3 v18 (below), on v7.4-rc3 (Armbian bleedingedge + the R58X-Pro DT with `mode-switch` on usbdp_phy0):
  - `dwc3-rockchip` binds all three DWC3 controllers (fc000000, fc400000, fcd00000)
  - Type-C (FUSB302, source-only): a USB 3.0 2.5G NIC (RTL8156) hotplugged normal → reverse → normal: PHY re-init on every flip (`flipped=yes/no`), SuperSpeed (5000M) each time, no SErrors
  - Cold boot with the NIC plugged in reverse: SuperSpeed
  - Before (plain 7.4): reverse after a hotplug flip only worked after a dwc3 rebind

### Sebastian Reichel: phy: rockchip: usbdp: Fix runtime muxing between USB3 and DP v18

- Reply to: `<20261119-b4-rockchip-usbdp-cleanup-part3-v18-0-fb325e336494@collabora.com>` (cover, 7 patches)
- Tested 2026-11-19 together with the dwc3 glue v19 (above); same tests. Note in the reply: the board DT has `mode-switch` + `orientation-switch` as the v18 cover asks; no DP alt mode (USB3 only, `DP=off (0 lanes)`).

### Sebastian Reichel: usb: typec: fusb302: cleanup device driver probe v1

- Reply to: `<20261113-fusb302-probe-cleanup-v1-0-e5c65a8c58c8@collabora.com>` (cover, 8 patches)
- Tested 2026-11-19: fusb302 probes, tcpm registers; attach/detach in both orientations, PD source caps to `SRC_READY`, VBUS on/off. Same kernel as above.
- Caveat: the "IRQ: PD retry failed" spam during boot also happens without the series.

### Sebastian Reichel: phy: rockchip: inno-usb2: ensure PHY is running when clock is requested v4

- Reply to: `<20261110-phy-rockchip-inno-usb2-clock-fix-v4-0-51acc071634f@collabora.com>` (cover, 5 patches)
- Tested 2026-11-19 (light): boots; USB2 host port (ehci fc880000) enumerates a hub + HID device; Type-C HS side of usb_host0 works (SuperSpeed NIC enumerates through the dwc3 that uses u2phy0). No suspend/resume tested.

### Sebastian Reichel: Synopsys DisplayPort Controller improvements for Rockchip platforms v12

- Reply to: `<20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>` (cover, 23 patches)
- Applied on v7.4-rc3 with prerequisite `941e3acfb358` ("drm/bridge: Do not include <drm/drm_simple_kms_helper.h>", in linux-next): v12 is based on a DRM tree where that include is already gone; without it patch 22 does not apply.
- Tested 2026-11-19 (light): full-size DP (dp1, VP2) to a Dell U3415W: DP-1 connected, 3440x1440 active, no dw-dp errors. Not tested: HPD replug after the update, DP audio, Type-C DP alt mode (not described on this board).

## Sent

(none yet)
