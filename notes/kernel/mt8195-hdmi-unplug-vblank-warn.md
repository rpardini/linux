# MT8195 HDMI unplug: vblank timeout WARN + runtime PM underflow (ETHDR / MDP-RDMA)

Found 2026-11-12 during the K23 hotplug test on the NIO-12L. Status ID: K25. Not analyzed yet; **likely pre-existing (not caused by K23), unverified**.

## Symptom

- NIO-12L, Armbian `7.3.4-edge-genio` + genio-7.3 `3100..3104` (K23 CEC), CAPT-k8s image (no desktop, fbdev console on HDMI).
- On every HDMI unplug (TX → Blade 3 HDMI IN):
  - `mediatek-drm mediatek-drm.9.auto: [drm] vblank wait timed out on crtc 0`
  - `WARNING: drivers/gpu/drm/drm_vblank.c:1329 at drm_crtc_wait_one_vblank`
  - then 9× `Runtime PM usage count underflow!`: `mediatek-disp-ethdr 1c114000.hdr-engine` and `mediatek-mdp-rdma 1c104000..1c10b000.dma-controller`
- Replug works: the picture comes back (Blade 3 locks 3840×2160@30) and CEC re-claims its address.
- Logs: `notes/kernel/mt8195-cec/2026-11-12-hotplug-dmesg.txt` (with `-state.txt` and `-cec-monitor.txt`).

## Trace (both times the same)

```
drm_crtc_wait_one_vblank
mtk_crtc_atomic_disable
drm_atomic_helper_commit_crtc_disable
drm_atomic_helper_commit_tail_rpm
...
drm_client_modeset_commit
__drm_fb_helper_restore_fbdev_mode_unlocked
drm_fb_helper_set_par
drm_fb_helper_hotplug_event
drm_fbdev_client_hotplug
drm_client_dev_hotplug
drm_helper_hpd_irq_event
__mtk_hdmi_v2_isr_thread
mtk_hdmi_v2_isr_thread
```

## Reading so far

- After HPD low, fbdev disables the CRTC. The vblank never arrives because the HDMI link is gone. Then the vdosys1 components (ETHDR, MDP-RDMA via `mtk_disp_ovl_adaptor`) get one runtime-PM put too many.
- K23 patch 3 (`drm/mediatek: hdmi: register a CEC notifier for HDMI v2`) only sets `DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER` + `hdmi_cec_dev`. The notifier runs on detect/HPD and only touches the CEC physical address. None of that code is in the trace.

## To do

1. Prove it's pre-existing: build genio edge without `3102` (or without all of `310x`), unplug once, check dmesg. Or check on the TV session with a stock kernel.
2. Check upstream / lore for `mtk_crtc_atomic_disable` vblank timeout and `ovl_adaptor` / `ethdr` runtime PM underflow on MT8195 HDMI (v7.4+ may already have a fix).
3. Look at `mtk_crtc_atomic_disable()` (vblank wait while the pipe is already stopped) and the `pm_runtime_put` balance in `mtk_disp_ovl_adaptor.c` / `mtk_ethdr.c` / `mtk_mdp_rdma.c`.
4. Matters for the TV test: switching TV inputs or turning the TV off can drop HPD the same way.
