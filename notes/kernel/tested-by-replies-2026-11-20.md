# Tested-by replies to Sebastian Reichel's series (2026-11-20)

Drafts for the user to send from Thunderbird: open the lore link, download the thread mbox, import it, Reply all on
the message the link points to, paste the block. Keep only one "On … wrote:" line if Thunderbird adds its own.
After sending, move the entries in [`tested-by-pending.md`](tested-by-pending.md) to "Sent".

Not included: inno-usb2 clock fix (v5 applied by Vinod Koul on 2026-11-13; we tested v4).

## 1. usb: dwc3: introduce Rockchip glue driver v19

<https://lore.kernel.org/all/20261114-b4-rockchip-dwc3-rockchip-glue-v19-0-b79fb5f4b42a@collabora.com/>

```
On 11/14/26 02:01, Sebastian Reichel wrote:
> The recent Rockchip platforms have a combined PHY, which does USB3 and
> DisplayPort as well as muxing the lines in arbitrary order.
[...]

Thanks for the series! Tested on a Mekotronics R58X-Pro (RK3588,
FUSB302, source-only Type-C) on v7.4-rc3, with usbdp part3 v18:

- RTL8156 2.5G USB NIC, flipped (reverse, normal, reverse): 5 Gbps every 
  time, iperf3 ~1.8 Gbit/s. Before the series, reverse after a flip needed 
  a dwc3 rebind.
- Apple USB-C Digital AV Multiport adapter (A2119): a SanDisk Extreme
  Pro USB 3 stick on it reads ~220 MB/s at 5 Gbps while DP alt mode
  runs, in both orientations.

Tested-by: Ricardo Pardini <ricardo@pardini.net> # Mekotronics R58X-Pro (RK3588)
```

## 2. phy: rockchip: usbdp: Fix runtime muxing between USB3 and DP v18

<https://lore.kernel.org/all/20261119-b4-rockchip-usbdp-cleanup-part3-v18-0-fb325e336494@collabora.com/>

```
On 11/19/26 20:40, Sebastian Reichel wrote:
> This (final) cleanup part depends on new DWC3 glue driver series:
[...]

Thanks for the series! Tested on a Mekotronics R58X-Pro (RK3588,
FUSB302) on v7.4-rc3, with dwc3 glue v19 and dw-dp v12, and with
mode-switch + orientation-switch on usbdp_phy0:

- RTL8156 2.5G USB NIC: 5 Gbps in both orientations, also across
  flips while plugged in.
- Apple USB-C Digital AV Multiport adapter (A2119, pin assignment D):
  DP on 2 lanes plus USB 3 at the same time. 1080p60 on a small HDMI
  monitor and 3440x1440@50 on a Dell U3415W (its HDMI maximum), with a
  SanDisk Extreme Pro at 5 Gbps on the adapter. Works in both
  orientations, and the picture comes back after a flip.

Tested-by: Ricardo Pardini <ricardo@pardini.net> # Mekotronics R58X-Pro (RK3588)
```

## 3. usb: typec: fusb302: cleanup device driver probe v1

<https://lore.kernel.org/all/20261113-fusb302-probe-cleanup-v1-0-e5c65a8c58c8@collabora.com/>

```
On 11/13/26 17:42, Sebastian Reichel wrote:
> Move fusb302 to be fully converted to device managed resources
> instead of having a mix risking leaks and clean up the interrupt
> setup.
[...]

Thanks for the series! Tested on a Mekotronics R58X-Pro (RK3588) on
v7.4-rc3; the FUSB302 drives a source-only Type-C port there.

Probe, attach/detach and flips in both orientations, PD to SRC_READY
and DP alt mode entry all work, with an RTL8156 2.5G USB NIC and an
Apple USB-C Digital AV Multiport adapter (A2119).

Tested-by: Ricardo Pardini <ricardo@pardini.net> # Mekotronics R58X-Pro (RK3588)
```

## 4. Synopsys DisplayPort Controller improvements for Rockchip platforms v12

<https://lore.kernel.org/all/20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com/>

```
On 11/14/26 06:00, Sebastian Reichel wrote:
> This patch series updates the Synopsys Designware DisplayPort bridge
> together with the only existing user: The Rockchip RK3576/RK3588:
[...]

Thanks for the series! Tested on a Mekotronics R58X-Pro (RK3588) on
v7.4-rc3 (it needs 941e3acfb358 from linux-next to apply there):

- dp1, full-size DP: Dell U3415W at 3440x1440.
- dp0, DP alt mode through usbdp_phy0 + FUSB302 with an Apple USB-C
  Digital AV Multiport adapter (A2119, pin assignment D, HBR3 x2):
  1080p60 on a small HDMI monitor and 3440x1440@50 on the Dell's HDMI
  input. Works in both orientations, and out-of-band HPD retrains the
  link after a flip. With the adapter plugged in at boot, this also
  needs your "drm/connector: Cache out-of-band hotplug events".
- Audio on both outputs to the Dell's speakers, over S/PDIF
  (spdif_tx2/tx5, simple-audio-card, mclk-fs 512, DAI 1). It also
  needs a clk core workaround I am not sure about: AUPLL's assigned rate
  rounds to the current rate, so the S/PDIF frac notifiers get
  PRE_RATE_CHANGE without POST_RATE_CHANGE and leave the muxes on the
  gated fractional divider; no DMA requests, EIO.

Tested-by: Ricardo Pardini <ricardo@pardini.net> # Mekotronics R58X-Pro (RK3588)
```

## 5. drm/connector: Cache out-of-band hotplug events v1

<https://lore.kernel.org/all/20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com/>

```
On 8/21/26 16:55, Sebastian Reichel wrote:
> When the USB-C state machine finished negotiating DP AltMode before the
> DRM device has been probed, the out-of-band hotplug events fired to
> early and are lost.
[...]

Thanks for the patch! Tested on a Mekotronics R58X-Pro (RK3588,
FUSB302) on v7.4-rc3 with dw-dp v12 and usbdp part3 v18.

With an Apple USB-C Digital AV Multiport adapter (A2119) plugged in at
boot, HPD arrives about 2 s before dw-dp binds. Without this patch DP
stays disconnected until a replug; with it the display comes up at
boot. I used the rebased copy from your rockchip-devel branch, since v1
no longer applies after the drm_utils.h rename.

Tested-by: Ricardo Pardini <ricardo@pardini.net> # Mekotronics R58X-Pro (RK3588)
```
